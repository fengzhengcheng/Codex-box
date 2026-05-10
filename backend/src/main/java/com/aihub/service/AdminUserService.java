package com.aihub.service;

import com.aihub.entity.User;
import java.util.List;

public interface AdminUserService {

    List<User> getUserList();

    boolean updateUserStatus(Long id, Integer status);

    boolean deleteUser(Long id);
}
