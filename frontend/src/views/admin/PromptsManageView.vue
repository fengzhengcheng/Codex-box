<template>
  <AdminLayout>
    <div class="prompts-manage">
      <div class="toolbar">
        <el-button type="primary" round @click="openDialog()">
          <el-icon><Plus /></el-icon> 新增提示词
        </el-button>
        <el-input
          v-model="keyword"
          placeholder="搜索提示词..."
          clearable
          style="width: 260px"
          @keyup.enter="fetchList"
          @clear="fetchList"
        >
          <template #prefix><el-icon><Search /></el-icon></template>
        </el-input>
      </div>

      <el-table :data="list" stripe v-loading="loading" border>
        <el-table-column prop="id" label="ID" width="70" align="center" />
        <el-table-column prop="title" label="标题" min-width="180" show-overflow-tooltip />
        <el-table-column prop="category_name" label="分类" width="120" />
        <el-table-column prop="model_type" label="适用模型" width="130" />
        <el-table-column prop="view_count" label="浏览量" width="90" align="center" />
        <el-table-column prop="like_count" label="点赞数" width="90" align="center" />
        <el-table-column label="操作" width="160" align="center" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" link size="small" @click="openDialog(row)">编辑</el-button>
            <el-popconfirm title="确定删除此提示词？" @confirm="handleDelete(row.id)">
              <template #reference>
                <el-button type="danger" link size="small">删除</el-button>
              </template>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination-wrap" v-if="total > pageSize">
        <el-pagination
          v-model:current-page="currentPage"
          :page-size="pageSize"
          :total="total"
          layout="total, prev, pager, next"
          @current-change="fetchList"
        />
      </div>

      <el-dialog
        v-model="dialogVisible"
        :title="editingId ? '编辑提示词' : '新增提示词'"
        width="600px"
        destroy-on-close
      >
        <el-form ref="formRef" :model="form" :rules="rules" label-width="95px">
          <el-form-item label="标题" prop="title">
            <el-input v-model="form.title" placeholder="请输入标题" />
          </el-form-item>
          <el-form-item label="分类" prop="category_id">
            <el-select v-model="form.category_id" placeholder="选择分类" style="width:100%">
              <el-option v-for="c in categories" :key="c.id" :label="c.name" :value="c.id" />
            </el-select>
          </el-form-item>
          <el-form-item label="适用模型" prop="model_type">
            <el-select v-model="form.model_type" placeholder="选择模型" style="width:100%" allow-create filterable>
              <el-option label="GPT-4o" value="GPT-4o" />
              <el-option label="Claude 3.5" value="Claude 3.5" />
              <el-option label="Gemini Pro" value="Gemini Pro" />
              <el-option label="DeepSeek-V3" value="DeepSeek-V3" />
              <el-option label="Kimi K2" value="Kimi K2" />
              <el-option label="通义千问" value="通义千问" />
              <el-option label="Llama 3" value="Llama 3" />
              <el-option label="通用" value="通用" />
            </el-select>
          </el-form-item>
          <el-form-item label="描述" prop="description">
            <el-input v-model="form.description" type="textarea" :rows="2" placeholder="简短描述" />
          </el-form-item>
          <el-form-item label="提示词内容" prop="content">
            <el-input v-model="form.content" type="textarea" :rows="8" placeholder="完整的提示词内容" />
          </el-form-item>
          <el-form-item label="使用说明" prop="usage_guide">
            <el-input v-model="form.usage_guide" type="textarea" :rows="3" placeholder="使用说明（支持HTML）" />
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
import { ref, reactive, onMounted } from 'vue'
import { Plus, Search } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import AdminLayout from '@/components/AdminLayout.vue'
import { promptApi, promptCategoryApi } from '@/api/modules'

const list = ref([])
const categories = ref([])
const loading = ref(false)
const dialogVisible = ref(false)
const editingId = ref(null)
const submitting = ref(false)
const keyword = ref('')
const currentPage = ref(1)
const pageSize = 10
const total = ref(0)

const form = reactive({
  title: '', category_id: null, model_type: '', description: '', content: '', usage_guide: ''
})

const rules = {
  title: [{ required: true, message: '请输入标题', trigger: 'blur' }],
  content: [{ required: true, message: '请输入提示词内容', trigger: 'blur' }]
}

function resetForm() {
  Object.assign(form, { title: '', category_id: null, model_type: '', description: '', content: '', usage_guide: '' })
}

function openDialog(row) {
  resetForm()
  if (row) {
    editingId.value = row.id
    Object.keys(form).forEach(k => { if (row[k] !== undefined) form[k] = row[k] })
  } else {
    editingId.value = null
  }
  dialogVisible.value = true
}

async function fetchList() {
  loading.value = true
  try {
    const params = { page: currentPage.value, size: pageSize }
    if (keyword.value) params.keyword = keyword.value
    const res = await promptApi.list(params)
    list.value = res.data?.list || res.data || []
    total.value = res.data?.total || list.value.length
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
}

async function handleSubmit() {
  submitting.value = true
  try {
    if (editingId.value) {
      await promptApi.update(editingId.value, { ...form })
      ElMessage.success('更新成功')
    } else {
      await promptApi.add({ ...form })
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

async function handleDelete(id) {
  try {
    await promptApi.delete(id)
    ElMessage.success('已删除')
    fetchList()
  } catch (e) {
    ElMessage.error('删除失败')
  }
}

onMounted(() => {
  fetchList()
  promptCategoryApi.list().then(res => { categories.value = res.data?.list || res.data || [] }).catch(() => {})
})
</script>

<style scoped>
.toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.pagination-wrap {
  display: flex;
  justify-content: flex-end;
  margin-top: 20px;
}
</style>
