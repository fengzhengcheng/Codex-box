package com.aihub.service;

import com.aihub.entity.PromptCategory;
import java.util.List;

public interface PromptCategoryService {

    List<PromptCategory> getAll();

    boolean add(PromptCategory promptCategory);

    boolean update(PromptCategory promptCategory);

    boolean delete(Long id);
}
