<template>
  <AdminLayout>
    <div class="dashboard">
      <h2 class="page-title">仪表盘</h2>

      <div class="stats-grid">
        <div class="stat-card stat-users">
          <div class="stat-icon"><el-icon :size="32"><User /></el-icon></div>
          <div class="stat-info">
            <span class="stat-value">{{ stats.userCount || 0 }}</span>
            <span class="stat-label">用户总数</span>
          </div>
        </div>
        <div class="stat-card stat-tools">
          <div class="stat-icon"><el-icon :size="32"><Grid /></el-icon></div>
          <div class="stat-info">
            <span class="stat-value">{{ stats.toolCount || 0 }}</span>
            <span class="stat-label">AI工具</span>
          </div>
        </div>
        <div class="stat-card stat-prompts">
          <div class="stat-icon"><el-icon :size="32"><Document /></el-icon></div>
          <div class="stat-info">
            <span class="stat-value">{{ stats.promptCount || 0 }}</span>
            <span class="stat-label">提示词</span>
          </div>
        </div>
        <div class="stat-card stat-articles">
          <div class="stat-icon"><el-icon :size="32"><Reading /></el-icon></div>
          <div class="stat-info">
            <span class="stat-value">{{ stats.articleCount || 0 }}</span>
            <span class="stat-label">文章</span>
          </div>
        </div>
      </div>

      <div class="dashboard-content">
        <div class="quick-actions">
          <h3>快捷操作</h3>
          <div class="action-buttons">
            <router-link to="/admin/tools" class="action-btn">
              <el-icon :size="20"><Plus /></el-icon> 新增工具
            </router-link>
            <router-link to="/admin/prompts" class="action-btn">
              <el-icon :size="20"><Plus /></el-icon> 新增提示词
            </router-link>
            <router-link to="/admin/articles" class="action-btn">
              <el-icon :size="20"><Plus /></el-icon> 发布文章
            </router-link>
            <router-link to="/admin/banners" class="action-btn">
              <el-icon :size="20"><Plus /></el-icon> 添加轮播图
            </router-link>
          </div>
        </div>

        <div class="recent-section">
          <h3>系统信息</h3>
          <div class="info-list">
            <div class="info-item">
              <span class="info-label">系统版本</span>
              <span class="info-value">AIHub Pro v1.0.0</span>
            </div>
            <div class="info-item">
              <span class="info-label">前端框架</span>
              <span class="info-value">Vue 3 + Vite + Element Plus</span>
            </div>
            <div class="info-item">
              <span class="info-label">后端框架</span>
              <span class="info-value">Spring Boot + MyBatis</span>
            </div>
            <div class="info-item">
              <span class="info-label">数据库</span>
              <span class="info-value">MySQL 8.0</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </AdminLayout>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { User, Grid, Document, Reading, Plus } from '@element-plus/icons-vue'
import AdminLayout from '@/components/AdminLayout.vue'
import { adminApi } from '@/api/modules'

const stats = ref({})

onMounted(async () => {
  try {
    const res = await adminApi.statistics()
    stats.value = res.data || {}
  } catch (e) {
    console.error(e)
  }
})
</script>

<style scoped>
.page-title {
  font-size: 22px;
  font-weight: 700;
  color: var(--text-primary);
  margin-bottom: 28px;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
  margin-bottom: 32px;
}

.stat-card {
  background: white;
  border-radius: var(--radius-md);
  padding: 24px;
  display: flex;
  align-items: center;
  gap: 16px;
  box-shadow: var(--shadow-sm);
  border: 1px solid var(--border-color);
}

.stat-icon {
  width: 56px;
  height: 56px;
  border-radius: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  flex-shrink: 0;
}

.stat-users .stat-icon { background: linear-gradient(135deg, #3b82f6, #2563eb); }
.stat-tools .stat-icon { background: linear-gradient(135deg, #10b981, #059669); }
.stat-prompts .stat-icon { background: linear-gradient(135deg, #8b5cf6, #7c3aed); }
.stat-articles .stat-icon { background: linear-gradient(135deg, #f59e0b, #d97706); }

.stat-value {
  display: block;
  font-size: 28px;
  font-weight: 800;
  color: var(--text-primary);
  line-height: 1.2;
}

.stat-label {
  font-size: 13px;
  color: var(--text-light);
}

.dashboard-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
}

.quick-actions,
.recent-section {
  background: white;
  border-radius: var(--radius-md);
  padding: 24px;
  box-shadow: var(--shadow-sm);
  border: 1px solid var(--border-color);
}

.quick-actions h3,
.recent-section h3 {
  font-size: 16px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 18px;
}

.action-buttons {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 10px;
}

.action-btn {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 12px 16px;
  background: #f8fafc;
  border-radius: 10px;
  font-size: 14px;
  font-weight: 500;
  color: var(--text-secondary);
  text-decoration: none;
  transition: all 0.2s;
}

.action-btn:hover {
  background: rgba(16, 185, 129, 0.08);
  color: var(--primary-color);
}

.info-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.info-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 0;
  border-bottom: 1px solid #f3f4f6;
}

.info-item:last-child {
  border-bottom: none;
}

.info-label {
  font-size: 14px;
  color: var(--text-light);
}

.info-value {
  font-size: 14px;
  font-weight: 500;
  color: var(--text-primary);
}

@media (max-width: 900px) {
  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  .dashboard-content {
    grid-template-columns: 1fr;
  }
}
</style>
