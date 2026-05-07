package com.bingran.entity;

import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class CityWeather {
    private Long id;
    private String cityName;
    private BigDecimal temperature;
    private String weatherDesc;
    private String wind;
    private BigDecimal humidity;
    private String airQuality;
    private LocalDateTime updateTime;
}
