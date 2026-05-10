package com.aihub.service.impl;

import com.aihub.entity.ToolCategory;
import com.aihub.mapper.ToolCategoryMapper;
import com.aihub.service.ToolCategoryService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ToolCategoryServiceImpl implements ToolCategoryService {

    @Autowired
    private ToolCategoryMapper toolCategoryMapper;

    @Override
    public List<ToolCategory> getAll() {
        LambdaQueryWrapper<ToolCategory> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByAsc(ToolCategory::getSortOrder);
        return toolCategoryMapper.selectList(wrapper);
    }

    @Override
    public boolean add(ToolCategory toolCategory) {
        toolCategory.setCreatedAt(LocalDateTime.now());
        toolCategory.setUpdatedAt(LocalDateTime.now());
        return toolCategoryMapper.insert(toolCategory) > 0;
    }

    @Override
    public boolean update(ToolCategory toolCategory) {
        toolCategory.setUpdatedAt(LocalDateTime.now());
        return toolCategoryMapper.updateById(toolCategory) > 0;
    }

    @Override
    public boolean delete(Long id) {
        return toolCategoryMapper.deleteById(id) > 0;
    }
}
