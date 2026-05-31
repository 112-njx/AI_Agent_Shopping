import axios from 'axios'

const api = axios.create({
  baseURL: '/dangdang',
  timeout: 15000,
  headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
})

api.interceptors.response.use(
  response => response,
  error => {
    const msg = error.response?.data?.message || error.message || '请求失败'
    console.error('[API Error]', msg)
    return Promise.reject(error)
  }
)

export default api
