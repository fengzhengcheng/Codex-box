<template>
  <AdminLayout>
    <div class="tools-manage">
      <div class="toolbar">
        <el-button type="primary" round @click="openDialog()">
          <el-icon><Plus /></el-icon> 新增工具
        </el-button>
        <el-input
          v-model="keyword"
          placeholder="搜索工具名称..."
          clearable
          style="width: 260px"
          @keyup.enter="fetchList"
          @clear="fetchList"
        >
          <template #prefix><el-icon><Search /></el-icon></template>
        </el-input>
      </div>

      <el-table :data="list" stripe v-loading="loading" border>
        <el-table-column label="Logo" width="80" align="center">
          <template #default="{ row }">
            <img :src="row.logo || defaultLogo" alt="" class="table-logo" @error="(e) => e.target.src = defaultLogo" />
          </template>
        </el-table-column>
        <el-table-column prop="name" label="名称" min-width="140" />
        <el-table-column prop="category_name" label="分类" width="120" />
        <el-table-column label="是否免费" width="100" align="center">
          <template #default="{ row }">
            <el-tag :type="row.is_free ? 'success' : 'info'" size="small">{{ row.is_free ? '免费' : '付费' }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="rating" label="评分" width="90" align="center">
          <template #default="{ row }">
            {{ row.rating?.toFixed(1) || '-' }}
          </template>
        </el-table-column>
        <el-table-column prop="view_count" label="浏览量" width="90" align="center" />
        <el-table-column label="操作" width="160" align="center" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" link size="small" @click="openDialog(row)">编辑</el-button>
            <el-popconfirm title="确定删除此工具？" @confirm="handleDelete(row.id)">
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
        :title="editingId ? '编辑工具' : '新增工具'"
        width="560px"
        destroy-on-close
      >
        <el-form ref="formRef" :model="form" :rules="rules" label-width="90px">
          <el-form-item label="工具名称" prop="name">
            <el-input v-model="form.name" placeholder="请输入工具名称" />
          </el-form-item>
          <el-form-item label="Logo URL" prop="logo">
            <el-input v-model="form.logo" placeholder="Logo图片地址" />
          </el-form-item>
          <el-form-item label="分类" prop="category_id">
            <el-select v-model="form.category_id" placeholder="选择分类" style="width:100%">
              <el-option v-for="c in categories" :key="c.id" :label="c.name" :value="c.id" />
            </el-select>
          </el-form-item>
          <el-form-item label="简介" prop="description">
            <el-input v-model="form.description" type="textarea" :rows="2" placeholder="简短描述" />
          </el-form-item>
          <el-form-item label="详细介绍" prop="detail">
            <el-input v-model="form.detail" type="textarea" :rows="4" placeholder="详细描述（支持HTML）" />
          </el-form-item>
          <el-form-item label="官网地址" prop="website_url">
            <el-input v-model="form.website_url" placeholder="https://" />
          </el-form-item>
          <el-form-item label="标签" prop="tags">
            <el-input v-model="tagsStr" placeholder="用逗号分隔，如：文本生成,AI助手" />
          </el-form-item>
          <el-form-item label="评分" prop="rating">
            <el-rate v-model="form.rating" :max="5" show-score />
          </el-form-item>
          <el-form-item label="是否免费">
            <el-switch v-model="form.is_free" />
          </el-form-item>
          <el-form-item label="推荐">
            <el-switch v-model="form.is_recommended" />
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
import { ref, reactive, onMounted, computed } from 'vue'
import { Plus, Search } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import AdminLayout from '@/components/AdminLayout.vue'
import { toolApi, toolCategoryApi } from '@/api/modules'

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

const defaultLogo = 'https://ui-avatars.com/api/?name=AI&background=10b981&color=fff&size=40'

const form = reactive({
  name: '', logo: '', category_id: null, description: '',
  detail: '', website_url: '', rating: 4.5, is_free: true, is_recommended: false
})
const tagsStr = ref('')

const rules = {
  name: [{ required: true, message: '请输入工具名称', trigger: 'blur' }],
  description: [{ required: true, message: '请输入简介', trigger: 'blur' }]
}

function resetForm() {
  Object.assign(form, { name: '', logo: '', category_id: null, description: '', detail: '', website_url: '', rating: 4.5, is_free: true, is_recommended: false })
  tagsStr.value = ''
}

function openDialog(row) {
  resetForm()
  if (row) {
    editingId.value = row.id
    Object.keys(form).forEach(k => { if (row[k] !== undefined) form[k] = row[k] })
    tagsStr.value = Array.isArray(row.tags) ? row.tags.join(',') : row.tags || ''
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
    const res = await toolApi.list(params)
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
    const data = { ...form, tags: tagsStr.value.split(',').map(t => t.trim()).filter(Boolean) }
    if (editingId.value) {
      await toolApi.update(editingId.value, data)
      ElMessage.success('更新成功')
    } else {
      await toolApi.add(data)
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
    await toolApi.delete(id)
    ElMessage.success('已删除')
    fetchList()
  } catch (e) {
    ElMessage.error('删除失败')
  }
}

onMounted(() => {
  fetchList()
  toolCategoryApi.list().then(res => { categories.value = res.data?.list || res.data || [] }).catch(() => {})
})
</script>

<style scoped>
.toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.table-logo {
  width: 40px;
  height: 40px;
  border-radius: 8px;
  object-fit: cover;
}

.pagination-wrap {
  display: flex;
  justify-content: flex-end;
  margin-top: 20px;
}
</style>
