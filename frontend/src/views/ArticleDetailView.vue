<template>
  <div class="article-detail-page">
    <Navbar />

    <main class="main-content" v-if="!loading">
      <div class="container">
        <div class="back-nav">
          <el-button text @click="$router.back()">
            <el-icon><ArrowLeft /></el-icon> 返回列表
          </el-button>
        </div>

        <article class="detail-card" v-if="article">
          <div class="cover-image">
            <img
              :src="article.cover_image || defaultImage"
              :alt="article.title"
              @error="(e) => e.target.src = defaultImage"
            />
          </div>

          <div class="article-info">
            <h1 class="article-title">{{ article.title }}</h1>
            <div class="meta-row">
              <span class="meta-item">
                <el-icon><Calendar /></el-icon>
                {{ formatDate(article.created_at) }}
              </span>
              <span class="meta-item">
                <el-icon><View /></el-icon>
                {{ article.view_count || 0 }} 次浏览
              </span>
            </div>
          </div>

          <el-divider />

          <div class="article-body" v-html="article.content"></div>
        </article>

        <section class="related-section" v-if="relatedArticles.length">
          <h2>相关文章推荐</h2>
          <div class="related-grid">
            <ArticleCard
              v-for="item in relatedArticles"
              :key="item.id"
              :article="item"
              @click="$router.push(`/articles/${item.id}`)"
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
import { ArrowLeft, Calendar, View } from '@element-plus/icons-vue'
import Navbar from '@/components/Navbar.vue'
import Footer from '@/components/Footer.vue'
import ArticleCard from '@/components/ArticleCard.vue'
import { articleApi } from '@/api/modules'

const route = useRoute()
const article = ref(null)
const relatedArticles = ref([])
const loading = ref(true)

const defaultImage = 'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&h=400&fit=crop'

function formatDate(dateStr) {
  if (!dateStr) return ''
  const date = new Date(dateStr)
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`
}

onMounted(async () => {
  try {
    const res = await articleApi.detail(route.params.id)
    article.value = res.data

    const relRes = await articleApi.list({ page: 1, size: 4 })
    const list = relRes.data?.list || relRes.data || []
    relatedArticles.value = list.filter(a => a.id !== Number(route.params.id)).slice(0, 3)
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
})
</script>

<style scoped>
.article-detail-page {
  min-height: 100vh;
}

.main-content {
  padding-top: 64px;
}

.container {
  max-width: 860px;
  margin: 0 auto;
  padding: 32px 24px 80px;
}

.back-nav {
  margin-bottom: 24px;
}

.detail-card {
  background: white;
  border-radius: var(--radius-lg);
  overflow: hidden;
  box-shadow: var(--shadow-md);
  border: 1px solid var(--border-color);
}

.cover-image {
  width: 100%;
  height: 320px;
  overflow: hidden;
}

.cover-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.article-info {
  padding: 32px 36px 0;
}

.article-title {
  font-size: 28px;
  font-weight: 700;
  color: var(--text-primary);
  line-height: 1.35;
  margin-bottom: 16px;
}

.meta-row {
  display: flex;
  gap: 20px;
  font-size: 14px;
  color: var(--text-light);
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 4px;
}

.article-body {
  padding: 0 36px 40px;
  font-size: 15px;
  line-height: 1.9;
  color: #374151;
}

.article-body :deep(h2) {
  font-size: 22px;
  font-weight: 700;
  color: var(--text-primary);
  margin: 32px 0 16px;
}

.article-body :deep(h3) {
  font-size: 18px;
  font-weight: 600;
  color: var(--text-primary);
  margin: 24px 0 12px;
}

.article-body :deep(p) {
  margin-bottom: 16px;
}

.article-body :deep(img) {
  max-width: 100%;
  border-radius: 10px;
  margin: 16px 0;
}

.article-body :deep(code) {
  background: #f3f4f6;
  padding: 2px 6px;
  border-radius: 4px;
  font-size: 14px;
}

.article-body :deep(pre) {
  background: #1e293b;
  color: #e2e8f0;
  padding: 20px;
  border-radius: 10px;
  overflow-x: auto;
  margin: 16px 0;
}

.article-body :deep(blockquote) {
  border-left: 4px solid var(--primary-color);
  padding-left: 20px;
  margin: 16px 0;
  color: var(--text-secondary);
  font-style: italic;
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
  max-width: 860px;
  margin: 0 auto;
}

@media (max-width: 768px) {
  .related-grid {
    grid-template-columns: 1fr;
  }

  .article-title {
    font-size: 22px;
  }

  .article-info,
  .article-body {
    padding-left: 20px;
    padding-right: 20px;
  }

  .cover-image {
    height: 200px;
  }
}
</style>
