package com.bingran.controller;

import com.bingran.annotation.OperationLog;
import com.bingran.entity.SysUser;
import com.bingran.service.SysUserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class LoginController {

    @Autowired
    private SysUserService sysUserService;

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @OperationLog("登录系统")
    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password,
                       HttpSession session, RedirectAttributes redirectAttributes) {
        SysUser user = sysUserService.findByUsername(username);
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "用户不存在");
            return "redirect:/login";
        }
        if (!password.equals(user.getPassword())) {
            redirectAttributes.addFlashAttribute("error", "密码错误");
            return "redirect:/login";
        }
        if ("禁用".equals(user.getStatus())) {
            redirectAttributes.addFlashAttribute("error", "用户已被禁用");
            return "redirect:/login";
        }
        session.setAttribute("user", user);

        if ("admin".equals(user.getRole())) {
            return "redirect:/admin/index";
        } else {
            return "redirect:/user/index";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @OperationLog("用户注册")
    @PostMapping("/register")
    public String register(SysUser sysUser, RedirectAttributes redirectAttributes) {
        SysUser existUser = sysUserService.findByUsername(sysUser.getUsername());
        if (existUser != null) {
            redirectAttributes.addFlashAttribute("error", "用户名已存在");
            return "redirect:/register";
        }
        sysUser.setRole("user");
        sysUser.setAvatar("/static/images/default-avatar.png");
        sysUser.setStatus("正常");
        sysUserService.save(sysUser);

        redirectAttributes.addFlashAttribute("msg", "注册成功，请登录");
        return "redirect:/login";
    }

    @GetMapping("/forget")
    public String forgetPage() {
        return "forget";
    }

    @PostMapping("/forget")
    public String forget(@RequestParam String phone, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("msg", "请联系管理员重置密码");
        return "redirect:/login";
    }
}
