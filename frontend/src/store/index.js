import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import router from '@/router'
import { userApi } from '@/api/modules'

export const useUserStore = defineStore('user', () => {
  const token = ref(localStorage.getItem('token') || '')
  const userInfo = ref(JSON.parse(localStorage.getItem('userInfo') || '{}'))

  const isLoggedIn = computed(() => !!token.value)
  const isAdmin = computed(() => userInfo.value.role === 'admin')

  async function login(username, password) {
    const res = await userApi.login({ username, password })
    token.value = res.data.token
    userInfo.value = res.data.user
    localStorage.setItem('token', res.data.token)
    localStorage.setItem('userInfo', JSON.stringify(res.data.user))
    if (isAdmin.value) {
      router.push('/admin/dashboard')
    } else {
      router.push('/')
    }
    return res
  }

  async function register(data) {
    const res = await userApi.register(data)
    return res
  }

  function logout() {
    token.value = ''
    userInfo.value = {}
    localStorage.removeItem('token')
    localStorage.removeItem('userInfo')
    router.push('/')
  }

  async function fetchProfile() {
    const res = await userApi.profile()
    userInfo.value = res.data
    localStorage.setItem('userInfo', JSON.stringify(res.data))
    return res
  }

  return {
    token,
    userInfo,
    isLoggedIn,
    isAdmin,
    login,
    register,
    logout,
    fetchProfile
  }
})
