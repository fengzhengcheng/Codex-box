<template>
  <div class="search-bar">
    <el-input
      v-model="keyword"
      :placeholder="placeholder"
      :prefix-icon="Search"
      clearable
      size="large"
      @keyup.enter="handleSearch"
      @clear="handleSearch"
    />
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'
import { Search } from '@element-plus/icons-vue'

const props = defineProps({
  placeholder: {
    type: String,
    default: '搜索...'
  },
  modelValue: {
    type: String,
    default: ''
  }
})

const emit = defineEmits(['search', 'update:modelValue'])

const keyword = ref(props.modelValue)

watch(() => props.modelValue, (val) => {
  keyword.value = val
})

watch(keyword, (val) => {
  emit('update:modelValue', val)
})

function handleSearch() {
  emit('search', keyword.value)
}
</script>

<style scoped>
.search-bar {
  width: 100%;
  max-width: 480px;
}

.search-bar :deep(.el-input__wrapper) {
  border-radius: 12px;
  padding: 4px 16px;
  box-shadow: 0 0 0 1px var(--border-color);
  transition: all 0.3s;
}

.search-bar :deep(.el-input__wrapper:hover) {
  box-shadow: 0 0 0 1px var(--primary-color);
}

.search-bar :deep(.el-input__wrapper.is-focus) {
  box-shadow: 0 0 0 2px var(--primary-color), 0 4px 12px rgba(16, 185, 129, 0.15);
}
</style>
