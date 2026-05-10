package com.aihub.controller;

import com.aihub.common.Result;
import com.aihub.entity.ToolCategory;
import com.aihub.service.ToolCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ToolCategoryController {

    @Autowired
    private ToolCategoryService toolCategoryService;

    @GetMapping("/api/tool-categories")
    public Result<List<ToolCategory>> getAll() {
        List<ToolCategory> list = toolCategoryService.getAll();
        return Result.success(list);
    }

    @PostMapping("/api/admin/tool-categories")
    public Result<Void> add(@RequestBody ToolCategory toolCategory) {
        toolCategoryService.add(toolCategory);
        return Result.success();
    }

    @PutMapping("/api/admin/tool-categories/{id}")
    public Result<Void> update(@PathVariable Long id, @RequestBody ToolCategory toolCategory) {
        toolCategory.setId(id);
        toolCategoryService.update(toolCategory);
        return Result.success();
    }

    @DeleteMapping("/api/admin/tool-categories/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        toolCategoryService.delete(id);
        return Result.success();
    }
}
