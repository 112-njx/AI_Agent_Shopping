<script setup>
import { ref, inject } from 'vue'
import { useRouter } from 'vue-router'
import api from '../utils/api.js'

const router = useRouter()
const toast = inject('toast')

const email = ref('')
const nickname = ref('')
const password = ref('')
const password2 = ref('')
const code = ref('')
const captchaSrc = ref('/dangdang/user/validateCode')
const loading = ref(false)

function refreshCaptcha() {
  captchaSrc.value = '/dangdang/user/validateCode?' + Math.random()
}

async function register() {
  if (!email.value.trim() || !nickname.value.trim() || !password.value.trim()) {
    toast('请填写所有必填项', 'error')
    return
  }
  if (password.value !== password2.value) {
    toast('两次密码输入不一致', 'error')
    return
  }
  if (!code.value.trim()) {
    toast('请输入验证码', 'error')
    return
  }
  loading.value = true
  try {
    const resp = await api.post('/user/register',
      `email=${email.value}&password=${password.value}&nickname=${nickname.value}&code=${code.value}`
    )
    if (resp.data.status === 'ok') {
      toast('注册成功，请验证邮箱')
      router.push(`/validate-email?email=${encodeURIComponent(email.value)}`)
    } else {
      toast(resp.data.message || '注册失败', 'error')
      refreshCaptcha()
      code.value = ''
    }
  } catch {
    toast('注册失败，请稍后重试', 'error')
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="register-page">
    <div class="auth-card">
      <div class="auth-header">
        <img :src="'/dangdang/front/images/DDlogoNEW.gif'" alt="当当网" class="auth-logo" />
        <h1 class="auth-title">创建当当网账号</h1>
        <div class="steps">
          <span class="step active">1. 填写信息</span>
          <span class="step-divider"></span>
          <span class="step">2. 验证邮箱</span>
          <span class="step-divider"></span>
          <span class="step">3. 注册成功</span>
        </div>
      </div>

      <form class="auth-form" @submit.prevent="register">
        <div class="form-group">
          <label class="form-label">邮箱地址 <span class="required">*</span></label>
          <input v-model="email" type="email" class="form-input" placeholder="用于接收验证邮件" />
        </div>

        <div class="form-group">
          <label class="form-label">昵称 <span class="required">*</span></label>
          <input v-model="nickname" type="text" class="form-input" placeholder="4-20位，可用中英文、数字" />
        </div>

        <div class="form-group">
          <label class="form-label">密码 <span class="required">*</span></label>
          <input v-model="password" type="password" class="form-input" placeholder="6-20位密码" />
        </div>

        <div class="form-group">
          <label class="form-label">确认密码 <span class="required">*</span></label>
          <input v-model="password2" type="password" class="form-input" placeholder="请再次输入密码" />
        </div>

        <div class="form-group">
          <label class="form-label">验证码 <span class="required">*</span></label>
          <div class="captcha-row">
            <input v-model="code" type="text" class="form-input captcha-input" placeholder="请输入图片中的字符" maxlength="4" />
            <img :src="captchaSrc" alt="验证码" class="captcha-img" @click="refreshCaptcha" title="点击刷新验证码" />
          </div>
          <a href="#" class="captcha-refresh" @click.prevent="refreshCaptcha">看不清？换一张</a>
        </div>

        <button type="submit" class="btn btn-primary btn-lg auth-submit" :disabled="loading">
          {{ loading ? '注册中...' : '注册' }}
        </button>
      </form>

      <div class="auth-footer">
        <span>已有账号？</span>
        <router-link to="/login" class="auth-link">立即登录</router-link>
      </div>
    </div>
  </div>
</template>

<style scoped>
.register-page {
  min-height: calc(100vh - var(--header-height) - 200px);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-xl) var(--space-md);
  background:
    radial-gradient(circle at 80% 60%, rgba(230, 0, 18, 0.03) 0%, transparent 50%),
    var(--color-bg);
}

.auth-card {
  background: var(--color-card);
  border-radius: var(--radius-lg);
  padding: var(--space-2xl);
  box-shadow: var(--shadow-lg);
  max-width: 460px;
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
  margin-bottom: var(--space-md);
}

.steps {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-sm);
  font-size: 0.8rem;
  color: var(--color-text-muted);
}

.step.active {
  color: var(--color-primary);
  font-weight: 600;
}

.step-divider {
  width: 20px;
  height: 1px;
  background: var(--color-border);
}

.required {
  color: var(--color-primary);
}

.captcha-row {
  display: flex;
  gap: var(--space-md);
}

.captcha-input {
  flex: 1;
  min-width: 0;
}

.captcha-img {
  height: 44px;
  border-radius: var(--radius-sm);
  cursor: pointer;
  border: 1px solid var(--color-border);
}

.captcha-refresh {
  font-size: 0.78rem;
  color: var(--color-text-muted);
  margin-top: var(--space-xs);
  display: inline-block;
}

.captcha-refresh:hover {
  color: var(--color-primary);
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
</style>
