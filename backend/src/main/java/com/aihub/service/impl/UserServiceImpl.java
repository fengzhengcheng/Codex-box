package com.aihub.service.impl;

import com.aihub.dto.LoginDTO;
import com.aihub.dto.RegisterDTO;
import com.aihub.entity.Favorite;
import com.aihub.entity.User;
import com.aihub.mapper.FavoriteMapper;
import com.aihub.mapper.UserMapper;
import com.aihub.service.UserService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private FavoriteMapper favoriteMapper;

    @Override
    public String register(RegisterDTO registerDTO) {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getUsername, registerDTO.getUsername());
        if (userMapper.selectCount(wrapper) > 0) {
            throw new RuntimeException("用户名已存在");
        }

        User user = new User();
        user.setUsername(registerDTO.getUsername());
        user.setPassword(registerDTO.getPassword());
        user.setNickname(registerDTO.getNickname());
        user.setEmail(registerDTO.getEmail());
        user.setStatus(1);
        user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(LocalDateTime.now());

        userMapper.insert(user);
        return "注册成功";
    }

    @Override
    public String login(LoginDTO loginDTO) {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getUsername, loginDTO.getUsername())
               .eq(User::getPassword, loginDTO.getPassword());
        User user = userMapper.selectOne(wrapper);
        if (user == null) {
            throw new RuntimeException("用户名或密码错误");
        }
        if (user.getStatus() != 1) {
            throw new RuntimeException("账号已被禁用");
        }
        return UUID.randomUUID().toString().replace("-", "");
    }

    @Override
    public User getProfile(Long userId) {
        return userMapper.selectById(userId);
    }

    @Override
    public List<Favorite> getFavorites(Long userId) {
        LambdaQueryWrapper<Favorite> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Favorite::getUserId, userId)
               .orderByDesc(Favorite::getCreatedAt);
        return favoriteMapper.selectList(wrapper);
    }

    @Override
    public boolean addFavorite(Long userId, Long targetId, String targetType) {
        LambdaQueryWrapper<Favorite> checkWrapper = new LambdaQueryWrapper<>();
        checkWrapper.eq(Favorite::getUserId, userId)
                    .eq(Favorite::getTargetId, targetId)
                    .eq(Favorite::getTargetType, targetType);
        if (favoriteMapper.selectCount(checkWrapper) > 0) {
            throw new RuntimeException("已经收藏过了");
        }

        Favorite favorite = new Favorite();
        favorite.setUserId(userId);
        favorite.setTargetId(targetId);
        favorite.setTargetType(targetType);
        favorite.setCreatedAt(LocalDateTime.now());

        return favoriteMapper.insert(favorite) > 0;
    }

    @Override
    public boolean removeFavorite(Long id) {
        return favoriteMapper.deleteById(id) > 0;
    }
}
