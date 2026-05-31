<script setup>
import { ref, onMounted, inject } from 'vue'
import { useRouter } from 'vue-router'
import api from '../utils/api.js'
import { bookCover } from '../utils/constants.js'

const router = useRouter()
const toast = inject('toast')

const cart = ref({ buyBooks: {}, saveMoney: 0, totalMoney: 0 })
const loading = ref(true)

onMounted(loadCart)

function loadCart() {
  loading.value = true
  api.get('/cart/showCart')
    .then(resp => {
      cart.value = resp.data || { buyBooks: {}, saveMoney: 0, totalMoney: 0 }
    })
    .catch(() => {})
    .finally(() => { loading.value = false })
}

async function updateCount(bookId, count) {
  if (count < 1) {
    toast('数量不能少于1', 'warning')
    return
  }
  try {
    await api.post('/cart/updateCartCount', `bookId=${bookId}&count=${count}`)
    loadCart()
  } catch {}
}

async function removeItem(bookId) {
  try {
    const resp = await api.post('/cart/deleteCart', `bookId=${bookId}`)
    if (resp.data.status === 'ok') {
      toast('已从购物车移除')
      loadCart()
    }
  } catch {}
}

function checkout() {
  router.push('/order/place')
}

const items = () => {
  const books = cart.value.buyBooks
  if (!books) return []
  return Object.entries(books).map(([id, item]) => ({ bookId: id, ...item }))
}
</script>

<template>
  <div class="page-container">
    <h1 class="page-title">购物车</h1>

    <div v-if="loading" class="loading-state">
      <div class="loading-spinner"></div>
    </div>

    <div v-else-if="!items().length" class="empty-state">
      <div class="empty-icon">
        <svg viewBox="0 0 24 24" width="64" height="64" fill="none" stroke="currentColor" stroke-width="1">
          <path d="M6 2L3 6v14a2 2 0 002 2h14a2 2 0 002-2V6l-3-4zM3 6h18"/><path d="M16 10a4 4 0 01-8 0"/>
        </svg>
      </div>
      <p>购物车是空的</p>
      <router-link to="/" class="btn btn-primary" style="margin-top: var(--space-lg);">去逛逛</router-link>
    </div>

    <template v-else>
      <div class="cart-steps">
        <span class="cart-step active">1. 购物车</span>
        <span class="step-arrow">&rarr;</span>
        <span class="cart-step">2. 填写订单</span>
        <span class="step-arrow">&rarr;</span>
        <span class="cart-step">3. 支付订单</span>
      </div>

      <div class="cart-table card">
        <div class="cart-table-header">
          <span class="col-name">商品信息</span>
          <span class="col-price">单价</span>
          <span class="col-qty">数量</span>
          <span class="col-subtotal">小计</span>
          <span class="col-action">操作</span>
        </div>

        <div v-for="item in items()" :key="item.bookId" class="cart-table-row">
          <div class="col-name">
            <img :src="bookCover(item.cover)" :alt="item.bookName" class="cart-item-img" />
            <span class="cart-item-name">{{ item.bookName }}</span>
          </div>
          <div class="col-price">&yen;{{ item.dprice }}</div>
          <div class="col-qty">
            <div class="qty-control">
              <button class="qty-btn" @click="updateCount(item.bookId, item.count - 1)">&minus;</button>
              <span class="qty-value">{{ item.count }}</span>
              <button class="qty-btn" @click="updateCount(item.bookId, item.count + 1)">+</button>
            </div>
          </div>
          <div class="col-subtotal">&yen;{{ (item.dprice * item.count).toFixed(1) }}</div>
          <div class="col-action">
            <button class="link-danger" @click="removeItem(item.bookId)">删除</button>
          </div>
        </div>
      </div>

      <div class="cart-footer card">
        <div class="cart-footer-left"></div>
        <div class="cart-footer-right">
          <div class="cart-summary">
            <div class="summary-row">
              <span>商品总计</span>
              <span>&yen;{{ cart.totalMoney }}</span>
            </div>
            <div class="summary-row save">
              <span>已节省</span>
              <span>-&yen;{{ cart.saveMoney }}</span>
            </div>
          </div>
          <button class="btn btn-primary btn-lg" @click="checkout">
            去结算（&yen;{{ cart.totalMoney }}）
          </button>
        </div>
      </div>
    </template>
  </div>
</template>

<style scoped>
.cart-steps {
  display: flex;
  align-items: center;
  gap: var(--space-md);
  margin-bottom: var(--space-xl);
  padding: var(--space-md) var(--space-lg);
  background: var(--color-card);
  border-radius: var(--radius-md);
  border: 1px solid var(--color-border-light);
}

.cart-step {
  font-size: 0.9rem;
  color: var(--color-text-muted);
}

.cart-step.active {
  color: var(--color-primary);
  font-weight: 600;
}

.step-arrow {
  color: var(--color-border);
  font-size: 0.9rem;
}

/* ---- Table ---- */
.cart-table {
  border: 1px solid var(--color-border-light);
  overflow: hidden;
}

.cart-table-header,
.cart-table-row {
  display: grid;
  grid-template-columns: 2fr 0.7fr 1fr 0.7fr 0.5fr;
  align-items: center;
  gap: var(--space-md);
  padding: var(--space-md) var(--space-lg);
  font-size: 0.88rem;
}

.cart-table-header {
  background: #FAFAFA;
  font-weight: 600;
  color: var(--color-text-secondary);
  border-bottom: 1px solid var(--color-border-light);
}

.cart-table-row {
  border-bottom: 1px solid var(--color-border-light);
}

.cart-table-row:last-child {
  border-bottom: none;
}

.col-name {
  display: flex;
  align-items: center;
  gap: var(--space-md);
  overflow: hidden;
}

.cart-item-img {
  width: 70px;
  height: auto;
  border-radius: var(--radius-sm);
  flex-shrink: 0;
}

.cart-item-name {
  font-weight: 500;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.qty-control {
  display: inline-flex;
  align-items: center;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  overflow: hidden;
}

.qty-btn {
  width: 30px;
  height: 30px;
  background: #FAFAFA;
  color: var(--color-text-secondary);
  font-size: 0.9rem;
  font-weight: 600;
  transition: all var(--transition);
}

.qty-btn:hover {
  background: var(--color-border-light);
  color: var(--color-text);
}

.qty-value {
  width: 40px;
  text-align: center;
  font-weight: 500;
}

.link-danger {
  background: none;
  color: var(--color-text-muted);
  font-size: 0.82rem;
  transition: color var(--transition);
}

.link-danger:hover {
  color: var(--color-primary);
}

/* ---- Footer ---- */
.cart-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--space-lg);
  margin-top: var(--space-md);
  border: 1px solid var(--color-border-light);
}

.cart-footer-right {
  display: flex;
  align-items: center;
  gap: var(--space-xl);
}

.cart-summary {
  text-align: right;
}

.summary-row {
  display: flex;
  gap: var(--space-lg);
  font-size: 0.88rem;
  color: var(--color-text-secondary);
}

.summary-row.save {
  font-size: 0.8rem;
  color: var(--color-success);
}

@media (max-width: 768px) {
  .cart-table-header {
    display: none;
  }

  .cart-table-row {
    grid-template-columns: 1fr;
    gap: var(--space-sm);
    padding: var(--space-md);
  }

  .col-price, .col-qty, .col-subtotal, .col-action {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .col-price::before { content: '单价'; color: var(--color-text-muted); font-size: 0.78rem; }
  .col-qty::before { content: '数量'; color: var(--color-text-muted); font-size: 0.78rem; }
  .col-subtotal::before { content: '小计'; color: var(--color-text-muted); font-size: 0.78rem; }

  .cart-footer {
    flex-direction: column;
    gap: var(--space-md);
  }

  .cart-footer-right {
    flex-direction: column;
    width: 100%;
  }

  .cart-footer-right .btn {
    width: 100%;
  }

  .cart-steps {
    font-size: 0.8rem;
    gap: var(--space-sm);
  }
}
</style>
