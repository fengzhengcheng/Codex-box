package com.aihub.service.impl;

import com.aihub.entity.Prompt;
import com.aihub.mapper.PromptMapper;
import com.aihub.service.PromptService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class PromptServiceImpl implements PromptService {

    @Autowired
    private PromptMapper promptMapper;

    @Override
    public Page<Prompt> getList(Long categoryId, String keyword, Integer page, Integer size) {
        Page<Prompt> pageParam = new Page<>(page != null ? page : 1, size != null ? size : 10);
        LambdaQueryWrapper<Prompt> wrapper = new LambdaQueryWrapper<>();
        if (categoryId != null) {
            wrapper.eq(Prompt::getCategoryId, categoryId);
        }
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.and(w -> w.like(Prompt::getTitle, keyword)
                               .or()
                               .like(Prompt::getContent, keyword));
        }
        wrapper.orderByDesc(Prompt::getCreatedAt);
        return promptMapper.selectPage(pageParam, wrapper);
    }

    @Override
    public Prompt getById(Long id) {
        Prompt prompt = promptMapper.selectById(id);
        if (prompt != null) {
            prompt.setViews(prompt.getViews() + 1);
            promptMapper.updateById(prompt);
        }
        return prompt;
    }

    @Override
    public boolean add(Prompt prompt) {
        prompt.setViews(0L);
        prompt.setCreatedAt(LocalDateTime.now());
        prompt.setUpdatedAt(LocalDateTime.now());
        return promptMapper.insert(prompt) > 0;
    }

    @Override
    public boolean update(Prompt prompt) {
        prompt.setUpdatedAt(LocalDateTime.now());
        return promptMapper.updateById(prompt) > 0;
    }

    @Override
    public boolean delete(Long id) {
        return promptMapper.deleteById(id) > 0;
    }
}
