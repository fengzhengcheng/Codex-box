package com.aihub.controller;

import com.aihub.common.Result;
import com.aihub.dto.LoginDTO;
import com.aihub.dto.RegisterDTO;
import com.aihub.entity.Favorite;
import com.aihub.entity.User;
import com.aihub.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/register")
    public Result<String> register(@RequestBody RegisterDTO registerDTO) {
        String result = userService.register(registerDTO);
        return Result.success(result);
    }

    @PostMapping("/login")
    public Result<String> login(@RequestBody LoginDTO loginDTO) {
        String token = userService.login(loginDTO);
        return Result.success(token);
    }

    @GetMapping("/profile")
    public Result<User> getProfile(@RequestParam Long userId) {
        User user = userService.getProfile(userId);
        return Result.success(user);
    }

    @GetMapping("/favorites")
    public Result<List<Favorite>> getFavorites(@RequestParam Long userId) {
        List<Favorite> favorites = userService.getFavorites(userId);
        return Result.success(favorites);
    }

    @PostMapping("/favorite")
    public Result<Void> addFavorite(@RequestBody Map<String, Object> params) {
        Long userId = Long.valueOf(params.get("userId").toString());
        Long targetId = Long.valueOf(params.get("targetId").toString());
        String targetType = params.get("targetType").toString();
        userService.addFavorite(userId, targetId, targetType);
        return Result.success();
    }

    @DeleteMapping("/favorite/{id}")
    public Result<Void> removeFavorite(@PathVariable Long id) {
        userService.removeFavorite(id);
        return Result.success();
    }
}
