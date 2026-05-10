package com.aihub.service;

import com.aihub.entity.ToolCategory;
import java.util.List;

public interface ToolCategoryService {

    List<ToolCategory> getAll();

    boolean add(ToolCategory toolCategory);

    boolean update(ToolCategory toolCategory);

    boolean delete(Long id);
}
