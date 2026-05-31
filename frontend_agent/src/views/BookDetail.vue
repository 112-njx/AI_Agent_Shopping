<script setup>
import { ref, onMounted, inject } from 'vue'
import { useRoute } from 'vue-router'
import api from '../utils/api.js'
import { bookCover } from '../utils/constants.js'

const route = useRoute()
const toast = inject('toast')

const book = ref({})
const loading = ref(true)
const adding = ref(false)

onMounted(async () => {
  try {
    const resp = await api.get(`/book/showBook?bookId=${route.params.bookId}`)
    book.value = resp.data || {}
  } catch {} finally {
    loading.value = false
  }
})

async function addToCart() {
  adding.value = true
  try {
    const resp = await api.post('/cart/putCart', `bookId=${book.value.bookId}`)
    if (resp.data.status === 'ok') {
      toast(`《${book.value.bookName}》已加入购物车`)
    }
  } catch {} finally {
    adding.value = false
  }
}
</script>

<template>
  <div class="page-container" v-if="!loading">
    <div class="breadcrumb">
      <router-link to="/">首页</router-link>
      <span class="breadcrumb-sep">/</span>
      <router-link :to="`/category?pid=${book.categoryId}`">图书分类</router-link>
      <span class="breadcrumb-sep">/</span>
      <span class="breadcrumb-current">{{ book.bookName }}</span>
    </div>

    <div class="detail-top">
      <div class="detail-cover">
        <img :src="bookCover(book.cover)" :alt="book.bookName" />
      </div>

      <div class="detail-info">
        <h1 class="detail-title">{{ book.bookName }}</h1>
        <div class="detail-meta">
          <span>作者：<strong>{{ book.author }}</strong></span>
          <span>出版社：<strong>{{ book.press }}</strong></span>
          <span>出版时间：{{ book.pressDate }}</span>
        </div>

        <div class="detail-price-box">
          <div class="detail-price-label">当当价</div>
          <div class="detail-price">&yen;{{ book.dprice }}</div>
          <del class="detail-price-origin">&yen;{{ book.price }}</del>
          <div class="detail-save" v-if="book.price > book.dprice">
            节省 &yen;{{ (book.price - book.dprice).toFixed(1) }}
          </div>
        </div>

        <div class="detail-specs">
          <div class="spec-row">
            <span class="spec-label">ISBN</span>
            <span>{{ book.isbn }}</span>
          </div>
          <div class="spec-row">
            <span class="spec-label">版次</span>
            <span>{{ book.edition }}</span>
          </div>
          <div class="spec-row">
            <span class="spec-label">开本</span>
            <span>{{ book.sizes }}</span>
          </div>
          <div class="spec-row">
            <span class="spec-label">页数</span>
            <span>{{ book.pageNum }}</span>
          </div>
          <div class="spec-row">
            <span class="spec-label">字数</span>
            <span>{{ (book.wordNum / 10000).toFixed(1) }}万字</span>
          </div>
          <div class="spec-row">
            <span class="spec-label">纸张</span>
            <span>{{ book.paper }}</span>
          </div>
          <div class="spec-row">
            <span class="spec-label">包装</span>
            <span>{{ book.pack }}</span>
          </div>
          <div class="spec-row">
            <span class="spec-label">库存</span>
            <span :class="{ 'stock-low': book.stock < 10 }">{{ book.stock }} 本</span>
          </div>
        </div>

        <div class="detail-actions">
          <button class="btn btn-primary btn-lg add-cart-btn" @click="addToCart" :disabled="adding">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M6 2L3 6v14a2 2 0 002 2h14a2 2 0 002-2V6l-3-4zM3 6h18"/><path d="M16 10a4 4 0 01-8 0"/>
            </svg>
            {{ adding ? '添加中...' : '加入购物车' }}
          </button>
        </div>
      </div>
    </div>

    <!-- Book Details Sections -->
    <div class="detail-sections">
      <section v-if="book.editorRecommend" class="detail-section">
        <h2 class="section-heading">编辑推荐</h2>
        <div class="section-body">{{ book.editorRecommend }}</div>
      </section>

      <section v-if="book.contentAbstract" class="detail-section">
        <h2 class="section-heading">内容简介</h2>
        <div class="section-body">{{ book.contentAbstract }}</div>
      </section>

      <section v-if="book.authorAbstract" class="detail-section">
        <h2 class="section-heading">作者简介</h2>
        <div class="section-body">{{ book.authorAbstract }}</div>
      </section>

      <section v-if="book.director" class="detail-section">
        <h2 class="section-heading">目录</h2>
        <div class="section-body director">{{ book.director }}</div>
      </section>

      <section v-if="book.mediaCommentary" class="detail-section">
        <h2 class="section-heading">媒体评论</h2>
        <div class="section-body">{{ book.mediaCommentary }}</div>
      </section>
    </div>
  </div>

  <div v-else class="loading-state" style="min-height: 60vh;">
    <div class="loading-spinner"></div>
    <span>加载中...</span>
  </div>
</template>

<style scoped>
.breadcrumb {
  font-size: 0.82rem;
  color: var(--color-text-muted);
  margin-bottom: var(--space-lg);
}

.breadcrumb a:hover {
  color: var(--color-primary);
}

.breadcrumb-sep {
  margin: 0 var(--space-sm);
}

.breadcrumb-current {
  color: var(--color-text-secondary);
}

.detail-top {
  display: grid;
  grid-template-columns: 340px 1fr;
  gap: var(--space-2xl);
}

.detail-cover {
  background: var(--color-card);
  border-radius: var(--radius-md);
  border: 1px solid var(--color-border-light);
  padding: var(--space-xl);
  display: flex;
  align-items: center;
  justify-content: center;
}

.detail-cover img {
  max-width: 100%;
  max-height: 400px;
  object-fit: contain;
}

.detail-info {
  display: flex;
  flex-direction: column;
  gap: var(--space-lg);
}

.detail-title {
  font-size: 1.5rem;
  font-weight: 700;
  line-height: 1.3;
}

.detail-meta {
  display: flex;
  flex-wrap: wrap;
  gap: 0 var(--space-lg);
  font-size: 0.88rem;
  color: var(--color-text-secondary);
}

.detail-meta strong {
  color: var(--color-text);
}

.detail-price-box {
  background: #FFF5F5;
  border-radius: var(--radius-md);
  padding: var(--space-lg);
  display: flex;
  align-items: baseline;
  gap: var(--space-md);
  flex-wrap: wrap;
}

.detail-price-label {
  font-size: 0.85rem;
  color: var(--color-text-muted);
}

.detail-price {
  font-size: 2rem;
  font-weight: 700;
  color: var(--color-primary);
}

.detail-price-origin {
  font-size: 0.9rem;
  color: var(--color-text-muted);
}

.detail-save {
  font-size: 0.85rem;
  color: var(--color-success);
  font-weight: 500;
}

.detail-specs {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--space-sm) var(--space-xl);
}

.spec-row {
  font-size: 0.85rem;
  color: var(--color-text-secondary);
}

.spec-label {
  color: var(--color-text-muted);
  margin-right: var(--space-sm);
}

.stock-low {
  color: var(--color-accent);
  font-weight: 600;
}

.add-cart-btn {
  display: flex;
  align-items: center;
  gap: var(--space-sm);
}

/* Detail Sections */
.detail-sections {
  margin-top: var(--space-2xl);
}

.detail-section {
  margin-bottom: var(--space-xl);
}

.section-heading {
  font-size: 1.1rem;
  font-weight: 700;
  margin-bottom: var(--space-md);
  padding-left: var(--space-md);
  border-left: 3px solid var(--color-primary);
}

.section-body {
  font-size: 0.9rem;
  line-height: 1.9;
  color: var(--color-text-secondary);
  background: var(--color-card);
  border: 1px solid var(--color-border-light);
  border-radius: var(--radius-md);
  padding: var(--space-lg);
  white-space: pre-line;
}

.director {
  font-size: 0.85rem;
  line-height: 1.8;
}

@media (max-width: 768px) {
  .detail-top {
    grid-template-columns: 1fr;
    gap: var(--space-lg);
  }

  .detail-cover {
    padding: var(--space-lg);
  }

  .detail-cover img {
    max-height: 280px;
  }

  .detail-title {
    font-size: 1.25rem;
  }

  .detail-price {
    font-size: 1.5rem;
  }

  .detail-specs {
    grid-template-columns: 1fr;
  }
}
</style>
