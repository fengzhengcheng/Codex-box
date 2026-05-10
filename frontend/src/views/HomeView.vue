<template>
  <div class="home-page">
    <Navbar />

    <section class="hero">
      <div class="hero-bg"></div>
      <div class="hero-container">
        <h1 class="hero-title">发现最佳<span class="highlight">AI工具</span></h1>
        <p class="hero-subtitle">精选全球顶尖AI产品与资源，助力你的创作效率提升10倍</p>
        <div class="hero-search">
          <el-input
            v-model="searchKeyword"
            size="large"
            placeholder="搜索AI工具、提示词..."
            :prefix-icon="Search"
            clearable
            @keyup.enter="goSearch"
          >
            <template #append>
              <el-button type="primary" @click="goSearch">搜索</el-button>
            </template>
          </el-input>
        </div>
        <div class="hero-tags">
          <span v-for="tag in hotTags" :key="tag" class="hot-tag" @click="searchKeyword = tag; goSearch()">{{ tag }}</span>
        </div>
      </div>
    </section>

    <section class="banner-section" v-if="banners.length">
      <div class="container">
        <el-carousel height="280px" :interval="4000" arrow="hover">
          <el-carousel-item v-for="banner in banners" :key="banner.id">
            <div
              class="banner-item"
              :style="{ backgroundImage: `url(${banner.image_url})` }"
              @click="handleBannerClick(banner)"
            >
              <div class="banner-overlay">
                <h3>{{ banner.title }}</h3>
                <p>{{ banner.description }}</p>
              </div>
            </div>
          </el-carousel-item>
        </el-carousel>
      </div>
    </section>

    <section class="section hot-tools">
      <div class="container">
        <div class="section-header">
          <h2>🔥 热门AI工具</h2>
          <router-link to="/tools" class="view-all">查看全部 →</router-link>
        </div>
        <div class="tools-grid" v-if="hotTools.length">
          <ToolCard
            v-for="tool in hotTools"
            :key="tool.id"
            :tool="tool"
            @click="$router.push(`/tools/${tool.id}`)"
          />
        </div>
        <EmptyState v-else description="暂无热门工具数据" />
      </div>
    </section>

    <section class="section hot-prompts">
      <div class="container">
        <div class="section-header">
          <h2>💡 热门提示词</h2>
          <router-link to="/prompts" class="view-all">查看全部 →</router-link>
        </div>
        <div class="prompts-grid" v-if="hotPrompts.length">
          <PromptCard
            v-for="prompt in hotPrompts"
            :key="prompt.id"
            :prompt="prompt"
            @click="$router.push(`/prompts/${prompt.id}`)"
          />
        </div>
        <EmptyState v-else description="暂无热门提示词数据" />
      </div>
    </section>

    <section class="section categories">
      <div class="container">
        <div class="section-header">
          <h2>📂 工具分类</h2>
        </div>
        <div class="categories-grid" v-if="toolCategories.length">
          <router-link
            v-for="cat in toolCategories"
            :key="cat.id"
            :to="{ path: '/tools', query: { categoryId: cat.id } }"
            class="category-card"
          >
            <div class="category-icon">{{ getCategoryIcon(cat.name) }}</div>
            <span class="category-name">{{ cat.name }}</span>
            <span class="category-count">{{ cat.tool_count || 0 }} 个工具</span>
          </router-link>
        </div>
      </div>
    </section>

    <section class="section latest-articles">
      <div class="container">
        <div class="section-header">
          <h2>📚 最新教程</h2>
          <router-link to="/articles" class="view-all">查看全部 →</router-link>
        </div>
        <div class="articles-grid" v-if="latestArticles.length">
          <ArticleCard
            v-for="article in latestArticles.slice(0, 4)"
            :key="article.id"
            :article="article"
            @click="$router.push(`/articles/${article.id}`)"
          />
        </div>
        <EmptyState v-else description="暂无文章数据" />
      </div>
    </section>

    <Footer />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Search } from '@element-plus/icons-vue'
import Navbar from '@/components/Navbar.vue'
import Footer from '@/components/Footer.vue'
import ToolCard from '@/components/ToolCard.vue'
import PromptCard from '@/components/PromptCard.vue'
import ArticleCard from '@/components/ArticleCard.vue'
import EmptyState from '@/components/EmptyState.vue'
import { toolApi, promptApi, articleApi, bannerApi, toolCategoryApi } from '@/api/modules'

const router = useRouter()
const searchKeyword = ref('')
const banners = ref([])
const hotTools = ref([])
const hotPrompts = ref([])
const toolCategories = ref([])
const latestArticles = ref([])

const hotTags = ['ChatGPT', 'Midjourney', 'Claude', 'Stable Diffusion', '代码生成']

function goSearch() {
  if (searchKeyword.value.trim()) {
    router.push({ path: '/tools', query: { keyword: searchKeyword.value.trim() } })
  }
}

function handleBannerClick(banner) {
  if (banner.link_url) window.open(banner.link_url)
}

function getCategoryIcon(name) {
  const icons = {
    '文本生成': '✍️',
    '图像处理': '🎨',
    '代码辅助': '💻',
    '音频视频': '🎵',
    '数据分析': '📊',
    '办公效率': '📋',
    '翻译': '🌐',
    '教育学习': '📖'
  }
  return icons[name] || '🚀'
}

onMounted(async () => {
  try {
    const [bannerRes, toolsRes, promptsRes, catRes, articlesRes] = await Promise.allSettled([
      bannerApi.list(),
      toolApi.hot ? toolApi.hot() : toolApi.list({ page: 1, size: 6 }),
      promptApi.hot ? promptApi.hot() : promptApi.list({ page: 1, size: 6 }),
      toolCategoryApi.list(),
      articleApi.list({ page: 1, size: 4 })
    ])

    if (bannerRes.status === 'fulfilled') banners.value = bannerRes.value.data?.list || bannerRes.value.data || []
    if (toolsRes.status === 'fulfilled') hotTools.value = toolsRes.value.data?.list || toolsRes.value.data || []
    if (promptsRes.status === 'fulfilled') hotPrompts.value = promptsRes.value.data?.list || promptsRes.value.data || []
    if (catRes.status === 'fulfilled') toolCategories.value = catRes.value.data?.list || catRes.value.data || []
    if (articlesRes.status === 'fulfilled') latestArticles.value = articlesRes.value.data?.list || articlesRes.value.data || []
  } catch (e) {
    console.log('首页数据加载:', e.message)
  }
})
</script>

<style scoped>
.home-page {
  min-height: 100vh;
}

.hero {
  position: relative;
  padding: 140px 24px 80px;
  text-align: center;
  overflow: hidden;
}

.hero-bg {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #0f172a 100%);
  z-index: -1;
}

.hero-bg::before {
  content: '';
  position: absolute;
  width: 600px;
  height: 600px;
  background: radial-gradient(circle, rgba(16,185,129,0.15) 0%, transparent 70%);
  top: -200px;
  right: -100px;
}

.hero-bg::after {
  content: '';
  position: absolute;
  width: 500px;
  height: 500px;
  background: radial-gradient(circle, rgba(59,130,246,0.1) 0%, transparent 70%);
  bottom: -150px;
  left: -100px;
}

.hero-container {
  max-width: 720px;
  margin: 0 auto;
  position: relative;
  z-index: 1;
}

.hero-title {
  font-size: 52px;
  font-weight: 800;
  color: white;
  line-height: 1.15;
  margin-bottom: 20px;
  letter-spacing: -1px;
}

.highlight {
  background: linear-gradient(135deg, #10b981, #3b82f6);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero-subtitle {
  font-size: 18px;
  color: #94a3b8;
  margin-bottom: 36px;
  line-height: 1.7;
}

.hero-search {
  max-width: 560px;
  margin: 0 auto 20px;
}

.hero-search :deep(.el-input-group__append) {
  background: var(--primary-color);
  border-color: var(--primary-color);
  color: white;
  padding: 0 28px;
  cursor: pointer;
}

.hero-tags {
  display: flex;
  justify-content: center;
  gap: 8px;
  flex-wrap: wrap;
}

.hot-tag {
  padding: 6px 16px;
  border-radius: 20px;
  background: rgba(255,255,255,0.08);
  color: #94a3b8;
  font-size: 13px;
  cursor: pointer;
  transition: all 0.2s;
  border: 1px solid rgba(255,255,255,0.1);
}

.hot-tag:hover {
  background: rgba(16,185,129,0.15);
  color: #10b981;
  border-color: rgba(16,185,129,0.3);
}

.container {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 24px;
}

.section {
  padding: 64px 0;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 32px;
}

.section-header h2 {
  font-size: 26px;
  font-weight: 700;
  color: var(--text-primary);
}

.view-all {
  color: var(--primary-color);
  font-size: 14px;
  font-weight: 500;
  text-decoration: none;
}

.view-all:hover {
  color: var(--primary-hover);
}

.banner-section {
  padding-top: 40px;
}

.banner-item {
  width: 100%;
  height: 100%;
  background-size: cover;
  background-position: center;
  border-radius: 16px;
  cursor: pointer;
  position: relative;
  display: flex;
  align-items: flex-end;
}

.banner-overlay {
  padding: 32px;
  background: linear-gradient(to top, rgba(0,0,0,0.75), transparent);
  border-radius: 16px;
  width: 100%;
}

.banner-overlay h3 {
  color: white;
  font-size: 22px;
  font-weight: 700;
  margin-bottom: 8px;
}

.banner-overlay p {
  color: rgba(255,255,255,0.8);
  font-size: 14px;
}

.tools-grid,
.prompts-grid,
.articles-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
}

.articles-grid {
  grid-template-columns: repeat(4, 1fr);
}

.categories-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
  gap: 16px;
}

.category-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  padding: 28px 20px;
  background: white;
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-sm);
  border: 1px solid var(--border-color);
  text-decoration: none;
  transition: all 0.3s;
}

.category-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
  border-color: transparent;
}

.category-icon {
  font-size: 36px;
}

.category-name {
  font-size: 15px;
  font-weight: 600;
  color: var(--text-primary);
}

.category-count {
  font-size: 12px;
  color: var(--text-light);
}

@media (max-width: 1024px) {
  .tools-grid,
  .prompts-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  .articles-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 640px) {
  .hero-title {
    font-size: 32px;
  }
  .hero-subtitle {
    font-size: 15px;
  }
  .tools-grid,
  .prompts-grid,
  .articles-grid {
    grid-template-columns: 1fr;
  }
}
</style>
