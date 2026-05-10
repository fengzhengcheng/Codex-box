package com.aihub.controller;

import com.aihub.common.Result;
import com.aihub.entity.PromptCategory;
import com.aihub.service.PromptCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class PromptCategoryController {

    @Autowired
    private PromptCategoryService promptCategoryService;

    @GetMapping("/api/prompt-categories")
    public Result<List<PromptCategory>> getAll() {
        List<PromptCategory> list = promptCategoryService.getAll();
        return Result.success(list);
    }

    @PostMapping("/api/admin/prompt-categories")
    public Result<Void> add(@RequestBody PromptCategory promptCategory) {
        promptCategoryService.add(promptCategory);
        return Result.success();
    }

    @PutMapping("/api/admin/prompt-categories/{id}")
    public Result<Void> update(@PathVariable Long id, @RequestBody PromptCategory promptCategory) {
        promptCategory.setId(id);
        promptCategoryService.update(promptCategory);
        return Result.success();
    }

    @DeleteMapping("/api/admin/prompt-categories/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        promptCategoryService.delete(id);
        return Result.success();
    }
}
