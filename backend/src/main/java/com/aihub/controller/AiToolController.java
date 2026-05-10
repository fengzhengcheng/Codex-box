package com.aihub.controller;

import com.aihub.common.Result;
import com.aihub.entity.AiTool;
import com.aihub.service.AiToolService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class AiToolController {

    @Autowired
    private AiToolService aiToolService;

    @GetMapping("/api/tools")
    public Result<Page<AiTool>> getList(
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) String keyword,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size) {
        Page<AiTool> result = aiToolService.getList(categoryId, keyword, page, size);
        return Result.success(result);
    }

    @GetMapping("/api/tools/{id}")
    public Result<AiTool> getById(@PathVariable Long id) {
        AiTool aiTool = aiToolService.getById(id);
        return Result.success(aiTool);
    }

    @PostMapping("/api/admin/tools")
    public Result<Void> add(@RequestBody AiTool aiTool) {
        aiToolService.add(aiTool);
        return Result.success();
    }

    @PutMapping("/api/admin/tools/{id}")
    public Result<Void> update(@PathVariable Long id, @RequestBody AiTool aiTool) {
        aiTool.setId(id);
        aiToolService.update(aiTool);
        return Result.success();
    }

    @DeleteMapping("/api/admin/tools/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        aiToolService.delete(id);
        return Result.success();
    }
}
