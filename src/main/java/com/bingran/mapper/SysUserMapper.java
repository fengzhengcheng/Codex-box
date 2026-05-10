package com.bingran.mapper;

import com.bingran.entity.SysUser;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface SysUserMapper {
    List<SysUser> selectAll();
    SysUser selectById(@Param("id") Long id);
    SysUser selectByUsername(@Param("username") String username);
    int insert(SysUser sysUser);
    int update(SysUser sysUser);
    int deleteById(@Param("id") Long id);
}
