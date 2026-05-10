<template>
  <div class="tool-card" @click="$emit('click', tool)">
    <div class="card-header">
      <img
        :src="tool.logo || defaultLogo"
        :alt="tool.name"
        class="tool-logo"
        @error="handleImgError"
      />
      <div class="card-badges">
        <span v-if="tool.is_free" class="badge badge-free">免费</span>
        <span v-if="tool.is_recommended" class="badge badge-hot">推荐</span>
      </div>
    </div>

    <div class="card-body">
      <h3 class="tool-name">{{ tool.name }}</h3>
      <p class="tool-desc">{{ tool.description || tool.intro }}</p>

      <div class="card-tags" v-if="tool.tags && tool.tags.length">
        <span v-for="tag in tool.tags.slice(0, 3)" :key="tag" class="tag">{{ tag }}</span>
      </div>

      <div class="card-rating" v-if="tool.rating">
        <el-rate
          :model-value="tool.rating"
          disabled
          :colors="['#10b981', '#10b981', '#10b981']"
          size="small"
        />
        <span class="rating-text">{{ tool.rating.toFixed(1) }}</span>
      </div>
    </div>

    <div class="card-footer">
      <el-button
        type="primary"
        size="small"
        round
        @click.stop="visitWebsite"
      >
        访问官网
      </el-button>
      <el-button
        size="small"
        round
        plain
        @click.stop="$router.push(`/tools/${tool.id}`)"
      >
        查看详情
      </el-button>
    </div>
  </div>
</template>

<script setup>
defineProps({
  tool: {
    type: Object,
    required: true
  }
})

defineEmits(['click'])

const defaultLogo = 'https://ui-avatars.com/api/?name=AI&background=10b981&color=fff&size=80'

function handleImgError(e) {
  e.target.src = defaultLogo
}

function visitWebsite() {
  window.open('https://example.com', '_blank')
}
</script>

<style scoped>
.tool-card {
  background: white;
  border-radius: var(--radius-md);
  padding: 24px;
  box-shadow: var(--shadow-sm);
  border: 1px solid var(--border-color);
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  flex-direction: column;
}

.tool-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
  border-color: transparent;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 16px;
}

.tool-logo {
  width: 56px;
  height: 56px;
  border-radius: 16px;
  object-fit: cover;
  background: #f3f4f6;
}

.card-badges {
  display: flex;
  gap: 6px;
}

.badge {
  padding: 3px 10px;
  border-radius: 20px;
  font-size: 11px;
  font-weight: 600;
}

.badge-free {
  background: rgba(16, 185, 129, 0.1);
  color: #059669;
}

.badge-hot {
  background: rgba(239, 68, 68, 0.1);
  color: #dc2626;
}

.card-body {
  flex: 1;
}

.tool-name {
  font-size: 17px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 8px;
}

.tool-desc {
  font-size: 13px;
  color: var(--text-secondary);
  line-height: 1.6;
  margin-bottom: 12px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.card-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  margin-bottom: 12px;
}

.tag {
  padding: 4px 10px;
  background: #f3f4f6;
  border-radius: 6px;
  font-size: 12px;
  color: var(--text-secondary);
}

.card-rating {
  display: flex;
  align-items: center;
  gap: 8px;
}

.rating-text {
  font-size: 13px;
  font-weight: 600;
  color: var(--text-primary);
}

.card-footer {
  display: flex;
  gap: 8px;
  margin-top: 16px;
  padding-top: 16px;
  border-top: 1px solid #f3f4f6;
}

.card-footer :deep(.el-button) {
  flex: 1;
}

.card-footer :deep(.el-button--primary) {
  --el-button-bg-color: var(--primary-color);
  --el-button-border-color: var(--primary-color);
  --el-button-hover-bg-color: var(--primary-hover);
  --el-button-hover-border-color: var(--primary-hover);
}
</style>
