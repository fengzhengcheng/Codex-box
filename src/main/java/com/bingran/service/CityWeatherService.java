package com.bingran.service;

import com.bingran.dto.WeatherSaveDTO;
import com.bingran.entity.CityWeather;
import com.bingran.exception.BusinessException;
import com.bingran.mapper.CityWeatherMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class CityWeatherService {
    @Autowired
    private CityWeatherMapper cityWeatherMapper;

    public List<CityWeather> findAll() {
        return cityWeatherMapper.selectAll();
    }

    public CityWeather findById(Long id) {
        return cityWeatherMapper.selectById(id);
    }

    public CityWeather findByCityName(String cityName) {
        return cityWeatherMapper.selectByCityName(cityName);
    }

    public List<CityWeather> searchByKeyword(String keyword) {
        return cityWeatherMapper.selectByKeyword(keyword);
    }

    @Transactional
    public int save(CityWeather cityWeather) {
        if (cityWeather.getId() != null) {
            return cityWeatherMapper.update(cityWeather);
        } else {
            return cityWeatherMapper.insert(cityWeather);
        }
    }

    @Transactional
    public CityWeather saveFromDTO(WeatherSaveDTO dto) {
        validateWeather(dto);

        CityWeather weather;
        if (dto.getId() == null) {
            CityWeather existing = findByCityName(dto.getCityName());
            if (existing != null) {
                throw new BusinessException("城市天气已存在");
            }
            weather = new CityWeather();
        } else {
            weather = findById(dto.getId());
            if (weather == null) {
                throw new BusinessException(404, "天气数据不存在");
            }
            CityWeather existing = findByCityName(dto.getCityName());
            if (existing != null && !existing.getId().equals(dto.getId())) {
                throw new BusinessException("城市天气已存在");
            }
        }

        weather.setCityName(dto.getCityName().trim());
        weather.setTemperature(dto.getTemperature());
        weather.setWeatherDesc(dto.getWeatherDesc());
        weather.setWind(dto.getWind());
        weather.setHumidity(dto.getHumidity());
        weather.setAirQuality(dto.getAirQuality());
        save(weather);
        return weather;
    }

    @Transactional
    public int delete(Long id) {
        if (findById(id) == null) {
            throw new BusinessException(404, "天气数据不存在");
        }
        return cityWeatherMapper.deleteById(id);
    }

    private void validateWeather(WeatherSaveDTO dto) {
        if (dto == null) {
            throw new BusinessException("天气数据不能为空");
        }
        if (dto.getCityName() == null || dto.getCityName().trim().isEmpty()) {
            throw new BusinessException("城市名称不能为空");
        }
    }
}
