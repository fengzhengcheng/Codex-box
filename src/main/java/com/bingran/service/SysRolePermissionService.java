package com.bingran.service;

import com.bingran.entity.SysRolePermission;
import com.bingran.mapper.SysRolePermissionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SysRolePermissionService {
    @Autowired
    private SysRolePermissionMapper sysRolePermissionMapper;

    public List<SysRolePermission> findAll() {
        return sysRolePermissionMapper.selectAll();
    }

    public List<SysRolePermission> findByRoleId(Long roleId) {
        return sysRolePermissionMapper.selectByRoleId(roleId);
    }
}
