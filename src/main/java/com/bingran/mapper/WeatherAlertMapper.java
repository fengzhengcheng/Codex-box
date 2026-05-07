package com.bingran.mapper;

import com.bingran.entity.WeatherAlert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface WeatherAlertMapper {
    List<WeatherAlert> selectAll();
    List<WeatherAlert> selectByCityId(@Param("cityId") Long cityId);
    int insert(WeatherAlert weatherAlert);
    int deleteById(@Param("id") Long id);
}
