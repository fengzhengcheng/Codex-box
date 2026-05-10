<template>
  <nav class="navbar">
    <div class="navbar-container">
      <div class="navbar-left">
        <router-link to="/" class="logo">
          <span class="logo-icon">⚡</span>
          <span class="logo-text">AIHub<span class="logo-highlight">Pro</span></span>
        </router-link>
        <div class="nav-links" :class="{ active: mobileMenuOpen }">
          <router-link to="/" @click="mobileMenuOpen = false">首页</router-link>
          <router-link to="/tools" @click="mobileMenuOpen = false">AI工具</router-link>
          <router-link to="/prompts" @click="mobileMenuOpen = false">提示词库</router-link>
          <router-link to="/models" @click="mobileMenuOpen = false">模型对比</router-link>
          <router-link to="/articles" @click="mobileMenuOpen = false">教程文章</router-link>
        </div>
      </div>

      <div class="navbar-right">
        <div class="nav-search">
          <el-input
            v-model="searchQuery"
            placeholder="搜索AI工具、提示词..."
            :prefix-icon="Search"
            clearable
            @keyup.enter="handleSearch"
            @clear="handleSearch"
          />
        </div>

        <div v-if="userStore.isLoggedIn" class="user-area">
          <el-dropdown trigger="click" @command="handleCommand">
            <div class="user-info">
              <el-avatar :size="32" :icon="UserFilled" />
              <span class="username">{{ userStore.userInfo.nickname || userStore.userInfo.username }}</span>
            </div>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="favorites">我的收藏</el-dropdown-item>
                <el-dropdown-item v-if="userStore.isAdmin" command="admin">管理后台</el-dropdown-item>
                <el-dropdown-item command="logout" divided>退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>

        <div v-else class="auth-buttons">
          <router-link to="/login" class="btn-login">登录</router-link>
          <router-link to="/register" class="btn-register">注册</router-link>
        </div>

        <button class="hamburger" @click="mobileMenuOpen = !mobileMenuOpen" :class="{ active: mobileMenuOpen }">
          <span></span>
          <span></span>
          <span></span>
        </button>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { Search, UserFilled } from '@element-plus/icons-vue'
import { useUserStore } from '@/store'

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()
const searchQuery = ref('')
const mobileMenuOpen = ref(false)

function handleSearch() {
  if (searchQuery.value.trim()) {
    router.push({ path: '/tools', query: { keyword: searchQuery.value.trim() } })
  }
}

function handleCommand(command) {
  switch (command) {
    case 'favorites':
      router.push('/favorites')
      break
    case 'admin':
      router.push('/admin/dashboard')
      break
    case 'logout':
      userStore.logout()
      break
  }
}
</script>

<style scoped>
.navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  border-bottom: 1px solid var(--border-color);
  height: 64px;
}

.navbar-container {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 24px;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.navbar-left {
  display: flex;
  align-items: center;
  gap: 40px;
}

.logo {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 20px;
  font-weight: 700;
  color: var(--text-primary);
  text-decoration: none;
}

.logo-icon {
  font-size: 24px;
}

.logo-highlight {
  color: var(--primary-color);
}

.nav-links {
  display: flex;
  gap: 8px;
}

.nav-links a {
  padding: 8px 16px;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 500;
  color: var(--text-secondary);
  transition: all 0.2s;
  text-decoration: none;
}

.nav-links a:hover,
.nav-links a.router-link-active {
  color: var(--primary-color);
  background: rgba(16, 185, 129, 0.08);
}

.navbar-right {
  display: flex;
  align-items: center;
  gap: 16px;
}

.nav-search {
  width: 240px;
}

.nav-search :deep(.el-input__wrapper) {
  border-radius: 20px;
  background: #f3f4f6;
  box-shadow: none;
  border: 1px solid transparent;
}

.nav-search :deep(.el-input__wrapper:hover),
.nav-search :deep(.el-input__wrapper.is-focus) {
  border-color: var(--primary-color);
  background: #fff;
}

.user-area {
  display: flex;
  align-items: center;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  padding: 4px 12px 4px 4px;
  border-radius: 20px;
  transition: background 0.2s;
}

.user-info:hover {
  background: #f3f4f6;
}

.username {
  font-size: 14px;
  font-weight: 500;
  color: var(--text-primary);
}

.auth-buttons {
  display: flex;
  gap: 8px;
}

.btn-login,
.btn-register {
  padding: 8px 18px;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 500;
  text-decoration: none;
  transition: all 0.2s;
}

.btn-login {
  color: var(--text-primary);
  border: 1px solid var(--border-color);
}

.btn-login:hover {
  border-color: var(--primary-color);
  color: var(--primary-color);
}

.btn-register {
  background: var(--primary-color);
  color: white;
}

.btn-register:hover {
  background: var(--primary-hover);
}

.hamburger {
  display: none;
  flex-direction: column;
  gap: 5px;
  padding: 8px;
  background: none;
  border: none;
  cursor: pointer;
}

.hamburger span {
  width: 22px;
  height: 2px;
  background: var(--text-primary);
  border-radius: 2px;
  transition: all 0.3s;
}

.hamburger.active span:nth-child(1) {
  transform: rotate(45deg) translate(5px, 5px);
}

.hamburger.active span:nth-child(2) {
  opacity: 0;
}

.hamburger.active span:nth-child(3) {
  transform: rotate(-45deg) translate(5px, -5px);
}

@media (max-width: 900px) {
  .nav-links {
    display: none;
    position: absolute;
    top: 64px;
    left: 0;
    right: 0;
    background: white;
    flex-direction: column;
    padding: 16px;
    border-bottom: 1px solid var(--border-color);
    box-shadow: var(--shadow-lg);
  }

  .nav-links.active {
    display: flex;
  }

  .nav-links a {
    padding: 12px 16px;
  }

  .nav-search {
    display: none;
  }

  .hamburger {
    display: flex;
  }

  .username {
    display: none;
  }
}
</style>
