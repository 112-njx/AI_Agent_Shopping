<script setup>
import { ref, onMounted, inject } from 'vue'
import { useRouter } from 'vue-router'
import api from '../utils/api.js'
import { bookCover } from '../utils/constants.js'

const router = useRouter()
const toast = inject('toast')

const cart = ref({ buyBooks: {}, totalMoney: 0, saveMoney: 0 })
const addressList = ref([])
const selectedAddressIndex = ref(-1)
const selectedAddress = ref(null)
const submitting = ref(false)
const loading = ref(true)

onMounted(async () => {
  try {
    const [cartResp, addrResp] = await Promise.all([
      api.get('/cart/showCart'),
      api.get('/address/show')
    ])
    cart.value = cartResp.data || { buyBooks: {}, totalMoney: 0, saveMoney: 0 }
    addressList.value = addrResp.data || []
    if (addressList.value.length > 0) {
      selectAddress(0)
    }
  } catch {} finally {
    loading.value = false
  }
})

function selectAddress(index) {
  selectedAddressIndex.value = index
  selectedAddress.value = addressList.value[index]
}

function getItems() {
  const books = cart.value.buyBooks
  if (!books) return []
  return Object.entries(books).map(([id, item]) => ({ bookId: id, ...item }))
}

const itemCount = () => getItems().reduce((sum, item) => sum + item.count, 0)

async function submitOrder() {
  if (!selectedAddress.value) {
    toast('请选择收货地址', 'error')
    return
  }
  submitting.value = true
  try {
    const resp = await api.post('/order/addOrder', `addressId=${selectedAddress.value.addressId}`)
    if (resp.data.status === 'ok') {
      const { orderId, order } = resp.data
      const body = encodeURIComponent(getItems().map(i => `${i.bookName} x${i.count}`).join(', '))
      window.open(
        `/dangdang/trade/pay?orderId=${orderId}&amount=${order.total}&body=${body}&userId=${order.userId}&subject=${encodeURIComponent('当当网订单')}`
      )
      router.push(`/pay/result?orderId=${orderId}`)
    } else {
      toast(resp.data.message || '下单失败', 'error')
    }
  } catch {
    toast('下单失败，请稍后重试', 'error')
  } finally {
    submitting.value = false
  }
}
</script>

<template>
  <div class="page-container">
    <h1 class="page-title">填写订单</h1>

    <div class="cart-steps">
      <span class="cart-step">1. 购物车</span>
      <span class="step-arrow">&rarr;</span>
      <span class="cart-step active">2. 填写订单</span>
      <span class="step-arrow">&rarr;</span>
      <span class="cart-step">3. 支付订单</span>
    </div>

    <div v-if="loading" class="loading-state">
      <div class="loading-spinner"></div>
    </div>

    <template v-else>
      <!-- Address Section -->
      <section class="order-section">
        <h2 class="section-title">收货人信息</h2>
        <div v-if="!addressList.length" class="empty-state" style="padding: var(--space-xl);">
          <p>暂无收货地址</p>
          <p class="empty-hint">请先添加收货地址</p>
        </div>
        <div v-else class="address-grid">
          <div
            v-for="(addr, i) in addressList"
            :key="addr.addressId"
            class="address-card"
            :class="{ selected: selectedAddressIndex === i }"
            @click="selectAddress(i)"
          >
            <div class="addr-header">
              <strong class="addr-name">{{ addr.name }}</strong>
              <span class="addr-mobile">{{ addr.mobile }}</span>
            </div>
            <p class="addr-detail">
              {{ addr.province }} {{ addr.city }} {{ addr.district }} {{ addr.town }}
            </p>
            <p class="addr-detail">{{ addr.address }}</p>
            <div v-if="selectedAddressIndex === i" class="addr-check">
              <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
            </div>
          </div>
        </div>
      </section>

      <!-- Order Items -->
      <section class="order-section">
        <h2 class="section-title">送货清单</h2>
        <div class="order-items card">
          <div class="order-items-header">
            <span class="oi-name">商品信息</span>
            <span class="oi-price">单价</span>
            <span class="oi-qty">数量</span>
            <span class="oi-subtotal">小计</span>
          </div>
          <div v-for="item in getItems()" :key="item.bookId" class="order-item-row">
            <div class="oi-name">
              <img :src="bookCover(item.cover)" :alt="item.bookName" class="oi-img" />
              <span>{{ item.bookName }}</span>
            </div>
            <div class="oi-price">&yen;{{ item.dprice }}</div>
            <div class="oi-qty">{{ item.count }}</div>
            <div class="oi-subtotal">&yen;{{ (item.dprice * item.count).toFixed(1) }}</div>
          </div>
        </div>
      </section>

      <!-- Summary & Submit -->
      <div class="order-footer card">
        <div class="order-footer-left">
          <div v-if="selectedAddress" class="delivery-info">
            <span class="delivery-label">寄送至：</span>
            <span>{{ selectedAddress.province }} {{ selectedAddress.city }} {{ selectedAddress.district }} {{ selectedAddress.town }} {{ selectedAddress.address }}</span>
            <span class="delivery-contact">（{{ selectedAddress.name }} {{ selectedAddress.mobile }}）</span>
          </div>
        </div>
        <div class="order-footer-right">
          <div class="order-summary">
            <div class="os-row">
              <span>{{ itemCount() }} 件商品，总计：</span>
              <span class="os-total">&yen;{{ cart.totalMoney }}</span>
            </div>
            <div class="os-row os-save">
              <span>已节省：</span>
              <span>&yen;{{ cart.saveMoney }}</span>
            </div>
          </div>
          <button
            class="btn btn-primary btn-lg"
            :disabled="!selectedAddress || submitting || !getItems().length"
            @click="submitOrder"
          >
            {{ submitting ? '提交中...' : '提交订单' }}
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

.step-arrow { color: var(--color-border); font-size: 0.9rem; }

.empty-hint { font-size: 0.85rem; color: var(--color-text-muted); margin-top: var(--space-xs); }

/* ---- Sections ---- */
.order-section {
  margin-bottom: var(--space-xl);
}

.section-title {
  font-size: 1.05rem;
  font-weight: 600;
  margin-bottom: var(--space-md);
}

/* ---- Address ---- */
.address-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: var(--space-md);
}

.address-card {
  position: relative;
  padding: var(--space-md);
  border: 2px solid var(--color-border-light);
  border-radius: var(--radius-md);
  background: #FAFAFA;
  cursor: pointer;
  transition: all var(--transition);
}

.address-card:hover {
  border-color: var(--color-primary-light);
}

.address-card.selected {
  border-color: var(--color-primary);
  background: #FFF5F5;
}

.addr-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: var(--space-sm);
  font-size: 0.9rem;
}

.addr-mobile {
  color: var(--color-text-muted);
  font-size: 0.85rem;
}

.addr-detail {
  font-size: 0.85rem;
  color: var(--color-text-secondary);
  line-height: 1.5;
}

.addr-check {
  position: absolute;
  bottom: 0;
  right: 0;
  width: 0;
  height: 0;
  border-style: solid;
  border-width: 0 0 28px 28px;
  border-color: transparent transparent var(--color-primary) transparent;
}

.addr-check svg {
  position: absolute;
  bottom: -26px;
  right: 2px;
  color: #fff;
}

/* ---- Order Items ---- */
.order-items {
  border: 1px solid var(--color-border-light);
  overflow: hidden;
}

.order-items-header {
  display: grid;
  grid-template-columns: 2fr 0.7fr 0.7fr 0.7fr;
  gap: var(--space-md);
  padding: var(--space-md) var(--space-lg);
  background: #FAFAFA;
  font-weight: 600;
  font-size: 0.85rem;
  color: var(--color-text-secondary);
  border-bottom: 1px solid var(--color-border-light);
}

.order-item-row {
  display: grid;
  grid-template-columns: 2fr 0.7fr 0.7fr 0.7fr;
  gap: var(--space-md);
  align-items: center;
  padding: var(--space-md) var(--space-lg);
  border-bottom: 1px solid var(--color-border-light);
  font-size: 0.88rem;
}

.order-item-row:last-child {
  border-bottom: none;
}

.oi-name {
  display: flex;
  align-items: center;
  gap: var(--space-md);
  overflow: hidden;
}

.oi-img {
  width: 60px;
  border-radius: var(--radius-sm);
  flex-shrink: 0;
}

/* ---- Footer ---- */
.order-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--space-lg);
  border: 1px solid var(--color-border-light);
  gap: var(--space-lg);
}

.delivery-info {
  font-size: 0.85rem;
  color: var(--color-text-secondary);
  line-height: 1.6;
}

.delivery-label {
  color: var(--color-text-muted);
}

.delivery-contact {
  white-space: nowrap;
}

.order-footer-right {
  display: flex;
  align-items: center;
  gap: var(--space-xl);
  flex-shrink: 0;
}

.order-summary {
  text-align: right;
}

.os-row {
  display: flex;
  gap: var(--space-md);
  font-size: 0.88rem;
  color: var(--color-text-secondary);
}

.os-total {
  font-size: 1.2rem;
  font-weight: 700;
  color: var(--color-primary);
}

.os-save {
  font-size: 0.8rem;
  color: var(--color-success);
}

@media (max-width: 768px) {
  .address-grid {
    grid-template-columns: 1fr 1fr;
  }

  .order-items-header {
    display: none;
  }

  .order-item-row {
    grid-template-columns: 1fr;
    gap: var(--space-sm);
  }

  .oi-price, .oi-qty, .oi-subtotal {
    display: flex;
    justify-content: space-between;
  }

  .oi-price::before { content: '单价'; color: var(--color-text-muted); font-size: 0.78rem; }
  .oi-qty::before { content: '数量'; color: var(--color-text-muted); font-size: 0.78rem; }
  .oi-subtotal::before { content: '小计'; color: var(--color-text-muted); font-size: 0.78rem; }

  .order-footer {
    flex-direction: column;
    align-items: stretch;
  }

  .order-footer-right {
    flex-direction: column;
    width: 100%;
  }

  .order-footer-right .btn {
    width: 100%;
  }
}
</style>
