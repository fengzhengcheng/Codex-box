<template>
  <div class="admin-layout">
    <aside class="sidebar" :class="{ collapsed }">
      <div class="sidebar-header">
        <router-link to="/" class="sidebar-logo">
          <span class="logo-icon">⚡</span>
          <span v-show="!collapsed" class="logo-text">AIHub Pro</span>
        </router-link>
        <button class="collapse-btn" @click="collapsed = !collapsed">
          <el-icon><Fold v-if="!collapsed" /><Expand v-else /></el-icon>
        </button>
      </div>

      <nav class="sidebar-nav">
        <router-link
          v-for="item in menuItems"
          :key="item.path"
          :to="item.path"
          class="nav-item"
          :class="{ active: $route.path.startsWith(item.path) }"
        >
          <el-icon :size="18"><component :is="item.icon" /></el-icon>
          <span v-show="!collapsed">{{ item.label }}</span>
        </router-link>
      </nav>
    </aside>

    <div class="main-wrapper">
      <header class="top-bar">
        <div class="breadcrumb">
          <el-breadcrumb separator="/">
            <el-breadcrumb-item :to="{ path: '/admin/dashboard' }">管理后台</el-breadcrumb-item>
            <el-breadcrumb-item>{{ pageTitle }}</el-breadcrumb-item>
          </el-breadcrumb>
        </div>
        <div class="top-right">
          <el-dropdown trigger="click" @command="handleCommand">
            <div class="user-trigger">
              <el-avatar :size="32" :icon="UserFilled" />
              <span>{{ userStore.userInfo.nickname || userStore.userInfo.username }}</span>
            </div>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="home">返回前台</el-dropdown-item>
                <el-dropdown-item command="logout" divided>退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </header>

      <main class="main-content">
        <slot></slot>
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRoute } from 'vue-router'
import { useUserStore } from '@/store'
import {
  DataAnalysis, Grid, Document, FolderOpened, User, Reading, Picture,
  Fold, Expand, UserFilled
} from '@element-plus/icons-vue'

const route = useRoute()
const userStore = useUserStore()
const collapsed = ref(false)

const menuItems = [
  { path: '/admin/dashboard', label: '仪表盘', icon: DataAnalysis },
  { path: '/admin/tools', label: '工具管理', icon: Grid },
  { path: '/admin/prompts', label: '提示词管理', icon: Document },
  { path: '/admin/categories', label: '分类管理', icon: FolderOpened },
  { path: '/admin/users', label: '用户管理', icon: User },
  { path: '/admin/articles', label: '文章管理', icon: Reading },
  { path: '/admin/banners', label: '轮播图管理', icon: Picture }
]

const pageTitle = computed(() => {
  const item = menuItems.find(i => route.path.startsWith(i.path))
  return item ? item.label : '管理后台'
})

function handleCommand(cmd) {
  if (cmd === 'home') {
    window.location.href = '/'
  } else if (cmd === 'logout') {
    userStore.logout()
  }
}
</script>

<style scoped>
.admin-layout {
  display: flex;
  min-height: 100vh;
  background: #f3f4f6;
}

.sidebar {
  width: 240px;
  background: #1f2937;
  color: #e5e7eb;
  display: flex;
  flex-direction: column;
  position: fixed;
  left: 0;
  top: 0;
  bottom: 0;
  z-index: 100;
  transition: width 0.3s;
}

.sidebar.collapsed {
  width: 64px;
}

.sidebar-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 20px 16px;
  border-bottom: 1px solid #374151;
}

.sidebar-logo {
  display: flex;
  align-items: center;
  gap: 10px;
  text-decoration: none;
  color: white;
  font-weight: 700;
  font-size: 17px;
}

.logo-icon {
  font-size: 22px;
}

.collapse-btn {
  background: none;
  border: none;
  color: #9ca3af;
  cursor: pointer;
  padding: 4px;
  border-radius: 6px;
}

.collapse-btn:hover {
  background: #374151;
  color: white;
}

.sidebar-nav {
  flex: 1;
  padding: 12px 8px;
  overflow-y: auto;
}

.nav-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 16px;
  border-radius: 8px;
  color: #9ca3af;
  text-decoration: none;
  font-size: 14px;
  font-weight: 500;
  transition: all 0.2s;
  margin-bottom: 4px;
  white-space: nowrap;
}

.nav-item:hover {
  background: #374151;
  color: #e5e7eb;
}

.nav-item.active {
  background: rgba(16, 185, 129, 0.15);
  color: #10b981;
}

.main-wrapper {
  flex: 1;
  margin-left: 240px;
  display: flex;
  flex-direction: column;
  transition: margin-left 0.3s;
}

.sidebar.collapsed ~ .main-wrapper {
  margin-left: 64px;
}

.top-bar {
  height: 60px;
  background: white;
  border-bottom: 1px solid #e5e7eb;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 24px;
  position: sticky;
  top: 0;
  z-index: 50;
}

.breadcrumb {
  font-size: 14px;
}

.top-right {
  display: flex;
  align-items: center;
}

.user-trigger {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  padding: 4px 12px 4px 4px;
  border-radius: 20px;
  transition: background 0.2s;
}

.user-trigger:hover {
  background: #f3f4f6;
}

.main-content {
  flex: 1;
  padding: 24px;
}
</style>
