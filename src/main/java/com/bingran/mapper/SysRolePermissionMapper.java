package com.bingran.mapper;

import com.bingran.entity.SysRolePermission;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface SysRolePermissionMapper {
    List<SysRolePermission> selectAll();
    List<SysRolePermission> selectByRoleId(@Param("roleId") Long roleId);
}
