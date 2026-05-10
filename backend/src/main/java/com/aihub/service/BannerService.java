package com.aihub.service;

import com.aihub.entity.Banner;
import java.util.List;

public interface BannerService {

    List<Banner> getAll();

    boolean add(Banner banner);

    boolean update(Banner banner);

    boolean delete(Long id);
}
