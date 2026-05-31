<script setup>
import { ref, provide } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import AppHeader from './components/AppHeader.vue'
import AppFooter from './components/AppFooter.vue'
import Toast from './components/Toast.vue'

const router = useRouter()
const route = useRoute()

const toasts = ref([])
let toastId = 0

function showToast(message, type = 'success', duration = 2500) {
  const id = ++toastId
  toasts.value.push({ id, message, type })
  setTimeout(() => {
    toasts.value = toasts.value.filter(t => t.id !== id)
  }, duration)
}

provide('toast', showToast)

const hideHeader = ref(false)
const hideFooter = ref(false)
</script>

<template>
  <AppHeader v-if="!hideHeader" />
  <main>
    <router-view />
  </main>
  <AppFooter v-if="!hideFooter" />
  <Toast :toasts="toasts" />
</template>

<style scoped>
main {
  min-height: calc(100vh - var(--header-height) - 200px);
}
</style>
