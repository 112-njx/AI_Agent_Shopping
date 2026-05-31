<script setup>
import { ref, inject } from 'vue'
import { useRouter } from 'vue-router'
import api from '../utils/api.js'
import { setUser } from '../utils/constants.js'

const router = useRouter()
const toast = inject('toast')

const email = ref('')
const password = ref('')
const loading = ref(false)

async function login() {
  if (!email.value.trim() || !password.value.trim()) {
    toast('请填写邮箱和密码', 'error')
    return
  }
  loading.value = true
  try {
    const resp = await api.post('/user/login', `email=${email.value}&password=${password.value}`)
    if (resp.data.status === 'ok') {
      const uResp = await api.get('/user/showUser')
      if (uResp.data && uResp.data.userId) {
        setUser(uResp.data)
      }
      toast('登录成功')
      router.push('/')
    } else {
      toast(resp.data.message || '登录失败', 'error')
    }
  } catch {
    toast('登录失败，请稍后重试', 'error')
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="login-page">
    <div class="auth-container">
      <div class="auth-card">
        <div class="auth-header">
          <img :src="'/dangdang/front/images/DDlogoNEW.gif'" alt="当当网" class="auth-logo" />
          <h1 class="auth-title">登录当当网</h1>
          <p class="auth-subtitle">全球最大的中文网上书店</p>
        </div>

        <form class="auth-form" @submit.prevent="login">
          <div class="form-group">
            <label class="form-label">邮箱地址</label>
            <input
              v-model="email"
              type="email"
              class="form-input"
              placeholder="请输入注册邮箱"
              autocomplete="email"
            />
          </div>

          <div class="form-group">
            <label class="form-label">密码</label>
            <input
              v-model="password"
              type="password"
              class="form-input"
              placeholder="请输入密码"
              autocomplete="current-password"
            />
          </div>

          <button type="submit" class="btn btn-primary btn-lg auth-submit" :disabled="loading">
            {{ loading ? '登录中...' : '登录' }}
          </button>
        </form>

        <div class="auth-footer">
          <span>还没有账号？</span>
          <router-link to="/register" class="auth-link">立即注册</router-link>
        </div>
      </div>

      <div class="auth-features">
        <div class="feature-item">
          <svg viewBox="0 0 24 24" width="32" height="32" fill="none" stroke="currentColor" stroke-width="1.2">
            <path d="M22 12h-4l-3 9L9 3l-3 9H2"/>
          </svg>
          <div>
            <strong>60万+</strong>
            <span>精选图书品种</span>
          </div>
        </div>
        <div class="feature-item">
          <svg viewBox="0 0 24 24" width="32" height="32" fill="none" stroke="currentColor" stroke-width="1.2">
            <path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/>
          </svg>
          <div>
            <strong>5折起</strong>
            <span>每日特惠不断</span>
          </div>
        </div>
        <div class="feature-item">
          <svg viewBox="0 0 24 24" width="32" height="32" fill="none" stroke="currentColor" stroke-width="1.2">
            <rect x="1" y="3" width="15" height="13"/>
            <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
            <circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/>
          </svg>
          <div>
            <strong>满99包邮</strong>
            <span>全国300+城市</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.login-page {
  min-height: calc(100vh - var(--header-height) - 200px);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-xl) var(--space-md);
  background:
    radial-gradient(circle at 20% 50%, rgba(230, 0, 18, 0.03) 0%, transparent 50%),
    radial-gradient(circle at 80% 20%, rgba(255, 107, 53, 0.04) 0%, transparent 50%),
    var(--color-bg);
}

.auth-container {
  display: flex;
  align-items: center;
  gap: var(--space-3xl);
  max-width: 900px;
  width: 100%;
}

.auth-card {
  background: var(--color-card);
  border-radius: var(--radius-lg);
  padding: var(--space-2xl);
  box-shadow: var(--shadow-lg);
  flex: 1;
  max-width: 420px;
}

.auth-header {
  text-align: center;
  margin-bottom: var(--space-xl);
}

.auth-logo {
  height: 48px;
  margin: 0 auto var(--space-md);
}

.auth-title {
  font-size: 1.5rem;
  font-weight: 700;
  margin-bottom: var(--space-xs);
}

.auth-subtitle {
  font-size: 0.85rem;
  color: var(--color-text-muted);
}

.auth-submit {
  width: 100%;
  margin-top: var(--space-sm);
}

.auth-footer {
  text-align: center;
  margin-top: var(--space-xl);
  padding-top: var(--space-lg);
  border-top: 1px solid var(--color-border-light);
  font-size: 0.9rem;
  color: var(--color-text-secondary);
}

.auth-link {
  color: var(--color-primary);
  font-weight: 600;
  margin-left: var(--space-xs);
}

.auth-link:hover {
  text-decoration: underline;
}

/* Features */
.auth-features {
  display: none;
  flex-direction: column;
  gap: var(--space-xl);
}

.feature-item {
  display: flex;
  align-items: center;
  gap: var(--space-md);
  color: var(--color-text-secondary);
}

.feature-item svg {
  color: var(--color-primary);
  opacity: 0.7;
  flex-shrink: 0;
}

.feature-item div {
  display: flex;
  flex-direction: column;
}

.feature-item strong {
  font-size: 1rem;
  color: var(--color-text);
}

.feature-item span {
  font-size: 0.85rem;
}

@media (min-width: 768px) {
  .auth-features {
    display: flex;
  }
}
</style>
