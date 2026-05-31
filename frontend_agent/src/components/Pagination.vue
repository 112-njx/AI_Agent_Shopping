<script setup>
import { computed } from 'vue'

const props = defineProps({
  current: { type: Number, required: true },
  total: { type: Number, required: true }
})

const emit = defineEmits(['change'])

const pages = computed(() => {
  const arr = []
  const total = props.total
  if (total <= 7) {
    for (let i = 1; i <= total; i++) arr.push(i)
  } else {
    arr.push(1)
    if (props.current > 3) arr.push('...')
    const start = Math.max(2, props.current - 1)
    const end = Math.min(total - 1, props.current + 1)
    for (let i = start; i <= end; i++) arr.push(i)
    if (props.current < total - 2) arr.push('...')
    arr.push(total)
  }
  return arr
})

function go(page) {
  if (page === '...' || page < 1 || page > props.total || page === props.current) return
  emit('change', page)
}
</script>

<template>
  <div class="pagination" v-if="total > 1">
    <button class="page-btn" :disabled="current <= 1" @click="go(current - 1)">上一页</button>
    <button
      v-for="p in pages"
      :key="p"
      class="page-btn"
      :class="{ active: p === current, ellipsis: p === '...' }"
      @click="go(p)"
    >
      {{ p }}
    </button>
    <button class="page-btn" :disabled="current >= total" @click="go(current + 1)">下一页</button>
    <span class="page-info">共 {{ total }} 页</span>
  </div>
</template>

<style scoped>
.pagination {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 4px;
  padding: var(--space-lg) 0;
  flex-wrap: wrap;
}

.page-btn {
  min-width: 36px;
  height: 36px;
  padding: 0 10px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  background: var(--color-card);
  color: var(--color-text-secondary);
  font-size: 0.85rem;
  font-weight: 500;
  transition: all var(--transition);
}

.page-btn:hover:not(:disabled):not(.ellipsis) {
  border-color: var(--color-primary);
  color: var(--color-primary);
}

.page-btn.active {
  background: var(--color-primary);
  border-color: var(--color-primary);
  color: #fff;
}

.page-btn:disabled {
  opacity: 0.4;
  cursor: not-allowed;
}

.page-btn.ellipsis {
  border: none;
  background: transparent;
  cursor: default;
}

.page-info {
  font-size: 0.82rem;
  color: var(--color-text-muted);
  margin-left: var(--space-md);
}
</style>
