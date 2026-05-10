package com.bingran.mapper;

import com.bingran.entity.CityWeather;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface CityWeatherMapper {
    List<CityWeather> selectAll();
    CityWeather selectById(@Param("id") Long id);
    CityWeather selectByCityName(@Param("cityName") String cityName);
    int insert(CityWeather cityWeather);
    int update(CityWeather cityWeather);
    int deleteById(@Param("id") Long id);
    List<CityWeather> selectByKeyword(@Param("keyword") String keyword);
}
