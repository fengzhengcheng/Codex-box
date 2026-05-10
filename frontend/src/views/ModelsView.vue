<template>
  <div class="models-page">
    <Navbar />

    <main class="main-content">
      <div class="page-header">
        <div class="container">
          <h1>AI 模型全面对比</h1>
          <p>深入了解各大AI模型的特点与适用场景，选择最适合你的工具</p>
        </div>
      </div>

      <div class="container">
        <section class="table-section">
          <el-table :data="models" stripe style="width: 100%" border>
            <el-table-column prop="name" label="模型名称" width="160" />
            <el-table-column prop="company" label="代表产品/公司" width="180" />
            <el-table-column prop="strength" label="主要优势" min-width="200" />
            <el-table-column prop="scenario" label="适合场景" width="200" />
            <el-table-column prop="rating" label="推荐指数" width="140" align="center">
              <template #default="{ row }">
                <el-rate
                  :model-value="row.rating"
                  disabled
                  :colors="['#10b981', '#10b981', '#10b981']"
                />
              </template>
            </el-table-column>
          </el-table>
        </section>

        <section class="cards-section">
          <div class="model-cards">
            <div v-for="model in models" :key="model.name" class="model-card">
              <div class="card-header">
                <img :src="model.logo" :alt="model.name" class="model-logo" @error="(e) => e.target.src = defaultLogo" />
                <div class="header-info">
                  <h3>{{ model.name }}</h3>
                  <span class="company">{{ model.company }}</span>
                </div>
              </div>
              <div class="card-body">
                <div class="info-item">
                  <span class="label">核心优势</span>
                  <p>{{ model.strength }}</p>
                </div>
                <div class="info-item">
                  <span class="label">适合场景</span>
                  <p>{{ model.scenario }}</p>
                </div>
                <div class="info-item" v-if="model.context">
                  <span class="label">上下文窗口</span>
                  <p>{{ model.context }}</p>
                </div>
                <div class="info-item" v-if="model.pricing">
                  <span class="label">定价模式</span>
                  <p>{{ model.pricing }}</p>
                </div>
              </div>
              <div class="card-footer">
                <el-rate :model-value="model.rating" disabled :colors="['#10b981', '#10b981', '#10b981']" />
                <a v-if="model.website" :href="model.website" target="_blank" class="visit-link">访问官网 →</a>
              </div>
            </div>
          </div>
        </section>
      </div>
    </main>

    <Footer />
  </div>
</template>

<script setup>
import { ref } from 'vue'
import Navbar from '@/components/Navbar.vue'
import Footer from '@/components/Footer.vue'

const defaultLogo = 'https://ui-avatars.com/api/?name=AI&background=374151&color=fff&size=64'

const models = ref([
  {
    name: 'GPT-4o',
    company: 'OpenAI',
    logo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/ChatGPT_logo.svg/120px-ChatGPT_logo.svg.png',
    strength: '多模态能力极强，支持文本、图像、音频输入输出，推理速度快，性价比高',
    scenario: '通用对话、代码生成、数据分析、创意写作、多模态任务',
    context: '128K tokens',
    pricing: '按量计费，免费+付费版',
    rating: 4.8,
    website: 'https://openai.com/gpt-4o'
  },
  {
    name: 'Claude 3.5 Sonnet',
    company: 'Anthropic',
    logo: 'https://www.anthropic.com/images/icons/apple-touch-icon.png',
    strength: '超长上下文理解能力强，安全性高，写作质量优秀，代码能力强',
    scenario: '长文档分析、代码开发、学术写作、安全敏感场景',
    context: '200K tokens',
    pricing: '按量计费，有免费额度',
    rating: 4.7,
    website: 'https://claude.ai'
  },
  {
    name: 'Gemini Pro / Ultra',
    company: 'Google DeepMind',
    logo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8b/Gemini_icon.svg/96px-Gemini_icon.svg.png',
    strength: 'Google生态深度集成，多模态原生支持，搜索增强能力强',
    scenario: '信息检索、Google Workspace集成、多模态内容创作',
    context: '1M - 2M tokens',
    pricing: 'API按量计费 + 免费版',
    rating: 4.5,
    website: 'https://gemini.google.com'
  },
  {
    name: 'DeepSeek-V3',
    company: '深度求索 (DeepSeek)',
    logo: 'https://api.dicebear.com/7.x/shapes/svg?seed=deepseek&backgroundColor=1e293b&textColor=ffffff',
    strength: '开源大模型标杆，代码和数学能力突出，成本极低，中文表现优秀',
    scenario: '代码开发、数学推理、中文场景、企业私有化部署',
    context: '64K - 128K tokens',
    pricing: '完全开源免费，API价格极低',
    rating: 4.6,
    website: 'https://chat.deepseek.com'
  },
  {
    name: 'Kimi K2',
    company: '月之暗面 (Moonshot AI)',
    logo: 'https://api.dicebear.com/7.x/shapes/svg?seed=kimi&backgroundColor=7c3aed&textColor=ffffff',
    strength: '超长文本处理（20万字+），中文理解优秀，文件处理能力强',
    scenario: '长文档阅读、论文分析、报告整理、法律合同审查',
    context: '200K+ tokens (约20万汉字)',
    pricing: '免费 + 付费订阅',
    rating: 4.4,
    website: 'https://kimi.moonshot.cn'
  },
  {
    name: '通义千问 Max',
    company: '阿里云',
    logo: 'https://img.alicdn.com/imgextra/i4/O1CN014fTObm1IjX6q7tQ_!!6000000003972-2-tps-128-128.png',
    strength: '中文生态完善，阿里系产品深度整合，企业服务成熟',
    scenario: '中文对话、电商场景、企业办公、钉钉集成',
    context: '32K - 128K tokens',
    pricing: '免费额度 + API按量计费',
    rating: 4.2,
    website: 'https://tongyi.aliyun.com'
  },
  {
    name: 'Llama 3 / 3.1',
    company: 'Meta (Facebook)',
    logo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Meta_Platforms_Inc._logo.svg/100px-Meta_Platforms_Inc._logo.svg.png',
    strength: '完全开源可商用，社区生态活跃，支持本地部署，多语言支持好',
    scenario: '研究实验、本地部署、隐私敏感应用、定制微调',
    context: '8K - 128K tokens',
    pricing: '完全开源免费',
    rating: 4.3,
    website: 'https://llama.meta.com'
  }
])
</script>

<style scoped>
.models-page {
  min-height: 100vh;
}

.main-content {
  padding-top: 64px;
}

.page-header {
  background: linear-gradient(135deg, #064e3b 0%, #065f46 50%, #047857 100%);
  padding: 48px 0;
  text-align: center;
}

.page-header h1 {
  font-size: 32px;
  font-weight: 700;
  color: white;
  margin-bottom: 8px;
}

.page-header p {
  color: #a7f3d0;
  font-size: 16px;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 24px;
}

.table-section {
  margin-top: 40px;
  margin-bottom: 48px;
}

.table-section :deep(.el-table) {
  border-radius: var(--radius-md);
  overflow: hidden;
}

.cards-section {
  padding-bottom: 80px;
}

.model-cards {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
  gap: 24px;
}

.model-card {
  background: white;
  border-radius: var(--radius-md);
  padding: 28px;
  box-shadow: var(--shadow-sm);
  border: 1px solid var(--border-color);
  transition: all 0.3s;
}

.model-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
  border-color: transparent;
}

.card-header {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 20px;
  padding-bottom: 16px;
  border-bottom: 1px solid #f3f4f6;
}

.model-logo {
  width: 52px;
  height: 52px;
  border-radius: 14px;
  object-fit: contain;
  background: #f8fafc;
  padding: 6px;
}

.header-info h3 {
  font-size: 18px;
  font-weight: 700;
  color: var(--text-primary);
}

.company {
  font-size: 13px;
  color: var(--text-light);
}

.info-item {
  margin-bottom: 14px;
}

.info-item .label {
  display: block;
  font-size: 12px;
  font-weight: 600;
  color: var(--text-light);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-bottom: 4px;
}

.info-item p {
  font-size: 14px;
  color: var(--text-secondary);
  line-height: 1.6;
}

.card-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 20px;
  padding-top: 16px;
  border-top: 1px solid #f3f4f6;
}

.visit-link {
  font-size: 13px;
  font-weight: 600;
  color: var(--primary-color);
  text-decoration: none;
}

.visit-link:hover {
  color: var(--primary-hover);
}

@media (max-width: 768px) {
  .model-cards {
    grid-template-columns: 1fr;
  }

  .table-section :deep(.el-table) {
    font-size: 12px;
  }
}
</style>
