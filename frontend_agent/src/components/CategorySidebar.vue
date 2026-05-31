<script setup>
import { ref, onMounted } from 'vue'
import api from '../utils/api.js'

const categories = ref([])
const expandedId = ref(null)

onMounted(async () => {
  try {
    const resp = await api.get('/category/showCategory')
    categories.value = resp.data || []
  } catch {}
})

function toggleExpand(id) {
  expandedId.value = expandedId.value === id ? null : id
}
</script>

<template>
  <aside class="category-sidebar">
    <h3 class="sidebar-title">图书分类</h3>
    <ul class="category-tree">
      <li v-for="cat in categories" :key="cat.categoryId" class="category-item">
        <div class="category-parent" @click="toggleExpand(cat.categoryId)">
          <span class="parent-name">{{ cat.name }}</span>
          <svg
            class="expand-icon"
            :class="{ expanded: expandedId === cat.categoryId }"
            viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"
          >
            <path d="m9 18 6-6-6-6"/>
          </svg>
        </div>
        <ul v-if="cat.childList && expandedId === cat.categoryId" class="category-children">
          <li v-for="child in cat.childList" :key="child.categoryId">
            <router-link
              :to="`/category?pid=${cat.categoryId}&cid=${child.categoryId}`"
              class="child-link"
            >
              {{ child.name }}
            </router-link>
          </li>
          <li>
            <router-link :to="`/category?pid=${cat.categoryId}`" class="child-link child-all">
              全部 {{ cat.name }}
            </router-link>
          </li>
        </ul>
      </li>
    </ul>
  </aside>
</template>

<style scoped>
.category-sidebar {
  background: var(--color-card);
  border-radius: var(--radius-md);
  border: 1px solid var(--color-border-light);
  overflow: hidden;
}

.sidebar-title {
  font-size: 0.95rem;
  font-weight: 600;
  padding: var(--space-md);
  background: var(--color-primary);
  color: #fff;
}

.category-parent {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 11px var(--space-md);
  cursor: pointer;
  font-weight: 500;
  font-size: 0.9rem;
  transition: all var(--transition);
  border-bottom: 1px solid var(--color-border-light);
}

.category-parent:hover {
  background: rgba(230, 0, 18, 0.03);
  color: var(--color-primary);
}

.expand-icon {
  transition: transform var(--transition);
  color: var(--color-text-muted);
  flex-shrink: 0;
}

.expand-icon.expanded {
  transform: rotate(90deg);
  color: var(--color-primary);
}

.category-children {
  background: #FAFAFA;
  padding: var(--space-sm) 0;
  border-bottom: 1px solid var(--color-border-light);
}

.child-link {
  display: block;
  padding: 8px var(--space-lg);
  font-size: 0.82rem;
  color: var(--color-text-secondary);
  transition: all var(--transition);
}

.child-link:hover {
  color: var(--color-primary);
  background: rgba(230, 0, 18, 0.04);
}

.child-all {
  border-top: 1px solid var(--color-border-light);
  margin-top: var(--space-xs);
  padding-top: 10px;
  font-weight: 500;
}

@media (max-width: 768px) {
  .category-sidebar {
    display: none;
  }
}
</style>
