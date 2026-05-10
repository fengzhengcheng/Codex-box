package com.aihub.service;

import com.aihub.dto.LoginDTO;
import com.aihub.dto.RegisterDTO;
import com.aihub.entity.Favorite;
import com.aihub.entity.User;
import java.util.List;

public interface UserService {

    String register(RegisterDTO registerDTO);

    String login(LoginDTO loginDTO);

    User getProfile(Long userId);

    List<Favorite> getFavorites(Long userId);

    boolean addFavorite(Long userId, Long targetId, String targetType);

    boolean removeFavorite(Long id);
}
