package com.bingran.service;

import com.bingran.entity.SysPermission;
import com.bingran.mapper.SysPermissionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SysPermissionService {
    @Autowired
    private SysPermissionMapper sysPermissionMapper;

    public List<SysPermission> findAll() {
        return sysPermissionMapper.selectAll();
    }

    public List<SysPermission> findByRoleId(Long roleId) {
        return sysPermissionMapper.selectByRoleId(roleId);
    }
}
