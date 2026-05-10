<template>
  <AdminLayout>
    <div class="banners-manage">
      <div class="toolbar">
        <el-button type="primary" round @click="openDialog()">
          <el-icon><Plus /></el-icon> 添加轮播图
        </el-button>
      </div>

      <el-table :data="list" stripe v-loading="loading" border>
        <el-table-column label="缩略图" width="180" align="center">
          <template #default="{ row }">
            <img :src="row.image_url || defaultImage" alt="" class="banner-thumb" @error="(e) => e.target.src = defaultImage" />
          </template>
        </el-table-column>
        <el-table-column prop="title" label="标题" min-width="160" />
        <el-table-column prop="link_url" label="链接" min-width="200" show-overflow-tooltip />
        <el-table-column prop="sort_order" label="排序" width="80" align="center" />
        <el-table-column label="状态" width="100" align="center">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'info'" size="small">
              {{ row.status === 1 ? '显示' : '隐藏' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="160" align="center" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" link size="small" @click="openDialog(row)">编辑</el-button>
            <el-popconfirm title="确定删除此轮播图？" @confirm="handleDelete(row.id)">
              <template #reference>
                <el-button type="danger" link size="small">删除</el-button>
              </template>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>

      <el-dialog
        v-model="dialogVisible"
        :title="editingId ? '编辑轮播图' : '添加轮播图'"
        width="520px"
        destroy-on-close
      >
        <el-form ref="formRef" :model="form" :rules="rules" label-width="90px">
          <el-form-item label="标题" prop="title">
            <el-input v-model="form.title" placeholder="轮播图标题" />
          </el-form-item>
          <el-form-item label="图片URL" prop="image_url">
            <el-input v-model="form.image_url" placeholder="轮播图片地址" />
          </el-form-item>
          <el-form-item v-if="form.image_url" label="预览">
            <img :src="form.image_url" alt="" class="preview-img" @error="(e) => e.target.style.display='none'" />
          </el-form-item>
          <el-form-item label="链接地址" prop="link_url">
            <el-input v-model="form.link_url" placeholder="点击跳转的链接（可选）" />
          </el-form-item>
          <el-form-item label="描述" prop="description">
            <el-input v-model="form.description" type="textarea" :rows="2" placeholder="轮播图描述文字" />
          </el-form-item>
          <el-form-item label="排序值">
            <el-input-number v-model="form.sort_order" :min="0" :max="99" />
          </el-form-item>
          <el-form-item label="状态">
            <el-switch v-model="form.status" :active-value="1" :inactive-value="0" active-text="显示" inactive-text="隐藏" />
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
import { Plus } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import AdminLayout from '@/components/AdminLayout.vue'
import { bannerApi } from '@/api/modules'

const list = ref([])
const loading = ref(false)
const dialogVisible = ref(false)
const editingId = ref(null)
const submitting = ref(false)

const defaultImage = 'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=300&h=120&fit=crop'

const form = reactive({ title: '', image_url: '', link_url: '', description: '', sort_order: 0, status: 1 })

const rules = {
  title: [{ required: true, message: '请输入标题', trigger: 'blur' }],
  image_url: [{ required: true, message: '请输入图片地址', trigger: 'blur' }]
}

function resetForm() {
  Object.assign(form, { title: '', image_url: '', link_url: '', description: '', sort_order: 0, status: 1 })
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
    const res = await bannerApi.list()
    list.value = res.data?.list || res.data || []
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
      await bannerApi.update(editingId.value, { ...form })
      ElMessage.success('更新成功')
    } else {
      await bannerApi.add({ ...form })
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
    await bannerApi.delete(id)
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
  justify-content: flex-start;
  margin-bottom: 20px;
}

.banner-thumb {
  width: 150px;
  height: 70px;
  border-radius: 8px;
  object-fit: cover;
}

.preview-img {
  max-width: 400px;
  max-height: 160px;
  border-radius: 8px;
  object-fit: cover;
}
</style>
