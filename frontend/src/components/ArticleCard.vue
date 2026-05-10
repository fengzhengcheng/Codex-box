<template>
  <div class="article-card" @click="$emit('click', article)">
    <div class="article-image">
      <img
        :src="article.cover_image || defaultImage"
        :alt="article.title"
        @error="handleImgError"
      />
      <div class="image-overlay"></div>
    </div>

    <div class="article-content">
      <h3 class="article-title">{{ article.title }}</h3>
      <p class="article-summary">{{ article.summary || article.description }}</p>

      <div class="article-meta">
        <span class="meta-item">
          <el-icon><View /></el-icon>
          {{ article.view_count || 0 }}
        </span>
        <span class="meta-item" v-if="article.created_at">
          {{ formatDate(article.created_at) }}
        </span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { View } from '@element-plus/icons-vue'

defineProps({
  article: {
    type: Object,
    required: true
  }
})

defineEmits(['click'])

const defaultImage = 'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=400&h=250&fit=crop'

function handleImgError(e) {
  e.target.src = defaultImage
}

function formatDate(dateStr) {
  const date = new Date(dateStr)
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`
}
</script>

<style scoped>
.article-card {
  background: white;
  border-radius: var(--radius-md);
  overflow: hidden;
  box-shadow: var(--shadow-sm);
  border: 1px solid var(--border-color);
  cursor: pointer;
  transition: all 0.3s ease;
}

.article-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
  border-color: transparent;
}

.article-image {
  position: relative;
  height: 180px;
  overflow: hidden;
}

.article-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.article-card:hover .article-image img {
  transform: scale(1.05);
}

.image-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(to bottom, transparent 50%, rgba(0,0,0,0.3));
}

.article-content {
  padding: 20px;
}

.article-title {
  font-size: 17px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 10px;
  line-height: 1.4;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.article-summary {
  font-size: 13px;
  color: var(--text-secondary);
  line-height: 1.6;
  margin-bottom: 16px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.article-meta {
  display: flex;
  gap: 16px;
  font-size: 13px;
  color: var(--text-light);
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 4px;
}
</style>
