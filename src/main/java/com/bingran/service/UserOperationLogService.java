package com.bingran.service;

import com.bingran.entity.UserOperationLog;
import com.bingran.mapper.UserOperationLogMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class UserOperationLogService {
    @Autowired
    private UserOperationLogMapper userOperationLogMapper;

    public List<UserOperationLog> findAll() {
        return userOperationLogMapper.selectAll();
    }

    public List<UserOperationLog> findByUserId(Long userId) {
        return userOperationLogMapper.selectByUserId(userId);
    }

    @Transactional
    public int save(UserOperationLog userOperationLog) {
        return userOperationLogMapper.insert(userOperationLog);
    }
}
