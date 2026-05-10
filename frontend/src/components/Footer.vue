<template>
  <footer class="footer">
    <div class="footer-container">
      <div class="footer-grid">
        <div class="footer-brand">
          <div class="footer-logo">
            <span class="logo-icon">⚡</span>
            <span>AIHub<span class="logo-highlight">Pro</span></span>
          </div>
          <p class="footer-desc">发现最佳AI工具与资源，助力你的创作之旅</p>
        </div>

        <div class="footer-links">
          <h4>快速导航</h4>
          <router-link to="/tools">AI工具</router-link>
          <router-link to="/prompts">提示词库</router-link>
          <router-link to="/models">模型对比</router-link>
          <router-link to="/articles">教程文章</router-link>
        </div>

        <div class="footer-links">
          <h4>热门分类</h4>
          <a href="#">文本生成</a>
          <a href="#">图像处理</a>
          <a href="#">代码辅助</a>
          <a href="#">音频视频</a>
        </div>

        <div class="footer-links">
          <h4>关于我们</h4>
          <a href="#">关于AIHub Pro</a>
          <a href="#">联系我们</a>
          <a href="#">隐私政策</a>
          <a href="#">使用条款</a>
        </div>
      </div>

      <div class="footer-bottom">
        <p>&copy; {{ currentYear }} AIHub Pro. All rights reserved.</p>
      </div>
    </div>
  </footer>
</template>

<script setup>
import { computed } from 'vue'

const currentYear = computed(() => new Date().getFullYear())
</script>

<style scoped>
.footer {
  background: #111827;
  color: #9ca3af;
  margin-top: auto;
}

.footer-container {
  max-width: 1280px;
  margin: 0 auto;
  padding: 60px 24px 24px;
}

.footer-grid {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1fr;
  gap: 48px;
  margin-bottom: 48px;
}

.footer-logo {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 20px;
  font-weight: 700;
  color: white;
  margin-bottom: 16px;
}

.logo-icon {
  font-size: 24px;
}

.logo-highlight {
  color: var(--primary-color);
}

.footer-desc {
  font-size: 14px;
  line-height: 1.7;
  max-width: 280px;
}

.footer-links h4 {
  color: white;
  font-size: 15px;
  font-weight: 600;
  margin-bottom: 20px;
}

.footer-links {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.footer-links a {
  color: #9ca3af;
  font-size: 14px;
  text-decoration: none;
  transition: color 0.2s;
}

.footer-links a:hover {
  color: var(--primary-color);
}

.footer-bottom {
  border-top: 1px solid #374151;
  padding-top: 24px;
  text-align: center;
  font-size: 13px;
}

@media (max-width: 768px) {
  .footer-grid {
    grid-template-columns: 1fr 1fr;
    gap: 32px;
  }

  .footer-brand {
    grid-column: 1 / -1;
  }
}
</style>
