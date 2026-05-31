<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import api from '../utils/api.js'

const route = useRoute()

const order = ref(null)
const loading = ref(true)
const statusText = ref('查询中...')
const statusType = ref('loading')

onMounted(async () => {
  const orderId = route.query.orderId
  if (!orderId) {
    statusText.value = '缺少订单号'
    statusType.value = 'error'
    loading.value = false
    return
  }

  try {
    const resp = await api.get(`/order/getPaidOrderInfo?orderId=${orderId}`)
    order.value = resp.data || {}
    if (order.value.status === 'PAID') {
      statusText.value = '支付成功'
      statusType.value = 'success'
    } else {
      statusText.value = '等待支付...'
      statusType.value = 'pending'
    }
  } catch {
    statusText.value = '查询订单失败'
    statusType.value = 'error'
  } finally {
    loading.value = false
  }
})
</script>

<template>
  <div class="page-container">
    <div v-if="loading" class="loading-state" style="min-height: 50vh;">
      <div class="loading-spinner"></div>
      <span>查询支付结果...</span>
    </div>

    <template v-else>
      <div class="result-card card">
        <div class="result-icon" :class="statusType">
          <template v-if="statusType === 'success'">
            <svg viewBox="0 0 24 24" width="64" height="64" fill="none" stroke="currentColor" stroke-width="1.5">
              <circle cx="12" cy="12" r="10"/><path d="m8 12 3 3 5-5"/>
            </svg>
          </template>
          <template v-else-if="statusType === 'error'">
            <svg viewBox="0 0 24 24" width="64" height="64" fill="none" stroke="currentColor" stroke-width="1.5">
              <circle cx="12" cy="12" r="10"/><path d="m15 9-6 6"/><path d="m9 9 6 6"/>
            </svg>
          </template>
          <template v-else>
            <svg viewBox="0 0 24 24" width="64" height="64" fill="none" stroke="currentColor" stroke-width="1.5">
              <circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/>
            </svg>
          </template>
        </div>

        <h1 class="result-title">{{ statusText }}</h1>

        <div v-if="order" class="result-info">
          <div class="info-row">
            <span class="info-label">订单号</span>
            <span class="info-value">{{ order.orderId }}</span>
          </div>
          <div class="info-row">
            <span class="info-label">订单金额</span>
            <span class="info-value price">&yen;{{ order.total }}</span>
          </div>
          <div class="info-row">
            <span class="info-label">订单状态</span>
            <span class="info-value" :class="{ 'text-success': order.status === 'PAID', 'text-warning': order.status !== 'PAID' }">
              {{ order.status === 'PAID' ? '已支付' : order.status === 'UNPAID' ? '待支付' : order.status }}
            </span>
          </div>
          <div class="info-row">
            <span class="info-label">收货人</span>
            <span class="info-value">{{ order.name }} {{ order.mobile }}</span>
          </div>
          <div class="info-row">
            <span class="info-label">收货地址</span>
            <span class="info-value">{{ order.province }} {{ order.city }} {{ order.district }} {{ order.town }} {{ order.address }}</span>
          </div>
          <div class="info-row">
            <span class="info-label">下单时间</span>
            <span class="info-value">{{ order.createDate }}</span>
          </div>
        </div>

        <div class="result-actions">
          <router-link to="/" class="btn btn-outline">继续购物</router-link>
          <router-link to="/cart" class="btn btn-primary">查看购物车</router-link>
        </div>
      </div>
    </template>
  </div>
</template>

<style scoped>
.result-card {
  max-width: 520px;
  margin: var(--space-3xl) auto;
  padding: var(--space-2xl);
  border: 1px solid var(--color-border-light);
  text-align: center;
}

.result-icon {
  margin-bottom: var(--space-lg);
}

.result-icon.success { color: var(--color-success); }
.result-icon.error { color: var(--color-primary); }
.result-icon.pending { color: var(--color-accent); }

.result-title {
  font-size: 1.5rem;
  font-weight: 700;
  margin-bottom: var(--space-xl);
}

.result-info {
  text-align: left;
  margin-bottom: var(--space-xl);
  background: #FAFAFA;
  border-radius: var(--radius-md);
  padding: var(--space-lg);
}

.info-row {
  display: flex;
  justify-content: space-between;
  padding: 8px 0;
  font-size: 0.88rem;
  border-bottom: 1px solid var(--color-border-light);
}

.info-row:last-child {
  border-bottom: none;
}

.info-label {
  color: var(--color-text-muted);
  flex-shrink: 0;
}

.info-value {
  color: var(--color-text);
  font-weight: 500;
  text-align: right;
}

.info-value.price {
  color: var(--color-primary);
  font-weight: 700;
}

.text-success { color: var(--color-success) !important; }
.text-warning { color: var(--color-accent) !important; }

.result-actions {
  display: flex;
  gap: var(--space-md);
  justify-content: center;
}
</style>
