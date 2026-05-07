package com.bingran.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class WeatherAlert {
    private Long id;
    private Long cityId;
    private String alertType;
    private String alertLevel;
    private LocalDateTime publishTime;
    private LocalDateTime effectiveTime;
}
