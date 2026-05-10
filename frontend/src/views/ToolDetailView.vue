<template>
  <div class="tool-detail-page">
    <Navbar />

    <main class="main-content" v-if="!loading">
      <div class="container">
        <div class="back-nav">
          <el-button text @click="$router.back()">
            <el-icon><ArrowLeft /></el-icon> 返回列表
          </el-button>
        </div>

        <div class="detail-card" v-if="tool">
          <div class="detail-header">
            <img
              :src="tool.logo || defaultLogo"
              :alt="tool.name"
              class="tool-logo-large"
              @error="(e) => e.target.src = defaultLogo"
            />
            <div class="header-info">
              <h1>{{ tool.name }}</h1>
              <div class="meta-badges">
                <el-tag v-if="tool.is_free" type="success" effect="dark" round>免费使用</el-tag>
                <el-tag v-if="tool.is_recommended" type="danger" effect="dark" round>编辑推荐</el-tag>
                <el-tag v-if="tool.category_name" type="info" plain round>{{ tool.category_name }}</el-tag>
              </div>
              <div class="rating-row" v-if="tool.rating">
                <el-rate
                  :model-value="tool.rating"
                  disabled
                  :colors="['#10b981', '#10b981', '#10b981']"
                />
                <span class="rating-num">{{ tool.rating.toFixed(1) }} / 5.0</span>
              </div>
            </div>
            <div class="header-actions">
              <el-button
                type="primary"
                size="large"
                round
                @click="visitWebsite"
              >
                <el-icon><Link /></el-icon> 访问官网
              </el-button>
              <el-button
                :type="isFavorited ? 'warning' : 'default'"
                size="large"
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

          <div class="detail-body">
            <section class="desc-section">
              <h2>详细介绍</h2>
              <div class="rich-text" v-html="tool.detail || tool.description || tool.intro"></div>
            </section>

            <section v-if="tool.use_cases">
              <h2>适用场景</h2>
              <div class="use-cases">
                <div v-for="(uc, i) in parseUseCases(tool.use_cases)" :key="i" class="use-case-item">
                  <el-icon><Check /></el-icon>
                  <span>{{ uc }}</span>
                </div>
              </div>
            </section>

            <section v-if="tool.tags && tool.tags.length">
              <h2>相关标签</h2>
              <div class="tags-list">
                <el-tag v-for="tag in tool.tags" :key="tag" round effect="plain">{{ tag }}</el-tag>
              </div>
            </section>
          </div>
        </div>

        <section class="related-section" v-if="relatedTools.length">
          <h2>同类推荐工具</h2>
          <div class="related-grid">
            <ToolCard
              v-for="item in relatedTools"
              :key="item.id"
              :tool="item"
              @click="$router.push(`/tools/${item.id}`)"
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
import { ArrowLeft, Link, Star, Check } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import Navbar from '@/components/Navbar.vue'
import Footer from '@/components/Footer.vue'
import ToolCard from '@/components/ToolCard.vue'
import { useUserStore } from '@/store'
import { toolApi, userApi } from '@/api/modules'

const route = useRoute()
const userStore = useUserStore()

const tool = ref(null)
const relatedTools = ref([])
const loading = ref(true)
const isFavorited = ref(false)

const defaultLogo = 'https://ui-avatars.com/api/?name=AI&background=10b981&color=fff&size=120'

function parseUseCases(str) {
  if (!str) return []
  if (Array.isArray(str)) return str
  try {
    const parsed = JSON.parse(str)
    return Array.isArray(parsed) ? parsed : [str]
  } catch {
    return str.split(/[,，]/).map(s => s.trim()).filter(Boolean)
  }
}

function visitWebsite() {
  if (tool.value?.website_url) {
    window.open(tool.value.website_url, '_blank')
  }
}

async function toggleFavorite() {
  if (!userStore.isLoggedIn) {
    ElMessage.warning('请先登录后再操作')
    return
  }
  try {
    if (isFavorited.value) {
      await userApi.removeFavorite('tool', tool.value.id)
      ElMessage.success('已取消收藏')
      isFavorited.value = false
    } else {
      await userApi.addFavorite('tool', tool.value.id)
      ElMessage.success('已添加到收藏')
      isFavorited.value = true
    }
  } catch (e) {
    console.error(e)
  }
}

onMounted(async () => {
  try {
    const res = await toolApi.detail(route.params.id)
    tool.value = res.data

    if (tool.value?.category_id) {
      const relRes = await toolApi.list({ categoryId: tool.value.category_id, size: 4 })
      relatedTools.value = (relRes.data?.list || relRes.data || []).filter(t => t.id !== Number(route.params.id)).slice(0, 3)
    }

    if (userStore.isLoggedIn) {
      try {
        const favRes = await userApi.favorites()
        const favs = favRes.data?.tools || favRes.data || []
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
.tool-detail-page {
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
  gap: 28px;
  align-items: flex-start;
}

.tool-logo-large {
  width: 96px;
  height: 96px;
  border-radius: 24px;
  object-fit: cover;
  background: #f3f4f6;
  flex-shrink: 0;
}

.header-info {
  flex: 1;
}

.header-info h1 {
  font-size: 28px;
  font-weight: 700;
  color: var(--text-primary);
  margin-bottom: 12px;
}

.meta-badges {
  display: flex;
  gap: 8px;
  margin-bottom: 12px;
  flex-wrap: wrap;
}

.rating-row {
  display: flex;
  align-items: center;
  gap: 10px;
}

.rating-num {
  font-size: 15px;
  font-weight: 600;
  color: var(--text-primary);
}

.header-actions {
  display: flex;
  flex-direction: column;
  gap: 10px;
  flex-shrink: 0;
}

.detail-body section {
  margin-top: 32px;
}

.detail-body h2 {
  font-size: 20px;
  font-weight: 700;
  color: var(--text-primary);
  margin-bottom: 16px;
}

.rich-text {
  font-size: 15px;
  line-height: 1.8;
  color: var(--text-secondary);
}

.rich-text :deep(p) {
  margin-bottom: 12px;
}

.rich-text :deep(h3),
.rich-text :deep(h4) {
  margin: 20px 0 10px;
  color: var(--text-primary);
}

.use-cases {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 12px;
}

.use-case-item {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 12px 16px;
  background: #f8fafc;
  border-radius: 10px;
  font-size: 14px;
  color: var(--text-secondary);
}

.use-case-item .el-icon {
  color: var(--primary-color);
  font-size: 18px;
}

.tags-list {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
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
    align-items: center;
    text-align: center;
  }

  .header-actions {
    flex-direction: row;
    width: 100%;
    justify-content: center;
  }

  .use-cases {
    grid-template-columns: 1fr;
  }

  .related-grid {
    grid-template-columns: 1fr;
  }

  .detail-card {
    padding: 24px;
  }
}
</style>
