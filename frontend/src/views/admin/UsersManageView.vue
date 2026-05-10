<template>
  <AdminLayout>
    <div class="users-manage">
      <div class="toolbar">
        <el-input
          v-model="keyword"
          placeholder="搜索用户名/昵称/邮箱..."
          clearable
          style="width: 300px"
          @keyup.enter="fetchList"
          @clear="fetchList"
        >
          <template #prefix><el-icon><Search /></el-icon></template>
        </el-input>
      </div>

      <el-table :data="list" stripe v-loading="loading" border>
        <el-table-column prop="id" label="ID" width="70" align="center" />
        <el-table-column prop="username" label="用户名" width="130" />
        <el-table-column prop="nickname" label="昵称" width="130" />
        <el-table-column prop="email" label="邮箱" min-width="180" />
        <el-table-column label="状态" width="100" align="center">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'danger'" size="small">
              {{ row.status === 1 ? '正常' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="角色" width="100" align="center">
          <template #default="{ row }">
            <el-tag :type="row.role === 'admin' ? 'warning' : 'info'" size="small">
              {{ row.role === 'admin' ? '管理员' : '普通用户' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="created_at" label="注册时间" width="170" />
        <el-table-column label="操作" width="180" align="center" fixed="right">
          <template #default="{ row }">
            <el-switch
              :model-value="row.status === 1"
              active-text="启用"
              inactive-text="禁用"
              inline-prompt
              @change="(val) => handleToggleStatus(row, val)"
            />
            <el-popconfirm title="确定删除此用户？" @confirm="handleDelete(row.id)">
              <template #reference>
                <el-button type="danger" link size="small" style="margin-left:8px">删除</el-button>
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
    </div>
  </AdminLayout>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { Search } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import AdminLayout from '@/components/AdminLayout.vue'
import { adminUserApi } from '@/api/modules'

const list = ref([])
const loading = ref(false)
const keyword = ref('')
const currentPage = ref(1)
const pageSize = 10
const total = ref(0)

async function fetchList() {
  loading.value = true
  try {
    const params = { page: currentPage.value, size: pageSize }
    if (keyword.value) params.keyword = keyword.value
    const res = await adminUserApi.list(params)
    list.value = res.data?.list || res.data || []
    total.value = res.data?.total || list.value.length
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
}

async function handleToggleStatus(user, val) {
  try {
    await adminUserApi.updateStatus(user.id, val ? 1 : 0)
    ElMessage.success(val ? '已启用' : '已禁用')
    user.status = val ? 1 : 0
  } catch (e) {
    ElMessage.error('操作失败')
  }
}

async function handleDelete(id) {
  try {
    await adminUserApi.delete(id)
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
  justify-content: flex-end;
  margin-bottom: 20px;
}

.pagination-wrap {
  display: flex;
  justify-content: flex-end;
  margin-top: 20px;
}
</style>
