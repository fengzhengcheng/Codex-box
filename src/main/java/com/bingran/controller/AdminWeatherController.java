package com.bingran.controller;

import com.bingran.annotation.OperationLog;
import com.bingran.entity.CityWeather;
import com.bingran.service.CityWeatherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/weather")
public class AdminWeatherController {

    @Autowired
    private CityWeatherService cityWeatherService;

    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("weathers", cityWeatherService.findAll());
        return "admin/weather/list";
    }

    @GetMapping("/add")
    public String add(Model model) {
        model.addAttribute("weather", new CityWeather());
        model.addAttribute("action", "add");
        return "admin/weather/edit";
    }

    @OperationLog("新增天气")
    @PostMapping("/add")
    public String add(CityWeather cityWeather, RedirectAttributes redirectAttributes) {
        cityWeatherService.save(cityWeather);
        redirectAttributes.addFlashAttribute("msg", "天气数据添加成功");
        return "redirect:/admin/weather/list";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Long id, Model model) {
        model.addAttribute("weather", cityWeatherService.findById(id));
        model.addAttribute("action", "edit");
        return "admin/weather/edit";
    }

    @OperationLog("修改天气")
    @PostMapping("/edit")
    public String edit(CityWeather cityWeather, RedirectAttributes redirectAttributes) {
        cityWeatherService.save(cityWeather);
        redirectAttributes.addFlashAttribute("msg", "天气数据更新成功");
        return "redirect:/admin/weather/list";
    }

    @OperationLog("删除天气")
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        cityWeatherService.delete(id);
        redirectAttributes.addFlashAttribute("msg", "天气数据删除成功");
        return "redirect:/admin/weather/list";
    }
}
