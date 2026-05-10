package com.aihub.controller;

import com.aihub.common.Result;
import com.aihub.entity.Article;
import com.aihub.service.ArticleService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @GetMapping("/api/articles")
    public Result<Page<Article>> getList(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size) {
        Page<Article> result = articleService.getList(page, size);
        return Result.success(result);
    }

    @GetMapping("/api/articles/{id}")
    public Result<Article> getById(@PathVariable Long id) {
        Article article = articleService.getById(id);
        return Result.success(article);
    }

    @PostMapping("/api/admin/articles")
    public Result<Void> add(@RequestBody Article article) {
        articleService.add(article);
        return Result.success();
    }

    @PutMapping("/api/admin/articles/{id}")
    public Result<Void> update(@PathVariable Long id, @RequestBody Article article) {
        article.setId(id);
        articleService.update(article);
        return Result.success();
    }

    @DeleteMapping("/api/admin/articles/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        articleService.delete(id);
        return Result.success();
    }
}
