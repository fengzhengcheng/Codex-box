package com.bingran.controller;

import com.bingran.annotation.OperationLog;
import com.bingran.entity.SysUser;
import com.bingran.service.UserOperationLogService;
import com.bingran.service.UserFavoriteService;
import com.bingran.entity.UserOperationLog;
import com.bingran.entity.UserFavorite;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserOperationLogService userOperationLogService;

    @Autowired
    private UserFavoriteService userFavoriteService;

    @GetMapping("/index")
    public String index(HttpSession session, Model model) {
        SysUser user = (SysUser) session.getAttribute("user");
        model.addAttribute("user", user);
        return "user/index";
    }

    @GetMapping("/weather")
    public String weather(HttpSession session, Model model) {
        SysUser user = (SysUser) session.getAttribute("user");
        model.addAttribute("user", user);
        return "user/weather";
    }

    @GetMapping("/favorite")
    public String favorite(HttpSession session, Model model) {
        SysUser user = (SysUser) session.getAttribute("user");
        UserFavorite favorite = userFavoriteService.findByUserId(user.getId());
        model.addAttribute("user", user);
        model.addAttribute("favorite", favorite);
        return "user/favorite";
    }

    @OperationLog("更新收藏城市")
    @PostMapping("/favorite")
    public String favorite(HttpSession session, @RequestParam String favoriteCities, RedirectAttributes redirectAttributes) {
        SysUser user = (SysUser) session.getAttribute("user");
        UserFavorite favorite = userFavoriteService.findByUserId(user.getId());
        if (favorite == null) {
            favorite = new UserFavorite();
            favorite.setUserId(user.getId());
        }
        favorite.setFavoriteCities(favoriteCities);
        userFavoriteService.save(favorite);
        redirectAttributes.addFlashAttribute("msg", "收藏更新成功");
        return "redirect:/user/favorite";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        SysUser user = (SysUser) session.getAttribute("user");
        model.addAttribute("user", user);
        return "user/profile";
    }

    @OperationLog("修改个人信息")
    @PostMapping("/profile")
    public String profile(HttpSession session, SysUser updatedUser, RedirectAttributes redirectAttributes) {
        SysUser user = (SysUser) session.getAttribute("user");
        user.setPhone(updatedUser.getPhone());
        redirectAttributes.addFlashAttribute("msg", "个人信息更新成功");
        return "redirect:/user/index";
    }

    @GetMapping("/log")
    public String log(HttpSession session, Model model) {
        SysUser user = (SysUser) session.getAttribute("user");
        List<UserOperationLog> logs = userOperationLogService.findByUserId(user.getId());
        model.addAttribute("user", user);
        model.addAttribute("logs", logs);
        return "user/log";
    }
}
