package com.bingran.controller;

import com.bingran.entity.*;
import com.bingran.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class DbTestController {

    @Autowired
    private SysUserService sysUserService;

    @Autowired
    private CityWeatherService cityWeatherService;

    @Autowired
    private UserOperationLogService userOperationLogService;

    @Autowired
    private UserFavoriteService userFavoriteService;

    @Autowired
    private WeatherAlertService weatherAlertService;

    @Autowired
    private SysRoleService sysRoleService;

    @Autowired
    private SysPermissionService sysPermissionService;

    @Autowired
    private SysRolePermissionService sysRolePermissionService;

    @GetMapping("/db-test")
    public ModelAndView dbTest() {
        ModelAndView modelAndView = new ModelAndView("db-test");
        String dbVersion = "未知";
        String status = "连接失败";
        String message = "";

        try {
            dbVersion = sysUserService.findAll().isEmpty() ? "未知" : "MySQL 8.0+";
            status = "连接成功";
            message = "数据库连接正常，已加载所有业务数据";
        } catch (Exception e) {
            status = "连接失败";
            message = "数据库连接异常：" + e.getMessage();
        }

        List<SysUser> users = sysUserService.findAll();
        List<CityWeather> weathers = cityWeatherService.findAll();
        List<UserOperationLog> logs = userOperationLogService.findAll();
        List<UserFavorite> favorites = userFavoriteService.findAll();
        List<WeatherAlert> alerts = weatherAlertService.findAll();
        List<SysRole> roles = sysRoleService.findAll();
        List<SysPermission> permissions = sysPermissionService.findAll();
        List<SysRolePermission> rolePermissions = sysRolePermissionService.findAll();

        modelAndView.addObject("dbVersion", dbVersion);
        modelAndView.addObject("status", status);
        modelAndView.addObject("message", message);
        modelAndView.addObject("users", users);
        modelAndView.addObject("weathers", weathers);
        modelAndView.addObject("logs", logs);
        modelAndView.addObject("favorites", favorites);
        modelAndView.addObject("alerts", alerts);
        modelAndView.addObject("roles", roles);
        modelAndView.addObject("permissions", permissions);
        modelAndView.addObject("rolePermissions", rolePermissions);

        return modelAndView;
    }
}
