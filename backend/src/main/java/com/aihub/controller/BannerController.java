package com.aihub.controller;

import com.aihub.common.Result;
import com.aihub.entity.Banner;
import com.aihub.service.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class BannerController {

    @Autowired
    private BannerService bannerService;

    @GetMapping("/api/banners")
    public Result<List<Banner>> getAll() {
        List<Banner> list = bannerService.getAll();
        return Result.success(list);
    }

    @PostMapping("/api/admin/banners")
    public Result<Void> add(@RequestBody Banner banner) {
        bannerService.add(banner);
        return Result.success();
    }

    @PutMapping("/api/admin/banners/{id}")
    public Result<Void> update(@PathVariable Long id, @RequestBody Banner banner) {
        banner.setId(id);
        bannerService.update(banner);
        return Result.success();
    }

    @DeleteMapping("/api/admin/banners/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        bannerService.delete(id);
        return Result.success();
    }
}
