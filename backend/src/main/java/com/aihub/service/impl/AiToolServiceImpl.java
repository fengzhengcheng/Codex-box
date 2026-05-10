package com.aihub.service.impl;

import com.aihub.entity.AiTool;
import com.aihub.mapper.AiToolMapper;
import com.aihub.service.AiToolService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class AiToolServiceImpl implements AiToolService {

    @Autowired
    private AiToolMapper aiToolMapper;

    @Override
    public Page<AiTool> getList(Long categoryId, String keyword, Integer page, Integer size) {
        Page<AiTool> pageParam = new Page<>(page != null ? page : 1, size != null ? size : 10);
        LambdaQueryWrapper<AiTool> wrapper = new LambdaQueryWrapper<>();
        if (categoryId != null) {
            wrapper.eq(AiTool::getCategoryId, categoryId);
        }
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.and(w -> w.like(AiTool::getName, keyword)
                               .or()
                               .like(AiTool::getDescription, keyword));
        }
        wrapper.orderByDesc(AiTool::getCreatedAt);
        return aiToolMapper.selectPage(pageParam, wrapper);
    }

    @Override
    public AiTool getById(Long id) {
        AiTool aiTool = aiToolMapper.selectById(id);
        if (aiTool != null) {
            aiTool.setViews(aiTool.getViews() + 1);
            aiToolMapper.updateById(aiTool);
        }
        return aiTool;
    }

    @Override
    public boolean add(AiTool aiTool) {
        aiTool.setViews(0L);
        aiTool.setCreatedAt(LocalDateTime.now());
        aiTool.setUpdatedAt(LocalDateTime.now());
        return aiToolMapper.insert(aiTool) > 0;
    }

    @Override
    public boolean update(AiTool aiTool) {
        aiTool.setUpdatedAt(LocalDateTime.now());
        return aiToolMapper.updateById(aiTool) > 0;
    }

    @Override
    public boolean delete(Long id) {
        return aiToolMapper.deleteById(id) > 0;
    }
}
