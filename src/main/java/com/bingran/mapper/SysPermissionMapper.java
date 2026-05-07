package com.bingran.mapper;

import com.bingran.entity.SysPermission;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface SysPermissionMapper {
    List<SysPermission> selectAll();
    List<SysPermission> selectByRoleId(@Param("roleId") Long roleId);
}
