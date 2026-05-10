<template>
  <AdminLayout>
    <div class="categories-manage">
      <el-tabs v-model="activeTab" @tab-change="fetchList">
        <el-tab-pane label="工具分类" name="tool">
          <div class="toolbar">
            <el-button type="primary" size="small" round @click="openDialog('tool')">
              <el-icon><Plus /></el-icon> 新增分类
            </el-button>
          </div>
          <el-table :data="toolCatList" stripe v-loading="toolLoading" border>
            <el-table-column prop="id" label="ID" width="80" align="center" />
            <el-table-column prop="name" label="分类名称" min-width="150" />
            <el-table-column prop="icon" label="图标" width="80" align="center">
              <template #default="{ row }">{{ row.icon || '-' }}</template>
            </el-table-column>
            <el-table-column prop="sort_order" label="排序" width="80" align="center" />
            <el-table-column label="操作" width="180" align="center">
              <template #default="{ row }">
                <el-button type="primary" link size="small" @click="openDialog('tool', row)">编辑</el-button>
                <el-popconfirm title="确定删除？" @confirm="handleDelete('tool', row.id)">
                  <template #reference>
                    <el-button type="danger" link size="small">删除</el-button>
                  </template>
                </el-popconfirm>
              </template>
            </el-table-column>
          </el-table>
        </el-tab-pane>

        <el-tab-pane label="提示词分类" name="prompt">
          <div class="toolbar">
            <el-button type="primary" size="small" round @click="openDialog('prompt')">
              <el-icon><Plus /></el-icon> 新增分类
            </el-button>
          </div>
          <el-table :data="promptCatList" stripe v-loading="promptLoading" border>
            <el-table-column prop="id" label="ID" width="80" align="center" />
            <el-table-column prop="name" label="分类名称" min-width="150" />
            <el-table-column prop="description" label="描述" min-width="200" show-overflow-tooltip />
            <el-table-column prop="sort_order" label="排序" width="80" align="center" />
            <el-table-column label="操作" width="180" align="center">
              <template #default="{ row }">
                <el-button type="primary" link size="small" @click="openDialog('prompt', row)">编辑</el-button>
                <el-popconfirm title="确定删除？" @confirm="handleDelete('prompt', row.id)">
                  <template #reference>
                    <el-button type="danger" link size="small">删除</el-button>
                  </template>
                </el-popconfirm>
              </template>
            </el-table-column>
          </el-table>
        </el-tab-pane>
      </el-tabs>

      <el-dialog v-model="dialogVisible" :title="editingId ? '编辑分类' : '新增分类'" width="450px" destroy-on-close>
        <el-form ref="formRef" :model="form" :rules="rules" label-width="85px">
          <el-form-item label="分类名称" prop="name">
            <el-input v-model="form.name" placeholder="请输入分类名称" />
          </el-form-item>
          <el-form-item v-if="activeTab === 'tool'" label="图标">
            <el-input v-model="form.icon" placeholder="emoji或图标名" />
          </el-form-item>
          <el-form-item v-if="activeTab === 'prompt'" label="描述">
            <el-input v-model="form.description" type="textarea" :rows="2" placeholder="分类描述" />
          </el-form-item>
          <el-form-item label="排序值">
            <el-input-number v-model="form.sort_order" :min="0" :max="999" />
          </el-form-item>
        </el-form>
        <template #footer>
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" :loading="submitting" @click="handleSubmit">确定</el-button>
        </template>
      </el-dialog>
    </div>
  </AdminLayout>
</template>

<script setup>
import { ref, reactive, watch, onMounted } from 'vue'
import { Plus } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import AdminLayout from '@/components/AdminLayout.vue'
import { toolCategoryApi, promptCategoryApi } from '@/api/modules'

const activeTab = ref('tool')
const toolCatList = ref([])
const promptCatList = ref([])
const toolLoading = ref(false)
const promptLoading = ref(false)
const dialogVisible = ref(false)
const editingId = ref(null)
const submitting = ref(false)
const currentType = ref('tool')

const form = reactive({ name: '', icon: '', description: '', sort_order: 0 })
const rules = { name: [{ required: true, message: '请输入分类名称', trigger: 'blur' }] }

function resetForm() {
  Object.assign(form, { name: '', icon: '', description: '', sort_order: 0 })
}

function openDialog(type, row) {
  currentType.value = type
  resetForm()
  if (row) {
    editingId.value = row.id
    Object.keys(form).forEach(k => { if (row[k] !== undefined) form[k] = row[k] })
  } else {
    editingId.value = null
  }
  dialogVisible.value = true
}

async function fetchToolCategories() {
  toolLoading.value = true
  try {
    const res = await toolCategoryApi.list()
    toolCatList.value = res.data?.list || res.data || []
  } catch (e) { console.error(e) } finally { toolLoading.value = false }
}

async function fetchPromptCategories() {
  promptLoading.value = true
  try {
    const res = await promptCategoryApi.list()
    promptCatList.value = res.data?.list || res.data || []
  } catch (e) { console.error(e) } finally { promptLoading.value = false }
}

function fetchList() {
  if (activeTab.value === 'tool') fetchToolCategories()
  else fetchPromptCategories()
}

async function handleSubmit() {
  submitting.value = true
  try {
    const api = currentType.value === 'tool' ? toolCategoryApi : promptCategoryApi
    const data = { ...form }
    if (currentType.value === 'prompt') delete data.icon

    if (editingId.value) {
      await api.update(editingId.value, data)
      ElMessage.success('更新成功')
    } else {
      await api.add(data)
      ElMessage.success('添加成功')
    }
    dialogVisible.value = false
    fetchList()
  } catch (e) {
    ElMessage.error(e.message || '操作失败')
  } finally {
    submitting.value = false
  }
}

async function handleDelete(type, id) {
  try {
    const api = type === 'tool' ? toolCategoryApi : promptCategoryApi
    await api.delete(id)
    ElMessage.success('已删除')
    fetchList()
  } catch (e) {
    ElMessage.error('删除失败')
  }
}

onMounted(() => fetchToolCategories())
</script>

<style scoped>
.toolbar {
  margin-bottom: 16px;
}
</style>
