package com.bingran.dto;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class WeatherSaveDTO {
    private Long id;
    private String cityName;
    private BigDecimal temperature;
    private String weatherDesc;
    private String wind;
    private BigDecimal humidity;
    private String airQuality;
}
