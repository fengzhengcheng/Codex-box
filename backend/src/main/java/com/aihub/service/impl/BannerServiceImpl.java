package com.aihub.service.impl;

import com.aihub.entity.Banner;
import com.aihub.mapper.BannerMapper;
import com.aihub.service.BannerService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class BannerServiceImpl implements BannerService {

    @Autowired
    private BannerMapper bannerMapper;

    @Override
    public List<Banner> getAll() {
        LambdaQueryWrapper<Banner> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Banner::getStatus, 1)
               .orderByAsc(Banner::getSortOrder);
        return bannerMapper.selectList(wrapper);
    }

    @Override
    public boolean add(Banner banner) {
        banner.setCreatedAt(LocalDateTime.now());
        banner.setUpdatedAt(LocalDateTime.now());
        return bannerMapper.insert(banner) > 0;
    }

    @Override
    public boolean update(Banner banner) {
        banner.setUpdatedAt(LocalDateTime.now());
        return bannerMapper.updateById(banner) > 0;
    }

    @Override
    public boolean delete(Long id) {
        return bannerMapper.deleteById(id) > 0;
    }
}
