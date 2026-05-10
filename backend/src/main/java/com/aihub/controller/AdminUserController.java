package com.aihub.controller;

import com.aihub.common.Result;
import com.aihub.entity.User;
import com.aihub.service.AdminUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin")
public class AdminUserController {

    @Autowired
    private AdminUserService adminUserService;

    @GetMapping("/users")
    public Result<List<User>> getUserList() {
        List<User> list = adminUserService.getUserList();
        return Result.success(list);
    }

    @PutMapping("/users/{id}/status")
    public Result<Void> updateUserStatus(@PathVariable Long id, @RequestParam Integer status) {
        adminUserService.updateUserStatus(id, status);
        return Result.success();
    }

    @DeleteMapping("/users/{id}")
    public Result<Void> deleteUser(@PathVariable Long id) {
        adminUserService.deleteUser(id);
        return Result.success();
    }
}
