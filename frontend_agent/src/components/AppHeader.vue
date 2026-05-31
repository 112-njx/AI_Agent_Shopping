<script setup>
import { ref, onMounted, watch } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { getUser, clearUser } from '../utils/constants.js'
import api from '../utils/api.js'

const router = useRouter()
const route = useRoute()

const user = ref(getUser())
const searchKeyword = ref('')
const cartCount = ref(0)
const categoryOpen = ref(false)

function loadUser() {
  user.value = getUser()
}

watch(() => route.path, loadUser)

onMounted(async () => {
  loadUser()
  try {
    const resp = await api.get('/cart/showCart')
    const cart = resp.data
    if (cart && cart.buyBooks) {
      cartCount.value = Object.keys(cart.buyBooks).length
    }
  } catch {}
})

function onSearch() {
  const q = searchKeyword.value.trim()
  if (q) {
    router.push({ path: '/search', query: { name: q } })
  }
}

function logout() {
  clearUser()
  user.value = null
  window.location.reload()
}
</script>

<template>
  <header class="app-header">
    <div class="header-inner">
      <router-link to="/" class="header-logo">
        <img :src="'/dangdang/front/images/DDlogoNEW.gif'" alt="当当网" class="logo-img" />
      </router-link>

      <form class="header-search hide-mobile" @submit.prevent="onSearch">
        <div class="search-box">
          <svg class="search-icon" viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/>
          </svg>
          <input
            v-model="searchKeyword"
            type="text"
            placeholder="搜索图书、作者、出版社..."
            class="search-input"
          />
          <button type="submit" class="search-btn">搜索</button>
        </div>
      </form>

      <nav class="header-nav hide-mobile">
        <router-link to="/cart" class="nav-item nav-cart">
          <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.8">
            <path d="M6 2L3 6v14a2 2 0 002 2h14a2 2 0 002-2V6l-3-4zM3 6h18"/>
            <path d="M16 10a4 4 0 01-8 0"/>
          </svg>
          <span>购物车</span>
          <span v-if="cartCount > 0" class="badge cart-badge">{{ cartCount }}</span>
        </router-link>

        <template v-if="user">
          <router-link to="/order/place" class="nav-item">我的订单</router-link>
          <button class="nav-item btn-ghost" @click="logout">退出</button>
        </template>
        <template v-else>
          <router-link to="/login" class="nav-item">登录</router-link>
          <router-link to="/register" class="nav-item nav-register">注册</router-link>
        </template>
      </nav>

      <button class="mobile-menu-btn show-mobile" @click="categoryOpen = !categoryOpen">
        <svg viewBox="0 0 24 24" width="24" height="24" fill="none" stroke="currentColor" stroke-width="2">
          <line x1="3" y1="6" x2="21" y2="6"/>
          <line x1="3" y1="12" x2="21" y2="12"/>
          <line x1="3" y1="18" x2="21" y2="18"/>
        </svg>
      </button>
    </div>

    <div class="header-bottom hide-mobile">
      <div class="header-inner">
        <div class="header-welcome">
          <template v-if="user">
            <span class="welcome-text">你好，</span>
            <span class="welcome-name">{{ user.nickname }}</span>
          </template>
          <span v-else class="welcome-text">欢迎光临当当网</span>
        </div>
        <nav class="header-links">
          <a href="#">今日特价</a>
          <a href="#">新书上架</a>
          <a href="#">畅销榜单</a>
          <a href="#">电子书</a>
          <a href="#">童书专区</a>
        </nav>
      </div>
    </div>
  </header>
</template>

<style scoped>
.app-header {
  background: var(--color-card);
  border-bottom: 1px solid var(--color-border);
  position: sticky;
  top: 0;
  z-index: 100;
}

.header-inner {
  max-width: var(--max-width);
  margin: 0 auto;
  padding: 10px var(--space-md);
  display: flex;
  align-items: center;
  gap: var(--space-lg);
}

.header-logo {
  flex-shrink: 0;
}

.logo-img {
  height: 40px;
  width: auto;
}

/* ---- Search ---- */
.header-search {
  flex: 1;
  max-width: 560px;
}

.search-box {
  display: flex;
  align-items: center;
  background: var(--color-bg);
  border: 1.5px solid transparent;
  border-radius: 24px;
  overflow: hidden;
  transition: all var(--transition);
}

.search-box:focus-within {
  border-color: var(--color-primary);
  background: var(--color-card);
  box-shadow: 0 0 0 3px rgba(230, 0, 18, 0.06);
}

.search-icon {
  margin-left: 14px;
  color: var(--color-text-muted);
  flex-shrink: 0;
}

.search-input {
  flex: 1;
  border: none;
  background: transparent;
  padding: 10px 12px;
  outline: none;
  font-size: 0.9rem;
  min-width: 0;
}

.search-btn {
  padding: 10px 22px;
  background: var(--color-primary);
  color: #fff;
  font-weight: 500;
  font-size: 0.9rem;
  border-radius: 0 24px 24px 0;
  transition: background var(--transition);
}

.search-btn:hover {
  background: var(--color-primary-dark);
}

/* ---- Nav ---- */
.header-nav {
  display: flex;
  align-items: center;
  gap: var(--space-sm);
  flex-shrink: 0;
}

.nav-item {
  padding: 8px 14px;
  font-size: 0.85rem;
  color: var(--color-text-secondary);
  border-radius: var(--radius-sm);
  transition: all var(--transition);
  display: inline-flex;
  align-items: center;
  gap: 4px;
  white-space: nowrap;
}

.nav-item:hover {
  color: var(--color-primary);
  background: rgba(230, 0, 18, 0.04);
}

.nav-cart {
  position: relative;
}

.cart-badge {
  position: absolute;
  top: 2px;
  right: 2px;
  font-size: 0.65rem;
  min-width: 16px;
  height: 16px;
}

.nav-register {
  background: var(--color-primary);
  color: #fff !important;
  border-radius: 20px;
  padding: 6px 18px;
  font-weight: 500;
}

.nav-register:hover {
  background: var(--color-primary-dark) !important;
}

/* ---- Bottom bar ---- */
.header-bottom {
  background: #FAFAFA;
  border-top: 1px solid var(--color-border-light);
}

.header-bottom .header-inner {
  padding: 6px var(--space-md);
}

.header-welcome {
  font-size: 0.82rem;
  color: var(--color-text-muted);
}

.welcome-name {
  color: var(--color-primary);
  font-weight: 600;
}

.header-links {
  display: flex;
  gap: var(--space-lg);
}

.header-links a {
  font-size: 0.82rem;
  color: var(--color-text-secondary);
  transition: color var(--transition);
}

.header-links a:hover {
  color: var(--color-primary);
}

/* ---- Mobile ---- */
.mobile-menu-btn {
  background: none;
  color: var(--color-text);
  padding: 6px;
}

@media (max-width: 768px) {
  .header-search {
    display: none;
  }

  .header-bottom {
    display: none;
  }

  .header-inner {
    padding: 8px var(--space-sm);
  }

  .logo-img {
    height: 30px;
  }
}
</style>
