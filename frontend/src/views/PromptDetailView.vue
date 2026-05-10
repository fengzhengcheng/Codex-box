<template>
  <div class="prompt-detail-page">
    <Navbar />

    <main class="main-content" v-if="!loading">
      <div class="container">
        <div class="back-nav">
          <el-button text @click="$router.back()">
            <el-icon><ArrowLeft /></el-icon> 返回列表
          </el-button>
        </div>

        <div class="detail-card" v-if="prompt">
          <div class="detail-header">
            <div class="header-left">
              <h1>{{ prompt.title }}</h1>
              <div class="meta-tags">
                <el-tag v-if="prompt.category_name" type="info" effect="plain" round>{{ prompt.category_name }}</el-tag>
                <el-tag v-if="prompt.model_type" effect="plain" round>{{ prompt.model_type }}</el-tag>
              </div>
            </div>
            <div class="header-actions">
              <el-button
                :type="isFavorited ? 'warning' : 'default'"
                round
                @click="toggleFavorite"
                :disabled="!userStore.isLoggedIn"
              >
                <el-icon><Star :filled="isFavorited" /></el-icon>
                {{ isFavorited ? '已收藏' : '收藏' }}
              </el-button>
            </div>
          </div>

          <el-divider />

          <section class="content-section">
            <div class="section-label">
              <el-icon><DocumentCopy /></el-icon>
              提示词内容
            </div>
            <div class="code-block">
              <pre><code>{{ prompt.content }}</code></pre>
              <button class="copy-btn" @click="copyContent">
                <el-icon><CopyDocument /></el-icon> 一键复制
              </button>
            </div>
          </section>

          <section v-if="prompt.usage_guide" class="guide-section">
            <div class="section-label">
              <el-icon><InfoFilled /></el-icon>
              使用说明
            </div>
            <div class="guide-content" v-html="prompt.usage_guide"></div>
          </section>
        </div>

        <section class="related-section" v-if="relatedPrompts.length">
          <h2>相关提示词</h2>
          <div class="related-grid">
            <PromptCard
              v-for="item in relatedPrompts"
              :key="item.id"
              :prompt="item"
              @click="$router.push(`/prompts/${item.id}`)"
            />
          </div>
        </section>
      </div>
    </main>

    <div v-else class="loading-full"><el-skeleton :rows="10" animated /></div>

    <Footer />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ArrowLeft, Star, DocumentCopy, CopyDocument, InfoFilled } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import Navbar from '@/components/Navbar.vue'
import Footer from '@/components/Footer.vue'
import PromptCard from '@/components/PromptCard.vue'
import { useUserStore } from '@/store'
import { promptApi, userApi } from '@/api/modules'

const route = useRoute()
const userStore = useUserStore()

const prompt = ref(null)
const relatedPrompts = ref([])
const loading = ref(true)
const isFavorited = ref(false)

async function copyContent() {
  try {
    await navigator.clipboard.writeText(prompt.value.content)
    ElMessage.success('已复制到剪贴板')
  } catch {
    const textarea = document.createElement('textarea')
    textarea.value = prompt.value.content
    document.body.appendChild(textarea)
    textarea.select()
    document.execCommand('copy')
    document.body.removeChild(textarea)
    ElMessage.success('已复制到剪贴板')
  }
}

async function toggleFavorite() {
  if (!userStore.isLoggedIn) {
    ElMessage.warning('请先登录后再操作')
    return
  }
  try {
    if (isFavorited.value) {
      await userApi.removeFavorite('prompt', prompt.value.id)
      ElMessage.success('已取消收藏')
      isFavorited.value = false
    } else {
      await userApi.addFavorite('prompt', prompt.value.id)
      ElMessage.success('已添加到收藏')
      isFavorited.value = true
    }
  } catch (e) {
    console.error(e)
  }
}

onMounted(async () => {
  try {
    const res = await promptApi.detail(route.params.id)
    prompt.value = res.data

    if (prompt.value?.category_id) {
      const relRes = await promptApi.list({ categoryId: prompt.value.category_id, size: 4 })
      relatedPrompts.value = (relRes.data?.list || relRes.data || []).filter(p => p.id !== Number(route.params.id)).slice(0, 3)
    }

    if (userStore.isLoggedIn) {
      try {
        const favRes = await userApi.favorites()
        const favs = favRes.data?.prompts || []
        isFavorited.value = favs.some(f => f.id === Number(route.params.id))
      } catch {}
    }
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
})
</script>

<style scoped>
.prompt-detail-page {
  min-height: 100vh;
}

.main-content {
  padding-top: 64px;
}

.container {
  max-width: 960px;
  margin: 0 auto;
  padding: 32px 24px 80px;
}

.back-nav {
  margin-bottom: 24px;
}

.detail-card {
  background: white;
  border-radius: var(--radius-lg);
  padding: 40px;
  box-shadow: var(--shadow-md);
  border: 1px solid var(--border-color);
}

.detail-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
}

.header-left h1 {
  font-size: 26px;
  font-weight: 700;
  color: var(--text-primary);
  margin-bottom: 12px;
}

.meta-tags {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.code-block {
  position: relative;
  background: #1e293b;
  border-radius: 12px;
  padding: 24px;
  overflow-x: auto;
}

.code-block pre {
  margin: 0;
  color: #e2e8f0;
  font-size: 14px;
  line-height: 1.7;
  font-family: 'Monaco', 'Menlo', monospace;
  white-space: pre-wrap;
  word-break: break-word;
}

.copy-btn {
  position: absolute;
  top: 12px;
  right: 12px;
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 6px 14px;
  background: rgba(255,255,255,0.1);
  border: 1px solid rgba(255,255,255,0.15);
  border-radius: 8px;
  color: #cbd5e1;
  font-size: 13px;
  cursor: pointer;
  transition: all 0.2s;
}

.copy-btn:hover {
  background: var(--secondary-color);
  border-color: var(--secondary-color);
  color: white;
}

.section-label {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 17px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 16px;
}

.guide-section {
  margin-top: 32px;
}

.guide-content {
  font-size: 15px;
  line-height: 1.8;
  color: var(--text-secondary);
}

.guide-content :deep(p) {
  margin-bottom: 12px;
}

.related-section {
  margin-top: 48px;
}

.related-section h2 {
  font-size: 22px;
  font-weight: 700;
  color: var(--text-primary);
  margin-bottom: 24px;
}

.related-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
}

.loading-full {
  padding: 120px 24px;
  max-width: 960px;
  margin: 0 auto;
}

@media (max-width: 768px) {
  .detail-header {
    flex-direction: column;
    gap: 16px;
  }

  .related-grid {
    grid-template-columns: 1fr;
  }

  .detail-card {
    padding: 24px;
  }
}
</style>
