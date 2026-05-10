package com.aihub.service;

import com.aihub.entity.AiTool;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

public interface AiToolService {

    Page<AiTool> getList(Long categoryId, String keyword, Integer page, Integer size);

    AiTool getById(Long id);

    boolean add(AiTool aiTool);

    boolean update(AiTool aiTool);

    boolean delete(Long id);
}
