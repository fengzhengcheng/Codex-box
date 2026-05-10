package com.bingran.mapper;

import com.bingran.entity.UserFavorite;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface UserFavoriteMapper {
    List<UserFavorite> selectAll();
    UserFavorite selectByUserId(@Param("userId") Long userId);
    int insert(UserFavorite userFavorite);
    int update(UserFavorite userFavorite);
}
