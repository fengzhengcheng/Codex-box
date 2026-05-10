package com.aihub.service.impl;

import com.aihub.entity.PromptCategory;
import com.aihub.mapper.PromptCategoryMapper;
import com.aihub.service.PromptCategoryService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class PromptCategoryServiceImpl implements PromptCategoryService {

    @Autowired
    private PromptCategoryMapper promptCategoryMapper;

    @Override
    public List<PromptCategory> getAll() {
        LambdaQueryWrapper<PromptCategory> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByAsc(PromptCategory::getSortOrder);
        return promptCategoryMapper.selectList(wrapper);
    }

    @Override
    public boolean add(PromptCategory promptCategory) {
        promptCategory.setCreatedAt(LocalDateTime.now());
        promptCategory.setUpdatedAt(LocalDateTime.now());
        return promptCategoryMapper.insert(promptCategory) > 0;
    }

    @Override
    public boolean update(PromptCategory promptCategory) {
        promptCategory.setUpdatedAt(LocalDateTime.now());
        return promptCategoryMapper.updateById(promptCategory) > 0;
    }

    @Override
    public boolean delete(Long id) {
        return promptCategoryMapper.deleteById(id) > 0;
    }
}
