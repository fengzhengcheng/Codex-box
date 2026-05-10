package com.aihub.controller;

import com.aihub.common.Result;
import com.aihub.entity.Prompt;
import com.aihub.service.PromptService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class PromptController {

    @Autowired
    private PromptService promptService;

    @GetMapping("/api/prompts")
    public Result<Page<Prompt>> getList(
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) String keyword,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size) {
        Page<Prompt> result = promptService.getList(categoryId, keyword, page, size);
        return Result.success(result);
    }

    @GetMapping("/api/prompts/{id}")
    public Result<Prompt> getById(@PathVariable Long id) {
        Prompt prompt = promptService.getById(id);
        return Result.success(prompt);
    }

    @PostMapping("/api/admin/prompts")
    public Result<Void> add(@RequestBody Prompt prompt) {
        promptService.add(prompt);
        return Result.success();
    }

    @PutMapping("/api/admin/prompts/{id}")
    public Result<Void> update(@PathVariable Long id, @RequestBody Prompt prompt) {
        prompt.setId(id);
        promptService.update(prompt);
        return Result.success();
    }

    @DeleteMapping("/api/admin/prompts/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        promptService.delete(id);
        return Result.success();
    }
}
