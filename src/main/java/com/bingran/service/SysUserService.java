package com.bingran.service;

import com.bingran.dto.UserSaveDTO;
import com.bingran.entity.SysUser;
import com.bingran.exception.BusinessException;
import com.bingran.mapper.SysUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class SysUserService {
    @Autowired
    private SysUserMapper sysUserMapper;

    public List<SysUser> findAll() {
        return sysUserMapper.selectAll();
    }

    public SysUser findById(Long id) {
        return sysUserMapper.selectById(id);
    }

    public SysUser findByUsername(String username) {
        return sysUserMapper.selectByUsername(username);
    }

    @Transactional
    public int save(SysUser sysUser) {
        if (sysUser.getId() != null) {
            return sysUserMapper.update(sysUser);
        } else {
            return sysUserMapper.insert(sysUser);
        }
    }

    @Transactional
    public SysUser saveFromDTO(UserSaveDTO dto) {
        validateUser(dto);

        SysUser user;
        if (dto.getId() == null) {
            SysUser existing = findByUsername(dto.getUsername());
            if (existing != null) {
                throw new BusinessException("用户名已存在");
            }
            user = new SysUser();
            user.setAvatar("/static/images/default-avatar.png");
        } else {
            user = findById(dto.getId());
            if (user == null) {
                throw new BusinessException(404, "用户不存在");
            }
            SysUser existing = findByUsername(dto.getUsername());
            if (existing != null && !existing.getId().equals(dto.getId())) {
                throw new BusinessException("用户名已存在");
            }
        }

        user.setUsername(dto.getUsername().trim());
        user.setPassword(dto.getPassword().trim());
        user.setPhone(trimToNull(dto.getPhone()));
        user.setRole(isBlank(dto.getRole()) ? "user" : dto.getRole().trim());
        user.setStatus(isBlank(dto.getStatus()) ? "正常" : dto.getStatus().trim());
        save(user);
        return user;
    }

    @Transactional
    public int delete(Long id) {
        if (findById(id) == null) {
            throw new BusinessException(404, "用户不存在");
        }
        return sysUserMapper.deleteById(id);
    }

    private void validateUser(UserSaveDTO dto) {
        if (dto == null) {
            throw new BusinessException("用户数据不能为空");
        }
        if (isBlank(dto.getUsername())) {
            throw new BusinessException("用户名不能为空");
        }
        if (isBlank(dto.getPassword())) {
            throw new BusinessException("密码不能为空");
        }
    }

    private String trimToNull(String value) {
        return isBlank(value) ? null : value.trim();
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
