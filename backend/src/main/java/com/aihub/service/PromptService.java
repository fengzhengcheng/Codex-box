package com.aihub.service;

import com.aihub.entity.Prompt;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

public interface PromptService {

    Page<Prompt> getList(Long categoryId, String keyword, Integer page, Integer size);

    Prompt getById(Long id);

    boolean add(Prompt prompt);

    boolean update(Prompt prompt);

    boolean delete(Long id);
}
