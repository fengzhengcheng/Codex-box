package com.aihub.service.impl;

import com.aihub.entity.Article;
import com.aihub.mapper.ArticleMapper;
import com.aihub.service.ArticleService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticleMapper articleMapper;

    @Override
    public Page<Article> getList(Integer page, Integer size) {
        Page<Article> pageParam = new Page<>(page != null ? page : 1, size != null ? size : 10);
        LambdaQueryWrapper<Article> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(Article::getCreatedAt);
        return articleMapper.selectPage(pageParam, wrapper);
    }

    @Override
    public Article getById(Long id) {
        Article article = articleMapper.selectById(id);
        if (article != null) {
            article.setViews(article.getViews() + 1);
            articleMapper.updateById(article);
        }
        return article;
    }

    @Override
    public boolean add(Article article) {
        article.setViews(0L);
        article.setCreatedAt(LocalDateTime.now());
        article.setUpdatedAt(LocalDateTime.now());
        return articleMapper.insert(article) > 0;
    }

    @Override
    public boolean update(Article article) {
        article.setUpdatedAt(LocalDateTime.now());
        return articleMapper.updateById(article) > 0;
    }

    @Override
    public boolean delete(Long id) {
        return articleMapper.deleteById(id) > 0;
    }
}
