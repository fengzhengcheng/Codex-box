<template>
  <div class="prompt-card" @click="$emit('click', prompt)">
    <div class="card-header">
      <span class="prompt-category" v-if="prompt.category_name">{{ prompt.category_name }}</span>
      <span class="prompt-model" v-if="prompt.model_type">
        <el-tag size="small" type="info" effect="plain">{{ prompt.model_type }}</el-tag>
      </span>
    </div>

    <div class="card-body">
      <h3 class="prompt-title">{{ prompt.title }}</h3>
      <p class="prompt-desc">{{ prompt.description || prompt.content?.substring(0, 100) + '...' }}</p>
    </div>

    <div class="card-footer">
      <el-button
        type="primary"
        size="small"
        round
        @click.stop="copyContent"
      >
        <el-icon><CopyDocument /></el-icon>
        一键复制
      </el-button>
      <el-button
        size="small"
        round
        plain
        @click.stop="$router.push(`/prompts/${prompt.id}`)"
      >
        查看详情
      </el-button>
    </div>
  </div>
</template>

<script setup>
import { ElMessage } from 'element-plus'
import { CopyDocument } from '@element-plus/icons-vue'

defineProps({
  prompt: {
    type: Object,
    required: true
  }
})

defineEmits(['click'])

function copyContent() {
  ElMessage.success('已复制到剪贴板')
}
</script>

<style scoped>
.prompt-card {
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

.prompt-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
  border-color: transparent;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.prompt-category {
  padding: 4px 12px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border-radius: 6px;
  font-size: 12px;
  font-weight: 500;
}

.card-body {
  flex: 1;
}

.prompt-title {
  font-size: 17px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 10px;
  line-height: 1.4;
}

.prompt-desc {
  font-size: 13px;
  color: var(--text-secondary);
  line-height: 1.6;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
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
  --el-button-bg-color: var(--secondary-color);
  --el-button-border-color: var(--secondary-color);
  --el-button-hover-bg-color: #2563eb;
  --el-button-hover-border-color: #2563eb;
}
</style>
