package com.bingran.service;

import com.bingran.entity.WeatherAlert;
import com.bingran.mapper.WeatherAlertMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class WeatherAlertService {
    @Autowired
    private WeatherAlertMapper weatherAlertMapper;

    public List<WeatherAlert> findAll() {
        return weatherAlertMapper.selectAll();
    }

    public List<WeatherAlert> findByCityId(Long cityId) {
        return weatherAlertMapper.selectByCityId(cityId);
    }

    @Transactional
    public int save(WeatherAlert weatherAlert) {
        return weatherAlertMapper.insert(weatherAlert);
    }

    @Transactional
    public int delete(Long id) {
        return weatherAlertMapper.deleteById(id);
    }
}
