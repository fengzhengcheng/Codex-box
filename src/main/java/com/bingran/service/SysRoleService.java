package com.bingran.service;

import com.bingran.entity.SysRole;
import com.bingran.mapper.SysRoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SysRoleService {
    @Autowired
    private SysRoleMapper sysRoleMapper;

    public List<SysRole> findAll() {
        return sysRoleMapper.selectAll();
    }

    public SysRole findById(Long id) {
        return sysRoleMapper.selectById(id);
    }

    public SysRole findByCode(String roleCode) {
        return sysRoleMapper.selectByCode(roleCode);
    }
}
