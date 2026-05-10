import request from './index'

export const userApi = {
  register: (data) => request.post('/user/register', data),
  login: (data) => request.post('/user/login', data),
  profile: () => request.get('/user/profile'),
  favorites: () => request.get('/user/favorites'),
  addFavorite: (type, id) => request.post(`/user/favorite/${type}/${id}`),
  removeFavorite: (type, id) => request.delete(`/user/favorite/${type}/${id}`)
}

export const adminApi = {
  login: (data) => request.post('/admin/login', data),
  statistics: () => request.get('/admin/statistics')
}

export const toolApi = {
  list: (params) => request.get('/tools', { params }),
  detail: (id) => request.get(`/tools/${id}`),
  hot: () => request.get('/tools/hot')
}

export const toolCategoryApi = {
  list: () => request.get('/tool-categories'),
  add: (data) => request.post('/tool-categories', data),
  update: (id, data) => request.put(`/tool-categories/${id}`, data),
  delete: (id) => request.delete(`/tool-categories/${id}`)
}

export const promptApi = {
  list: (params) => request.get('/prompts', { params }),
  detail: (id) => request.get(`/prompts/${id}`),
  hot: () => request.get('/prompts/hot')
}

export const promptCategoryApi = {
  list: () => request.get('/prompt-categories'),
  add: (data) => request.post('/prompt-categories', data),
  update: (id, data) => request.put(`/prompt-categories/${id}`, data),
  delete: (id) => request.delete(`/prompt-categories/${id}`)
}

export const articleApi = {
  list: (params) => request.get('/articles', { params }),
  detail: (id) => request.get(`/articles/${id}`),
  add: (data) => request.post('/articles', data),
  update: (id, data) => request.put(`/articles/${id}`, data),
  delete: (id) => request.delete(`/articles/${id}`)
}

export const bannerApi = {
  list: () => request.get('/banners'),
  add: (data) => request.post('/banners', data),
  update: (id, data) => request.put(`/banners/${id}`, data),
  delete: (id) => request.delete(`/banners/${id}`)
}

export const adminUserApi = {
  list: (params) => request.get('/admin/users', { params }),
  updateStatus: (id, status) => request.put(`/admin/users/${id}/status`, { status }),
  delete: (id) => request.delete(`/admin/users/${id}`)
}
