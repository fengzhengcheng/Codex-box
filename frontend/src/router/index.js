import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('@/views/HomeView.vue'),
    meta: { title: '首页 - AIHub Pro' }
  },
  {
    path: '/tools',
    name: 'Tools',
    component: () => import('@/views/ToolsView.vue'),
    meta: { title: 'AI工具 - AIHub Pro' }
  },
  {
    path: '/tools/:id',
    name: 'ToolDetail',
    component: () => import('@/views/ToolDetailView.vue'),
    meta: { title: '工具详情 - AIHub Pro' }
  },
  {
    path: '/prompts',
    name: 'Prompts',
    component: () => import('@/views/PromptsView.vue'),
    meta: { title: '提示词库 - AIHub Pro' }
  },
  {
    path: '/prompts/:id',
    name: 'PromptDetail',
    component: () => import('@/views/PromptDetailView.vue'),
    meta: { title: '提示词详情 - AIHub Pro' }
  },
  {
    path: '/models',
    name: 'Models',
    component: () => import('@/views/ModelsView.vue'),
    meta: { title: 'AI模型对比 - AIHub Pro' }
  },
  {
    path: '/articles',
    name: 'Articles',
    component: () => import('@/views/ArticlesView.vue'),
    meta: { title: '教程文章 - AIHub Pro' }
  },
  {
    path: '/articles/:id',
    name: 'ArticleDetail',
    component: () => import('@/views/ArticleDetailView.vue'),
    meta: { title: '文章详情 - AIHub Pro' }
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/LoginView.vue'),
    meta: { title: '登录 - AIHub Pro' }
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('@/views/RegisterView.vue'),
    meta: { title: '注册 - AIHub Pro' }
  },
  {
    path: '/favorites',
    name: 'Favorites',
    component: () => import('@/views/FavoritesView.vue'),
    meta: { title: '我的收藏 - AIHub Pro', requiresAuth: true }
  },
  {
    path: '/admin/dashboard',
    name: 'AdminDashboard',
    component: () => import('@/views/admin/DashboardView.vue'),
    meta: { title: '管理后台 - AIHub Pro', requiresAuth: true, requiresAdmin: true }
  },
  {
    path: '/admin/tools',
    name: 'AdminTools',
    component: () => import('@/views/admin/ToolsManageView.vue'),
    meta: { title: '工具管理 - AIHub Pro', requiresAuth: true, requiresAdmin: true }
  },
  {
    path: '/admin/prompts',
    name: 'AdminPrompts',
    component: () => import('@/views/admin/PromptsManageView.vue'),
    meta: { title: '提示词管理 - AIHub Pro', requiresAuth: true, requiresAdmin: true }
  },
  {
    path: '/admin/categories',
    name: 'AdminCategories',
    component: () => import('@/views/admin/CategoriesManageView.vue'),
    meta: { title: '分类管理 - AIHub Pro', requiresAuth: true, requiresAdmin: true }
  },
  {
    path: '/admin/users',
    name: 'AdminUsers',
    component: () => import('@/views/admin/UsersManageView.vue'),
    meta: { title: '用户管理 - AIHub Pro', requiresAuth: true, requiresAdmin: true }
  },
  {
    path: '/admin/articles',
    name: 'AdminArticles',
    component: () => import('@/views/admin/ArticlesManageView.vue'),
    meta: { title: '文章管理 - AIHub Pro', requiresAuth: true, requiresAdmin: true }
  },
  {
    path: '/admin/banners',
    name: 'AdminBanners',
    component: () => import('@/views/admin/BannersManageView.vue'),
    meta: { title: '轮播图管理 - AIHub Pro', requiresAuth: true, requiresAdmin: true }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) return savedPosition
    return { top: 0 }
  }
})

router.beforeEach((to, from, next) => {
  document.title = to.meta.title || 'AIHub Pro'

  const token = localStorage.getItem('token')

  if (to.meta.requiresAuth && !token) {
    next('/login')
    return
  }

  if (to.meta.requiresAdmin) {
    const userInfo = JSON.parse(localStorage.getItem('userInfo') || '{}')
    if (userInfo.role !== 'admin') {
      next('/')
      return
    }
  }

  next()
})

export default router
