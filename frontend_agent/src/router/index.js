import { createRouter, createWebHashHistory } from 'vue-router'

const routes = [
  { path: '/', name: 'Home', component: () => import('../views/Home.vue') },
  { path: '/login', name: 'Login', component: () => import('../views/Login.vue') },
  { path: '/register', name: 'Register', component: () => import('../views/Register.vue') },
  { path: '/validate-email', name: 'ValidateEmail', component: () => import('../views/ValidateEmail.vue') },
  { path: '/book/:bookId', name: 'BookDetail', component: () => import('../views/BookDetail.vue') },
  { path: '/search', name: 'Search', component: () => import('../views/SearchBooks.vue') },
  { path: '/category', name: 'Category', component: () => import('../views/CategoryBooks.vue') },
  { path: '/cart', name: 'Cart', component: () => import('../views/Cart.vue') },
  { path: '/order/place', name: 'PlaceOrder', component: () => import('../views/PlaceOrder.vue') },
  { path: '/pay/result', name: 'PayResult', component: () => import('../views/PayResult.vue') }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() {
    return { top: 0 }
  }
})

export default router
