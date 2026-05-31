<script setup>
import { ref, onMounted, watch, inject } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import api from '../utils/api.js'
import { bookCover } from '../utils/constants.js'
import Pagination from '../components/Pagination.vue'

const route = useRoute()
const router = useRouter()
const toast = inject('toast')

const pageInfo = ref({ list: [], total: 0, pages: 0 })
const pageNum = ref(1)
const pageSize = 5
const loading = ref(false)
const keyword = ref('')

function loadData() {
  const name = route.query.name || ''
  keyword.value = name
  if (!name) return
  loading.value = true
  api.get('/book/search', { params: { name, pageNum: pageNum.value, pageSize } })
    .then(resp => { pageInfo.value = resp.data || { list: [], total: 0, pages: 0 } })
    .catch(() => {})
    .finally(() => { loading.value = false })
}

onMounted(loadData)

watch(() => route.query.name, () => {
  pageNum.value = 1
  loadData()
})

function changePage(p) {
  pageNum.value = p
  loadData()
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

async function addToCart(bookId, bookName) {
  try {
    await api.post('/cart/putCart', `bookId=${bookId}`)
    toast(`《${bookName}》已加入购物车`)
  } catch {}
}
</script>

<template>
  <div class="page-container">
    <div class="breadcrumb">
      <router-link to="/">首页</router-link>
      <span class="breadcrumb-sep">/</span>
      <span class="breadcrumb-current">搜索 "{{ keyword }}"</span>
    </div>

    <h1 class="page-title" style="margin-bottom: var(--space-lg);">
      搜索结果：{{ keyword }}
      <span v-if="pageInfo.total" class="result-count">（共 {{ pageInfo.total }} 本）</span>
    </h1>

    <div v-if="loading" class="loading-state">
      <div class="loading-spinner"></div>
      <span>搜索中...</span>
    </div>

    <div v-else-if="!pageInfo.list.length" class="empty-state">
      <div class="empty-icon">
        <svg viewBox="0 0 24 24" width="64" height="64" fill="none" stroke="currentColor" stroke-width="1"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/></svg>
      </div>
      <p>未找到与 "{{ keyword }}" 相关的图书</p>
      <p class="empty-hint">试试其他关键词，或浏览分类查找</p>
    </div>

    <template v-else>
      <div class="book-list">
        <div v-for="book in pageInfo.list" :key="book.bookId" class="book-list-item card">
          <router-link :to="`/book/${book.bookId}`" class="list-item-inner">
            <div class="list-cover">
              <img :src="bookCover(book.cover)" :alt="book.bookName" />
            </div>
            <div class="list-body">
              <h3 class="list-title">{{ book.bookName }}</h3>
              <p class="list-meta" v-if="book.author">作者：{{ book.author }}</p>
              <p class="list-meta" v-if="book.press">出版社：{{ book.press }} &nbsp; 出版时间：{{ book.pressDate }}</p>
              <p class="list-abstract" v-if="book.contentAbstract">{{ book.contentAbstract }}</p>
              <div class="list-price-row">
                <span class="list-price">&yen;{{ book.dprice }}</span>
                <del v-if="book.price > book.dprice" class="list-price-old">&yen;{{ book.price }}</del>
                <span v-if="book.price > book.dprice" class="list-save">省 &yen;{{ (book.price - book.dprice).toFixed(1) }}</span>
              </div>
            </div>
          </router-link>
          <button class="list-add-btn" @click="addToCart(book.bookId, book.bookName)">加入购物车</button>
        </div>
      </div>

      <Pagination :current="pageNum" :total="pageInfo.pages || 1" @change="changePage" />
    </template>
  </div>
</template>

<style scoped>
.breadcrumb {
  font-size: 0.82rem;
  color: var(--color-text-muted);
  margin-bottom: var(--space-md);
}

.breadcrumb a:hover { color: var(--color-primary); }

.breadcrumb-sep { margin: 0 var(--space-sm); }

.breadcrumb-current { color: var(--color-text-secondary); }

.result-count {
  font-size: 0.85rem;
  font-weight: 400;
  color: var(--color-text-muted);
}

.empty-hint {
  font-size: 0.9rem;
  margin-top: var(--space-sm);
}

.book-list {
  display: flex;
  flex-direction: column;
  gap: var(--space-md);
}

.book-list-item {
  display: flex;
  padding: var(--space-lg);
  border: 1px solid var(--color-border-light);
  gap: var(--space-lg);
}

.list-item-inner {
  display: flex;
  gap: var(--space-lg);
  flex: 1;
}

.list-cover {
  width: 120px;
  flex-shrink: 0;
  display: flex;
  align-items: center;
}

.list-cover img {
  width: 100%;
  height: auto;
}

.list-body {
  flex: 1;
  min-width: 0;
}

.list-title {
  font-size: 1.05rem;
  font-weight: 600;
  margin-bottom: var(--space-xs);
  color: var(--color-text);
}

.list-meta {
  font-size: 0.82rem;
  color: var(--color-text-muted);
  margin-bottom: 2px;
}

.list-abstract {
  font-size: 0.85rem;
  color: var(--color-text-secondary);
  line-height: 1.6;
  margin: var(--space-sm) 0;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.list-price-row {
  display: flex;
  align-items: baseline;
  gap: var(--space-sm);
  margin-top: auto;
}

.list-price {
  font-size: 1.15rem;
  font-weight: 700;
  color: var(--color-primary);
}

.list-price-old {
  font-size: 0.82rem;
  color: var(--color-text-muted);
}

.list-save {
  font-size: 0.78rem;
  color: var(--color-success);
  font-weight: 500;
}

.list-add-btn {
  padding: 8px 20px;
  background: var(--color-primary);
  color: #fff;
  border-radius: var(--radius-sm);
  font-size: 0.85rem;
  font-weight: 500;
  align-self: center;
  white-space: nowrap;
  transition: all var(--transition);
}

.list-add-btn:hover {
  background: var(--color-primary-dark);
}

@media (max-width: 768px) {
  .book-list-item {
    flex-direction: column;
  }

  .list-item-inner {
    flex-direction: column;
    align-items: center;
    text-align: center;
  }

  .list-cover {
    width: 100px;
  }

  .list-add-btn {
    align-self: stretch;
  }
}
</style>
