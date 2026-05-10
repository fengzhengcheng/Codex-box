package com.bingran.controller;

import com.bingran.annotation.OperationLog;
import com.bingran.entity.SysUser;
import com.bingran.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/user")
public class AdminUserController {

    @Autowired
    private SysUserService sysUserService;

    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("users", sysUserService.findAll());
        return "admin/user/list";
    }

    @GetMapping("/add")
    public String add(Model model) {
        model.addAttribute("user", new SysUser());
        model.addAttribute("action", "add");
        return "admin/user/edit";
    }

    @OperationLog("新增用户")
    @PostMapping("/add")
    public String add(SysUser sysUser, RedirectAttributes redirectAttributes) {
        sysUser.setAvatar("/static/images/default-avatar.png");
        sysUser.setStatus("正常");
        sysUserService.save(sysUser);
        redirectAttributes.addFlashAttribute("msg", "用户添加成功");
        return "redirect:/admin/user/list";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Long id, Model model) {
        model.addAttribute("user", sysUserService.findById(id));
        model.addAttribute("action", "edit");
        return "admin/user/edit";
    }

    @OperationLog("修改用户")
    @PostMapping("/edit")
    public String edit(SysUser sysUser, RedirectAttributes redirectAttributes) {
        sysUserService.save(sysUser);
        redirectAttributes.addFlashAttribute("msg", "用户更新成功");
        return "redirect:/admin/user/list";
    }

    @OperationLog("删除用户")
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        sysUserService.delete(id);
        redirectAttributes.addFlashAttribute("msg", "用户删除成功");
        return "redirect:/admin/user/list";
    }

    @OperationLog("禁用用户")
    @GetMapping("/disable/{id}")
    public String disable(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        SysUser user = sysUserService.findById(id);
        if (user != null) {
            user.setStatus("禁用");
            sysUserService.save(user);
            redirectAttributes.addFlashAttribute("msg", "用户已禁用");
        }
        return "redirect:/admin/user/list";
    }

    @OperationLog("启用用户")
    @GetMapping("/enable/{id}")
    public String enable(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        SysUser user = sysUserService.findById(id);
        if (user != null) {
            user.setStatus("正常");
            sysUserService.save(user);
            redirectAttributes.addFlashAttribute("msg", "用户已启用");
        }
        return "redirect:/admin/user/list";
    }
}
