<template>
  <div class="empty-state">
    <div class="empty-icon">
      <slot name="icon">
        <el-icon :size="64" color="#d1d5db"><Box /></el-icon>
      </slot>
    </div>
    <p class="empty-description">{{ description }}</p>
    <slot name="action"></slot>
  </div>
</template>

<script setup>
import { Box } from '@element-plus/icons-vue'

defineProps({
  description: {
    type: String,
    default: '暂无数据'
  },
  icon: {
    type: String,
    default: ''
  }
})
</script>

<style scoped>
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px 20px;
  text-align: center;
}

.empty-icon {
  margin-bottom: 20px;
}

.empty-description {
  font-size: 15px;
  color: var(--text-light);
  margin-bottom: 16px;
}
</style>
