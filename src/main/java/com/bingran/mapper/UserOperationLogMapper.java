package com.bingran.mapper;

import com.bingran.entity.UserOperationLog;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface UserOperationLogMapper {
    List<UserOperationLog> selectAll();
    List<UserOperationLog> selectByUserId(@Param("userId") Long userId);
    int insert(UserOperationLog userOperationLog);
}
