package com.bingran.mapper;

import com.bingran.entity.SysRole;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface SysRoleMapper {
    List<SysRole> selectAll();
    SysRole selectById(@Param("id") Long id);
    SysRole selectByCode(@Param("roleCode") String roleCode);
}
