export const IMG_BASE = '/dangdang/front/images'

export const bookCover = (cover) => `${IMG_BASE}/book/${cover}`

export const USER_KEY = 'dangdang_user'

export function getUser() {
  try {
    const raw = localStorage.getItem(USER_KEY)
    return raw ? JSON.parse(raw) : null
  } catch {
    return null
  }
}

export function setUser(user) {
  localStorage.setItem(USER_KEY, JSON.stringify(user))
}

export function clearUser() {
  localStorage.removeItem(USER_KEY)
}
