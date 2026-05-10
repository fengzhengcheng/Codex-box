package com.bingran.vo;

import com.bingran.entity.CityWeather;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class WeatherVO {
    private Long id;
    private String cityName;
    private BigDecimal temperature;
    private String weatherDesc;
    private String wind;
    private BigDecimal humidity;
    private String airQuality;
    private LocalDateTime updateTime;

    public static WeatherVO fromEntity(CityWeather weather) {
        if (weather == null) {
            return null;
        }
        WeatherVO vo = new WeatherVO();
        vo.setId(weather.getId());
        vo.setCityName(weather.getCityName());
        vo.setTemperature(weather.getTemperature());
        vo.setWeatherDesc(weather.getWeatherDesc());
        vo.setWind(weather.getWind());
        vo.setHumidity(weather.getHumidity());
        vo.setAirQuality(weather.getAirQuality());
        vo.setUpdateTime(weather.getUpdateTime());
        return vo;
    }
}
