package com.aihub.service;

import com.aihub.entity.Article;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

public interface ArticleService {

    Page<Article> getList(Integer page, Integer size);

    Article getById(Long id);

    boolean add(Article article);

    boolean update(Article article);

    boolean delete(Long id);
}
