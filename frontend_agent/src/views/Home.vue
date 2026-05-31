<script setup>
import { ref, onMounted, inject } from 'vue'
import api from '../utils/api.js'
import { setUser } from '../utils/constants.js'
import BookCard from '../components/BookCard.vue'
import CategorySidebar from '../components/CategorySidebar.vue'

const toast = inject('toast')

const recommendBooks = ref([])
const hotSaleBooks = ref([])
const newGroundingBooks = ref([])
const newSaleBooks = ref([])
const activeTab = ref('recommend')
const loading = ref(true)

const currentBanner = ref(0)
const banners = [
  { src: '/dangdang/front/images/top/hzjsj2020618750315.jpg', alt: '图书节' },
  { src: '/dangdang/front/images/top/200424_wj_sxzmzt_750x315.jpg', alt: '书香中国' },
  { src: '/dangdang/front/images/top/200513_rjn2_dptj_750x315.jpg', alt: '单品推荐' },
  { src: '/dangdang/front/images/top/rrkddlzjs750315.jpg', alt: '热销图书' },
  { src: '/dangdang/front/images/top/xcjg750_315.jpg', alt: '新书上架' },
  { src: '/dangdang/front/images/top/yunjisuan0422750315.jpg', alt: '云计算' }
]

let bannerTimer = null

function startBanner() {
  bannerTimer = setInterval(() => {
    currentBanner.value = (currentBanner.value + 1) % banners.length
  }, 4000)
}

onMounted(async () => {
  startBanner()
  try {
    const [r, h, n, s] = await Promise.all([
      api.get('/book/listCommented'),
      api.get('/book/listHotSale'),
      api.get('/book/listNewGrounding'),
      api.get('/book/listNewSale')
    ])
    recommendBooks.value = r.data || []
    hotSaleBooks.value = h.data || []
    newGroundingBooks.value = n.data || []
    newSaleBooks.value = s.data || []
  } catch {} finally {
    loading.value = false
  }
})

function onAdded(name) {
  toast(`《${name}》已加入购物车`)
}
</script>

<template>
  <div class="home-page">
    <!-- Banner -->
    <section class="home-banner">
      <div class="banner-track" :style="{ transform: `translateX(-${currentBanner * 100}%)` }">
        <div v-for="(b, i) in banners" :key="i" class="banner-slide">
          <img :src="b.src" :alt="b.alt" />
        </div>
      </div>
      <div class="banner-dots">
        <button
          v-for="(b, i) in banners"
          :key="i"
          class="banner-dot"
          :class="{ active: currentBanner === i }"
          @click="currentBanner = i"
        ></button>
      </div>
    </section>

    <!-- Main Content -->
    <div class="page-container">
      <div class="home-layout">
        <div class="home-sidebar">
          <CategorySidebar />
        </div>

        <div class="home-main">
          <!-- Info cards -->
          <div class="info-cards">
            <div class="info-card">
              <div class="info-icon">
                <svg viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="currentColor" stroke-width="1.5"><circle cx="12" cy="12" r="10"/><path d="M12 6v6l4 2"/></svg>
              </div>
              <div class="info-text">
                <strong>正版保障</strong>
                <span>全部正版图书</span>
              </div>
            </div>
            <div class="info-card">
              <div class="info-icon">
                <svg viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="currentColor" stroke-width="1.5"><rect x="1" y="3" width="15" height="13"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/><circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/></svg>
              </div>
              <div class="info-text">
                <strong>满99包邮</strong>
                <span>全国300+城市</span>
              </div>
            </div>
            <div class="info-card">
              <div class="info-icon">
                <svg viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3"/><path d="M12 21a9 9 0 01-9-9m9 9a9 9 0 009-9"/></svg>
              </div>
              <div class="info-text">
                <strong>60万+品种</strong>
                <span>海量图书选择</span>
              </div>
            </div>
            <div class="info-card">
              <div class="info-icon">
                <svg viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
              </div>
              <div class="info-text">
                <strong>5折封顶</strong>
                <span>每日特价好书</span>
              </div>
            </div>
          </div>

          <!-- Tabbed Book Sections -->
          <section class="book-section">
            <div class="section-tabs">
              <button
                v-for="tab in [
                  { key: 'recommend', label: '编辑推荐' },
                  { key: 'hotSale', label: '热销图书' },
                  { key: 'newGrounding', label: '最新上架' },
                  { key: 'newSale', label: '新书热卖' }
                ]"
                :key="tab.key"
                class="section-tab"
                :class="{ active: activeTab === tab.key }"
                @click="activeTab = tab.key"
              >
                {{ tab.label }}
              </button>
            </div>

            <div v-if="loading" class="loading-state">
              <div class="loading-spinner"></div>
              <span>正在加载图书...</span>
            </div>

            <div v-else class="book-grid">
              <BookCard
                v-for="book in
                  activeTab === 'recommend' ? recommendBooks :
                  activeTab === 'hotSale' ? hotSaleBooks :
                  activeTab === 'newGrounding' ? newGroundingBooks : newSaleBooks
                "
                :key="book.bookId"
                :book="book"
                @added="onAdded"
              />
            </div>
          </section>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* ---- Banner ---- */
.home-banner {
  position: relative;
  overflow: hidden;
  background: #E8E4DD;
  height: 315px;
}

.banner-track {
  display: flex;
  transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1);
  height: 100%;
}

.banner-slide {
  min-width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.banner-slide img {
  width: 750px;
  height: 315px;
  object-fit: cover;
}

.banner-dots {
  position: absolute;
  bottom: 16px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 8px;
}

.banner-dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.5);
  transition: all var(--transition);
  padding: 0;
}

.banner-dot.active {
  background: #fff;
  box-shadow: 0 0 0 2px rgba(0, 0, 0, 0.15);
}

/* ---- Layout ---- */
.home-layout {
  display: grid;
  grid-template-columns: 220px 1fr;
  gap: var(--space-lg);
  margin-top: var(--space-lg);
}

/* ---- Info Cards ---- */
.info-cards {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: var(--space-md);
  margin-bottom: var(--space-xl);
}

.info-card {
  display: flex;
  align-items: center;
  gap: var(--space-md);
  padding: var(--space-md);
  background: var(--color-card);
  border-radius: var(--radius-md);
  border: 1px solid var(--color-border-light);
}

.info-icon {
  color: var(--color-primary);
  flex-shrink: 0;
}

.info-text {
  display: flex;
  flex-direction: column;
  font-size: 0.85rem;
  line-height: 1.5;
}

.info-text span {
  color: var(--color-text-muted);
  font-size: 0.78rem;
}

/* ---- Book Section ---- */
.section-tabs {
  display: flex;
  gap: var(--space-xs);
  margin-bottom: var(--space-lg);
  border-bottom: 2px solid var(--color-border-light);
  padding-bottom: 0;
}

.section-tab {
  padding: 10px 20px;
  background: none;
  font-size: 0.9rem;
  font-weight: 500;
  color: var(--color-text-secondary);
  border-bottom: 2px solid transparent;
  margin-bottom: -2px;
  transition: all var(--transition);
}

.section-tab:hover {
  color: var(--color-primary);
}

.section-tab.active {
  color: var(--color-primary);
  border-bottom-color: var(--color-primary);
}

@media (max-width: 1024px) {
  .home-layout {
    grid-template-columns: 1fr;
  }

  .home-sidebar {
    display: none;
  }

  .info-cards {
    grid-template-columns: repeat(2, 1fr);
  }

  .home-banner {
    height: 200px;
  }

  .banner-slide img {
    width: 100%;
    height: 200px;
  }
}

@media (max-width: 768px) {
  .home-banner {
    height: 160px;
  }

  .banner-slide img {
    height: 160px;
  }

  .info-cards {
    grid-template-columns: 1fr 1fr;
  }

  .section-tabs {
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
  }

  .section-tab {
    white-space: nowrap;
    padding: 8px 14px;
    font-size: 0.82rem;
  }
}
</style>
