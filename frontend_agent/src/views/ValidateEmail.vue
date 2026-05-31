<script setup>
import { ref, inject } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import api from '../utils/api.js'

const router = useRouter()
const route = useRoute()
const toast = inject('toast')

const email = ref(route.query.email || '')
const activeCode = ref('')
const loading = ref(false)

async function validate() {
  if (!activeCode.value.trim()) {
    toast('请输入激活码', 'error')
    return
  }
  loading.value = true
  try {
    const resp = await api.post('/user/validateEmail',
      `email=${email.value}&activeCode=${activeCode.value}`
    )
    if (resp.data.status === 'ok') {
      toast('邮箱激活成功！')
      setTimeout(() => router.push('/login'), 1500)
    } else {
      toast(resp.data.message || '激活失败', 'error')
    }
  } catch {
    toast('激活失败，请稍后重试', 'error')
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="validate-page">
    <div class="auth-card">
      <div class="auth-header">
        <img :src="'/dangdang/front/images/DDlogoNEW.gif'" alt="当当网" class="auth-logo" />
        <h1 class="auth-title">验证邮箱</h1>
        <p class="auth-subtitle">激活码已发送至您的邮箱，请查收</p>
        <p class="auth-email">{{ email }}</p>
      </div>

      <form class="auth-form" @submit.prevent="validate">
        <div class="form-group">
          <label class="form-label">激活码</label>
          <input
            v-model="activeCode"
            type="text"
            class="form-input"
            placeholder="请输入邮件中的激活码"
          />
        </div>

        <button type="submit" class="btn btn-primary btn-lg auth-submit" :disabled="loading">
          {{ loading ? '验证中...' : '激活账号' }}
        </button>
      </form>

      <div class="auth-footer">
        <router-link to="/login" class="auth-link">返回登录</router-link>
      </div>
    </div>
  </div>
</template>

<style scoped>
.validate-page {
  min-height: calc(100vh - var(--header-height) - 200px);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-xl) var(--space-md);
}

.auth-card {
  background: var(--color-card);
  border-radius: var(--radius-lg);
  padding: var(--space-2xl);
  box-shadow: var(--shadow-lg);
  max-width: 420px;
  width: 100%;
}

.auth-header {
  text-align: center;
  margin-bottom: var(--space-xl);
}

.auth-logo {
  height: 40px;
  margin: 0 auto var(--space-md);
}

.auth-title {
  font-size: 1.4rem;
  font-weight: 700;
  margin-bottom: var(--space-sm);
}

.auth-subtitle {
  font-size: 0.9rem;
  color: var(--color-text-secondary);
}

.auth-email {
  font-weight: 600;
  color: var(--color-primary);
  margin-top: var(--space-xs);
}

.auth-submit {
  width: 100%;
}

.auth-footer {
  text-align: center;
  margin-top: var(--space-lg);
  padding-top: var(--space-lg);
  border-top: 1px solid var(--color-border-light);
}

.auth-link {
  color: var(--color-primary);
  font-weight: 600;
}

.auth-link:hover {
  text-decoration: underline;
}
</style>
