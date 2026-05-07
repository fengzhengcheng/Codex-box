package com.bingran.service;

import com.bingran.entity.UserFavorite;
import com.bingran.mapper.UserFavoriteMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class UserFavoriteService {
    @Autowired
    private UserFavoriteMapper userFavoriteMapper;

    public List<UserFavorite> findAll() {
        return userFavoriteMapper.selectAll();
    }

    public UserFavorite findByUserId(Long userId) {
        return userFavoriteMapper.selectByUserId(userId);
    }

    @Transactional
    public int save(UserFavorite userFavorite) {
        if (userFavorite.getId() != null) {
            return userFavoriteMapper.update(userFavorite);
        } else {
            return userFavoriteMapper.insert(userFavorite);
        }
    }
}
