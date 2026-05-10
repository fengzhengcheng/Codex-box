<template>
  <div class="articles-page">
    <Navbar />

    <main class="main-content">
      <div class="page-header">
        <div class="container">
          <h1>教程文章</h1>
          <p>深入学习AI使用技巧与最佳实践</p>
        </div>
      </div>

      <div class="container">
        <div class="articles-grid" v-if="articles.length && !loading">
          <ArticleCard
            v-for="article in articles"
            :key="article.id"
            :article="article"
            @click="$router.push(`/articles/${article.id}`)"
          />
        </div>

        <EmptyState v-else-if="!loading && !articles.length" description="暂无文章数据" />

        <div class="loading-wrapper" v-if="loading">
          <el-skeleton :rows="5" animated />
        </div>

        <div class="pagination" v-if="total > pageSize">
          <el-pagination
            v-model:current-page="currentPage"
            :page-size="pageSize"
            :total="total"
            layout="prev, pager, next"
            @current-change="fetchArticles"
          />
        </div>
      </div>
    </main>

    <Footer />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import Navbar from '@/components/Navbar.vue'
import Footer from '@/components/Footer.vue'
import ArticleCard from '@/components/ArticleCard.vue'
import EmptyState from '@/components/EmptyState.vue'
import { articleApi } from '@/api/modules'

const articles = ref([])
const loading = ref(false)
const currentPage = ref(1)
const pageSize = 9
const total = ref(0)

async function fetchArticles() {
  loading.value = true
  try {
    const res = await articleApi.list({ page: currentPage.value, size: pageSize })
    articles.value = res.data?.list || res.data || []
    total.value = res.data?.total || articles.value.length
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
}

onMounted(() => fetchArticles())
</script>

<style scoped>
.articles-page {
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
  padding: 0 24px;
}

.articles-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 28px;
  padding: 40px 0 48px;
}

.loading-wrapper {
  padding: 48px 0;
}

.pagination {
  display: flex;
  justify-content: center;
  padding: 24px 0 64px;
}

@media (max-width: 900px) {
  .articles-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 640px) {
  .articles-grid {
    grid-template-columns: 1fr;
  }
}
</style>
