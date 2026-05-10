<template>
  <AdminLayout>
    <div class="articles-manage">
      <div class="toolbar">
        <el-button type="primary" round @click="openDialog()">
          <el-icon><Plus /></el-icon> 发布文章
        </el-button>
        <el-input
          v-model="keyword"
          placeholder="搜索文章标题..."
          clearable
          style="width: 260px"
          @keyup.enter="fetchList"
          @clear="fetchList"
        >
          <template #prefix><el-icon><Search /></el-icon></template>
        </el-input>
      </div>

      <el-table :data="list" stripe v-loading="loading" border>
        <el-table-column label="封面" width="100" align="center">
          <template #default="{ row }">
            <img :src="row.cover_image || defaultImage" alt="" class="cover-thumb" @error="(e) => e.target.src = defaultImage" />
          </template>
        </el-table-column>
        <el-table-column prop="title" label="标题" min-width="200" show-overflow-tooltip />
        <el-table-column prop="summary" label="摘要" min-width="220" show-overflow-tooltip />
        <el-table-column prop="view_count" label="浏览量" width="90" align="center" />
        <el-table-column prop="created_at" label="发布时间" width="170" />
        <el-table-column label="操作" width="160" align="center" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" link size="small" @click="openDialog(row)">编辑</el-button>
            <el-popconfirm title="确定删除此文章？" @confirm="handleDelete(row.id)">
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
        :title="editingId ? '编辑文章' : '发布文章'"
        width="720px"
        destroy-on-close
      >
        <el-form ref="formRef" :model="form" :rules="rules" label-width="85px">
          <el-form-item label="标题" prop="title">
            <el-input v-model="form.title" placeholder="请输入文章标题" />
          </el-form-item>
          <el-form-item label="封面图URL" prop="cover_image">
            <el-input v-model="form.cover_image" placeholder="封面图片地址" />
          </el-form-item>
          <el-form-item label="摘要" prop="summary">
            <el-input v-model="form.summary" type="textarea" :rows="3" placeholder="文章摘要" />
          </el-form-item>
          <el-form-item label="正文内容" prop="content">
            <el-input v-model="form.content" type="textarea" :rows="12" placeholder="文章正文内容（支持HTML标签）" />
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
import { articleApi } from '@/api/modules'

const list = ref([])
const loading = ref(false)
const dialogVisible = ref(false)
const editingId = ref(null)
const submitting = ref(false)
const keyword = ref('')
const currentPage = ref(1)
const pageSize = 10
const total = ref(0)

const defaultImage = 'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=80&h=50&fit=crop'

const form = reactive({ title: '', cover_image: '', summary: '', content: '' })

const rules = {
  title: [{ required: true, message: '请输入标题', trigger: 'blur' }],
  content: [{ required: true, message: '请输入正文内容', trigger: 'blur' }]
}

function resetForm() {
  Object.assign(form, { title: '', cover_image: '', summary: '', content: '' })
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
    const res = await articleApi.list(params)
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
      await articleApi.update(editingId.value, { ...form })
      ElMessage.success('更新成功')
    } else {
      await articleApi.add({ ...form })
      ElMessage.success('发布成功')
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
    await articleApi.delete(id)
    ElMessage.success('已删除')
    fetchList()
  } catch (e) {
    ElMessage.error('删除失败')
  }
}

onMounted(() => fetchList())
</script>

<style scoped>
.toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.cover-thumb {
  width: 72px;
  height: 42px;
  border-radius: 6px;
  object-fit: cover;
}

.pagination-wrap {
  display: flex;
  justify-content: flex-end;
  margin-top: 20px;
}
</style>
