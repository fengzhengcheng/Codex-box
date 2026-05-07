package com.bingran.controller;

import com.bingran.entity.SysUser;
import com.bingran.service.SysUserService;
import com.bingran.service.UserOperationLogService;
import com.bingran.service.WeatherAlertService;
import com.bingran.service.SysRoleService;
import com.bingran.service.SysPermissionService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminIndexController {

    @Autowired
    private SysUserService sysUserService;

    @Autowired
    private UserOperationLogService userOperationLogService;

    @Autowired
    private WeatherAlertService weatherAlertService;

    @Autowired
    private SysRoleService sysRoleService;

    @Autowired
    private SysPermissionService sysPermissionService;

    @GetMapping("/index")
    public String index(HttpSession session, Model model) {
        SysUser user = (SysUser) session.getAttribute("user");
        model.addAttribute("user", user);
        model.addAttribute("userCount", sysUserService.findAll().size());
        model.addAttribute("logCount", userOperationLogService.findAll().size());
        model.addAttribute("alertCount", weatherAlertService.findAll().size());
        model.addAttribute("roleCount", sysRoleService.findAll().size());
        return "admin/index";
    }
}
