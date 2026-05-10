<template>
  <div class="prompts-page">
    <Navbar />

    <main class="main-content">
      <div class="page-header">
        <div class="container">
          <h1>提示词库</h1>
          <p>精心整理的高质量AI提示词，一键复制即用</p>
        </div>
      </div>

      <div class="container">
        <div class="filter-bar">
          <SearchBar
            v-model="keyword"
            placeholder="搜索提示词标题或内容..."
            @search="handleSearch"
          />
          <CategoryFilter
            :categories="categories"
            :selected-category-id="selectedCategoryId"
            @change="handleCategoryChange"
          />
        </div>

        <div class="prompts-grid" v-if="prompts.length && !loading">
          <PromptCard
            v-for="prompt in prompts"
            :key="prompt.id"
            :prompt="prompt"
            @click="$router.push(`/prompts/${prompt.id}`)"
          />
        </div>

        <EmptyState v-else-if="!loading && !prompts.length" description="暂无提示词数据" />

        <div class="loading-wrapper" v-if="loading">
          <el-skeleton :rows="5" animated />
        </div>

        <div class="pagination" v-if="total > pageSize">
          <el-pagination
            v-model:current-page="currentPage"
            :page-size="pageSize"
            :total="total"
            layout="prev, pager, next"
            @current-change="fetchPrompts"
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
import PromptCard from '@/components/PromptCard.vue'
import SearchBar from '@/components/SearchBar.vue'
import CategoryFilter from '@/components/CategoryFilter.vue'
import EmptyState from '@/components/EmptyState.vue'
import { promptApi, promptCategoryApi } from '@/api/modules'

const prompts = ref([])
const categories = ref([])
const loading = ref(false)
const keyword = ref('')
const selectedCategoryId = ref(null)
const currentPage = ref(1)
const pageSize = 12
const total = ref(0)

async function fetchPrompts() {
  loading.value = true
  try {
    const params = { page: currentPage.value, size: pageSize }
    if (keyword.value) params.keyword = keyword.value
    if (selectedCategoryId.value) params.categoryId = selectedCategoryId.value

    const res = await promptApi.list(params)
    prompts.value = res.data?.list || res.data || []
    total.value = res.data?.total || prompts.value.length
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
}

async function fetchCategories() {
  try {
    const res = await promptCategoryApi.list()
    categories.value = res.data?.list || res.data || []
  } catch (e) {
    console.error(e)
  }
}

function handleSearch(val) {
  keyword.value = val
  currentPage.value = 1
  fetchPrompts()
}

function handleCategoryChange(id) {
  selectedCategoryId.value = id
  currentPage.value = 1
  fetchPrompts()
}

onMounted(() => {
  fetchCategories()
  fetchPrompts()
})
</script>

<style scoped>
.prompts-page {
  min-height: 100vh;
}

.main-content {
  padding-top: 64px;
}

.page-header {
  background: linear-gradient(135deg, #1e1b4b 0%, #312e81 100%);
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
  color: #a5b4fc;
  font-size: 16px;
}

.container {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 24px;
}

.filter-bar {
  padding: 32px 0;
  display: flex;
  flex-direction: column;
  gap: 20px;
  align-items: center;
}

.prompts-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
  padding-bottom: 48px;
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
  .prompts-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 640px) {
  .prompts-grid {
    grid-template-columns: 1fr;
  }
}
</style>
