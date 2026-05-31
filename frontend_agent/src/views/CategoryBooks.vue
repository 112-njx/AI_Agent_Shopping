<script setup>
import { ref, onMounted, watch, inject } from 'vue'
import { useRoute } from 'vue-router'
import api from '../utils/api.js'
import { bookCover } from '../utils/constants.js'
import Pagination from '../components/Pagination.vue'

const route = useRoute()
const toast = inject('toast')

const categoryList = ref([])
const pageInfo = ref({ list: [], total: 0, pages: 0 })
const pageNum = ref(1)
const pageSize = 4
const loading = ref(false)

function loadData() {
  const { pid, cid } = route.query
  if (!pid) return

  loading.value = true
  Promise.all([
    api.get('/category/selectCategoryByParentId', { params: { pid } }),
    api.get('/book/showBookByCategoryId', {
      params: { pid, cid: cid || '', pageNum: pageNum.value, pageSize }
    })
  ])
    .then(([cResp, bResp]) => {
      categoryList.value = cResp.data || []
      pageInfo.value = bResp.data || { list: [], total: 0, pages: 0 }
    })
    .catch(() => {})
    .finally(() => { loading.value = false })
}

onMounted(loadData)

watch(() => [route.query.pid, route.query.cid], () => {
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
      <span class="breadcrumb-current">图书分类</span>
    </div>

    <div class="category-layout">
      <aside class="category-aside">
        <h3 class="aside-title">子分类</h3>
        <ul class="aside-list">
          <li>
            <router-link
              :to="`/category?pid=${route.query.pid}`"
              class="aside-link"
              :class="{ active: !route.query.cid }"
            >
              全部
            </router-link>
          </li>
          <li v-for="cat in categoryList" :key="cat.categoryId">
            <router-link
              :to="`/category?pid=${cat.parentId}&cid=${cat.categoryId}`"
              class="aside-link"
              :class="{ active: String(route.query.cid) === String(cat.categoryId) }"
            >
              {{ cat.name }}
            </router-link>
          </li>
        </ul>
      </aside>

      <main class="category-main">
        <h1 class="page-title" style="margin-bottom: var(--space-lg);">
          图书列表
          <span v-if="pageInfo.total" class="result-count" style="margin-left: var(--space-sm);">（共 {{ pageInfo.total }} 本）</span>
        </h1>

        <div v-if="loading" class="loading-state">
          <div class="loading-spinner"></div>
          <span>加载中...</span>
        </div>

        <div v-else-if="!pageInfo.list.length" class="empty-state">
          <div class="empty-icon">
            <svg viewBox="0 0 24 24" width="64" height="64" fill="none" stroke="currentColor" stroke-width="1"><rect x="3" y="3" width="18" height="18" rx="2"/><line x1="3" y1="9" x2="21" y2="9"/><line x1="9" y1="21" x2="9" y2="9"/></svg>
          </div>
          <p>该分类下暂无图书</p>
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
      </main>
    </div>
  </div>
</template>

<style scoped>
.breadcrumb {
  font-size: 0.82rem;
  color: var(--color-text-muted);
  margin-bottom: var(--space-lg);
}

.breadcrumb a:hover { color: var(--color-primary); }
.breadcrumb-sep { margin: 0 var(--space-sm); }
.breadcrumb-current { color: var(--color-text-secondary); }

.result-count {
  font-size: 0.85rem;
  font-weight: 400;
  color: var(--color-text-muted);
}

.category-layout {
  display: grid;
  grid-template-columns: 180px 1fr;
  gap: var(--space-lg);
}

.category-aside {
  background: var(--color-card);
  border: 1px solid var(--color-border-light);
  border-radius: var(--radius-md);
  align-self: start;
  position: sticky;
  top: calc(var(--header-height) + var(--space-md));
}

.aside-title {
  font-size: 0.9rem;
  font-weight: 600;
  padding: var(--space-md);
  border-bottom: 1px solid var(--color-border-light);
  color: var(--color-primary);
}

.aside-link {
  display: block;
  padding: 10px var(--space-md);
  font-size: 0.85rem;
  color: var(--color-text-secondary);
  transition: all var(--transition);
}

.aside-link:hover, .aside-link.active {
  color: var(--color-primary);
  background: rgba(230, 0, 18, 0.04);
}

.aside-link.active {
  font-weight: 600;
}

/* Book list - reused from Search */
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
}

.list-cover img {
  width: 100%;
  height: auto;
}

.list-body {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
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

.list-price-old { font-size: 0.82rem; color: var(--color-text-muted); }

.list-save { font-size: 0.78rem; color: var(--color-success); font-weight: 500; }

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

.list-add-btn:hover { background: var(--color-primary-dark); }

@media (max-width: 768px) {
  .category-layout {
    grid-template-columns: 1fr;
  }

  .category-aside {
    position: static;
  }

  .aside-list {
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-xs);
    padding: var(--space-sm);
  }

  .aside-link {
    padding: 6px 12px;
    border: 1px solid var(--color-border);
    border-radius: 16px;
    font-size: 0.8rem;
  }

  .aside-link.active {
    background: var(--color-primary);
    color: #fff;
  }

  .book-list-item {
    flex-direction: column;
  }

  .list-item-inner {
    flex-direction: column;
    align-items: center;
    text-align: center;
  }

  .list-cover { width: 100px; }

  .list-add-btn { align-self: stretch; }
}
</style>
