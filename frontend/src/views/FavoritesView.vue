<template>
  <div class="favorites-page">
    <Navbar />

    <main class="main-content">
      <div class="page-header">
        <div class="container">
          <h1>我的收藏</h1>
          <p>你收藏的AI工具和提示词都在这里</p>
        </div>
      </div>

      <div class="container" v-if="userStore.isLoggedIn">
        <el-tabs v-model="activeTab" class="favorites-tabs">
          <el-tab-pane label="收藏的工具" name="tools">
            <div class="tools-grid" v-if="favoriteTools.length">
              <ToolCard
                v-for="tool in favoriteTools"
                :key="tool.id"
                :tool="tool"
                @click="$router.push(`/tools/${tool.id}`)"
              />
            </div>
            <EmptyState v-else description="还没有收藏任何工具" icon="Star" />
          </el-tab-pane>

          <el-tab-pane label="收藏的提示词" name="prompts">
            <div class="prompts-grid" v-if="favoritePrompts.length">
              <PromptCard
                v-for="prompt in favoritePrompts"
                :key="prompt.id"
                :prompt="prompt"
                @click="$router.push(`/prompts/${prompt.id}`)"
              />
            </div>
            <EmptyState v-else description="还没有收藏任何提示词" icon="Star" />
          </el-tab-pane>
        </el-tabs>
      </div>

      <div class="not-login" v-else>
        <div class="not-login-card">
          <el-icon :size="64" color="#d1d5db"><Lock /></el-icon>
          <h2>需要登录</h2>
          <p>登录后即可查看和管理你的收藏内容</p>
          <router-link to="/login">
            <el-button type="primary" size="large" round>立即登录</el-button>
          </router-link>
        </div>
      </div>
    </main>

    <Footer />
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue'
import { Lock } from '@element-plus/icons-vue'
import Navbar from '@/components/Navbar.vue'
import Footer from '@/components/Footer.vue'
import ToolCard from '@/components/ToolCard.vue'
import PromptCard from '@/components/PromptCard.vue'
import EmptyState from '@/components/EmptyState.vue'
import { useUserStore } from '@/store'
import { userApi } from '@/api/modules'

const userStore = useUserStore()

const activeTab = ref('tools')
const favoriteTools = ref([])
const favoritePrompts = ref([])

async function fetchFavorites() {
  try {
    const res = await userApi.favorites()
    const data = res.data || {}
    favoriteTools.value = data.tools || data.toolList || []
    favoritePrompts.value = data.prompts || data.promptList || []
  } catch (e) {
    console.error(e)
  }
}

watch(() => userStore.isLoggedIn, (val) => {
  if (val) fetchFavorites()
})

onMounted(() => {
  if (userStore.isLoggedIn) fetchFavorites()
})
</script>

<style scoped>
.favorites-page {
  min-height: 100vh;
}

.main-content {
  padding-top: 64px;
}

.page-header {
  background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
  padding: 48px 0;
  text-align: center;
}

.page-header h1 {
  font-size: 32px;
  font-weight: 700;
  color: white;
  margin-bottom: 8px;
}

.page-header p {
  color: #94a3b8;
  font-size: 16px;
}

.container {
  max-width: 1280px;
  margin: 0 auto;
  padding: 32px 24px 80px;
}

.favorites-tabs {
  margin-top: 8px;
}

.tools-grid,
.prompts-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
  margin-top: 24px;
}

.not-login {
  display: flex;
  justify-content: center;
  padding: 80px 24px;
}

.not-login-card {
  text-align: center;
  background: white;
  border-radius: var(--radius-lg);
  padding: 60px 48px;
  box-shadow: var(--shadow-md);
  max-width: 480px;
}

.not-login-card h2 {
  font-size: 22px;
  font-weight: 700;
  color: var(--text-primary);
  margin: 16px 0 8px;
}

.not-login-card p {
  font-size: 14px;
  color: var(--text-secondary);
  margin-bottom: 24px;
}

@media (max-width: 900px) {
  .tools-grid,
  .prompts-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 640px) {
  .tools-grid,
  .prompts-grid {
    grid-template-columns: 1fr;
  }
}
</style>
