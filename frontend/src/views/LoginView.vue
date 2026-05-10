<template>
  <div class="login-page">
    <div class="login-container">
      <div class="login-card">
        <div class="card-header">
          <div class="logo">
            <span class="logo-icon">⚡</span>
            <span class="logo-text">AIHub<span class="highlight">Pro</span></span>
          </div>
          <h2>欢迎回来</h2>
          <p>登录你的账号以继续</p>
        </div>

        <el-form ref="formRef" :model="form" :rules="rules" @submit.prevent="handleLogin">
          <el-form-item prop="username">
            <el-input
              v-model="form.username"
              placeholder="用户名"
              size="large"
              :prefix-icon="User"
            />
          </el-form-item>

          <el-form-item prop="password">
            <el-input
              v-model="form.password"
              type="password"
              placeholder="密码"
              size="large"
              :prefix-icon="Lock"
              show-password
              @keyup.enter="handleLogin"
            />
          </el-form-item>

          <el-form-item>
            <el-button
              type="primary"
              size="large"
              :loading="loading"
              class="login-btn"
              @click="handleLogin"
            >
              登 录
            </el-button>
          </el-form-item>
        </el-form>

        <div class="card-footer">
          <span>还没有账号？</span>
          <router-link to="/register">立即注册</router-link>
        </div>

        <div class="admin-link">
          <router-link to="/login">管理员入口 →</router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { User, Lock } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { useUserStore } from '@/store'

const router = useRouter()
const userStore = useUserStore()

const formRef = ref(null)
const loading = ref(false)

const form = reactive({
  username: '',
  password: ''
})

const rules = {
  username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
}

async function handleLogin() {
  if (!formRef.value) return
  await formRef.value.validate(async (valid) => {
    if (!valid) return
    loading.value = true
    try {
      await userStore.login(form.username, form.password)
      ElMessage.success('登录成功')
    } catch (e) {
      ElMessage.error(e.message || '登录失败，请检查账号密码')
    } finally {
      loading.value = false
    }
  })
}
</script>

<style scoped>
.login-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
  padding: 20px;
}

.login-card {
  width: 420px;
  background: white;
  border-radius: var(--radius-lg);
  padding: 44px 36px;
  box-shadow: 0 25px 50px rgba(0, 0, 0, 0.25);
}

.card-header {
  text-align: center;
  margin-bottom: 32px;
}

.logo {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-size: 22px;
  font-weight: 700;
  margin-bottom: 20px;
}

.logo-icon {
  font-size: 26px;
}

.highlight {
  color: var(--primary-color);
}

.card-header h2 {
  font-size: 24px;
  font-weight: 700;
  color: var(--text-primary);
  margin-bottom: 8px;
}

.card-header p {
  font-size: 14px;
  color: var(--text-light);
}

.login-btn {
  width: 100%;
  --el-button-bg-color: var(--primary-color);
  --el-button-border-color: var(--primary-color);
  --el-button-hover-bg-color: var(--primary-hover);
  --el-button-hover-border-color: var(--primary-hover);
  height: 44px;
  font-size: 16px;
  font-weight: 600;
  border-radius: 10px;
}

.card-footer {
  text-align: center;
  font-size: 14px;
  color: var(--text-secondary);
}

.card-footer a {
  color: var(--primary-color);
  font-weight: 500;
  margin-left: 4px;
}

.admin-link {
  text-align: center;
  margin-top: 20px;
  font-size: 12px;
}

.admin-link a {
  color: var(--text-light);
  text-decoration: none;
}

.admin-link a:hover {
  color: var(--primary-color);
}
</style>
