<template>
  <div class="category-filter">
    <button
      v-for="cat in categories"
      :key="cat.id"
      class="filter-btn"
      :class="{ active: selectedCategoryId === cat.id }"
      @click="$emit('change', cat.id === selectedCategoryId ? null : cat.id)"
    >
      {{ cat.name }}
    </button>
  </div>
</template>

<script setup>
defineProps({
  categories: {
    type: Array,
    default: () => []
  },
  selectedCategoryId: {
    type: [Number, String],
    default: null
  }
})

defineEmits(['change'])
</script>

<style scoped>
.category-filter {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.filter-btn {
  padding: 8px 18px;
  border-radius: 20px;
  border: 1px solid var(--border-color);
  background: white;
  color: var(--text-secondary);
  font-size: 13px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
}

.filter-btn:hover {
  border-color: var(--primary-color);
  color: var(--primary-color);
  background: rgba(16, 185, 129, 0.04);
}

.filter-btn.active {
  background: var(--primary-color);
  border-color: var(--primary-color);
  color: white;
}
</style>
