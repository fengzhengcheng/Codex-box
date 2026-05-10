<template>
  <div class="tools-page">
    <Navbar />

    <main class="main-content">
      <div class="page-header">
        <div class="container">
          <h1>AI 工具导航</h1>
          <p>发现并探索最优秀的AI工具，提升你的工作效率</p>
        </div>
      </div>

      <div class="container">
        <div class="filter-bar">
          <SearchBar
            v-model="keyword"
            placeholder="搜索AI工具名称或描述..."
            @search="handleSearch"
          />
          <CategoryFilter
            :categories="categories"
            :selected-category-id="selectedCategoryId"
            @change="handleCategoryChange"
          />
        </div>

        <div class="tools-grid" v-if="tools.length && !loading">
          <ToolCard
            v-for="tool in tools"
            :key="tool.id"
            :tool="tool"
            @click="$router.push(`/tools/${tool.id}`)"
          />
        </div>

        <EmptyState v-else-if="!loading && !tools.length" description="暂无AI工具数据" />

        <div class="loading-wrapper" v-if="loading">
          <el-skeleton :rows="5" animated />
        </div>

        <div class="pagination" v-if="total > pageSize">
          <el-pagination
            v-model:current-page="currentPage"
            :page-size="pageSize"
            :total="total"
            layout="prev, pager, next"
            @current-change="fetchTools"
          />
        </div>
      </div>
    </main>

    <Footer />
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue'
import { useRoute } from 'vue-router'
import Navbar from '@/components/Navbar.vue'
import Footer from '@/components/Footer.vue'
import ToolCard from '@/components/ToolCard.vue'
import SearchBar from '@/components/SearchBar.vue'
import CategoryFilter from '@/components/CategoryFilter.vue'
import EmptyState from '@/components/EmptyState.vue'
import { toolApi, toolCategoryApi } from '@/api/modules'

const route = useRoute()

const tools = ref([])
const categories = ref([])
const loading = ref(false)
const keyword = ref('')
const selectedCategoryId = ref(null)
const currentPage = ref(1)
const pageSize = 12
const total = ref(0)

async function fetchTools() {
  loading.value = true
  try {
    const params = {
      page: currentPage.value,
      size: pageSize
    }
    if (keyword.value) params.keyword = keyword.value
    if (selectedCategoryId.value) params.categoryId = selectedCategoryId.value

    const res = await toolApi.list(params)
    tools.value = res.data?.list || res.data || []
    total.value = res.data?.total || tools.value.length
  } catch (e) {
    console.error('获取工具列表失败:', e)
  } finally {
    loading.value = false
  }
}

async function fetchCategories() {
  try {
    const res = await toolCategoryApi.list()
    categories.value = res.data?.list || res.data || []
  } catch (e) {
    console.error('获取分类失败:', e)
  }
}

function handleSearch(val) {
  keyword.value = val
  currentPage.value = 1
  fetchTools()
}

function handleCategoryChange(id) {
  selectedCategoryId.value = id
  currentPage.value = 1
  fetchTools()
}

watch(() => route.query, (query) => {
  if (query.keyword) keyword.value = query.keyword
  if (query.categoryId) selectedCategoryId.value = Number(query.categoryId)
  fetchTools()
}, { immediate: true })

onMounted(() => {
  fetchCategories()
  if (!route.query.keyword && !route.query.categoryId) {
    fetchTools()
  }
})
</script>

<style scoped>
.tools-page {
  min-height: 100vh;
}

.main-content {
  padding-top: 64px;
}

.page-header {
  background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
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

.filter-bar {
  padding: 32px 0;
  display: flex;
  flex-direction: column;
  gap: 20px;
  align-items: center;
}

.tools-grid {
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
  .tools-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 640px) {
  .tools-grid {
    grid-template-columns: 1fr;
  }
}
</style>
