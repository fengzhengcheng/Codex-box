package com.aihub.controller;

import com.aihub.common.Result;
import com.aihub.dto.LoginDTO;
import com.aihub.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @PostMapping("/login")
    public Result<String> login(@RequestBody LoginDTO loginDTO) {
        String token = adminService.login(loginDTO);
        return Result.success(token);
    }

    @GetMapping("/statistics")
    public Result<Map<String, Long>> getStatistics() {
        Map<String, Long> statistics = adminService.getStatistics();
        return Result.success(statistics);
    }
}
