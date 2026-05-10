package com.bingran.controller.api;

import com.bingran.annotation.OperationLog;
import com.bingran.common.Result;
import com.bingran.dto.WeatherSaveDTO;
import com.bingran.entity.CityWeather;
import com.bingran.exception.BusinessException;
import com.bingran.service.CityWeatherService;
import com.bingran.vo.WeatherVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/weather")
public class WeatherApiController {

    @Autowired
    private CityWeatherService cityWeatherService;

    @GetMapping("/list")
    public Result<List<WeatherVO>> list() {
        List<WeatherVO> weathers = cityWeatherService.findAll().stream()
                .map(WeatherVO::fromEntity)
                .toList();
        return Result.success(weathers);
    }

    @GetMapping("/search")
    public Result<List<WeatherVO>> search(@RequestParam(required = false) String keyword) {
        List<WeatherVO> weathers = cityWeatherService.searchByKeyword(keyword).stream()
                .map(WeatherVO::fromEntity)
                .toList();
        return Result.success(weathers);
    }

    @GetMapping("/{id}")
    public Result<WeatherVO> detail(@PathVariable Long id) {
        CityWeather weather = cityWeatherService.findById(id);
        if (weather == null) {
            throw new BusinessException(404, "天气数据不存在");
        }
        return Result.success(WeatherVO.fromEntity(weather));
    }

    @OperationLog("保存天气")
    @PostMapping("/save")
    public Result<WeatherVO> save(@RequestBody WeatherSaveDTO dto) {
        CityWeather weather = cityWeatherService.saveFromDTO(dto);
        return Result.success(WeatherVO.fromEntity(weather));
    }

    @OperationLog("删除天气")
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        cityWeatherService.delete(id);
        return Result.success();
    }
}
