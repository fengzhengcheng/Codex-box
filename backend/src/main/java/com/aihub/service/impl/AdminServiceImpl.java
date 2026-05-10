package com.aihub.service.impl;

import com.aihub.dto.LoginDTO;
import com.aihub.entity.Admin;
import com.aihub.entity.AiTool;
import com.aihub.entity.Article;
import com.aihub.entity.Prompt;
import com.aihub.entity.User;
import com.aihub.mapper.AdminMapper;
import com.aihub.mapper.AiToolMapper;
import com.aihub.mapper.ArticleMapper;
import com.aihub.mapper.PromptMapper;
import com.aihub.mapper.UserMapper;
import com.aihub.service.AdminService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private AiToolMapper aiToolMapper;

    @Autowired
    private PromptMapper promptMapper;

    @Autowired
    private ArticleMapper articleMapper;

    @Override
    public String login(LoginDTO loginDTO) {
        LambdaQueryWrapper<Admin> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Admin::getUsername, loginDTO.getUsername())
               .eq(Admin::getPassword, loginDTO.getPassword());
        Admin admin = adminMapper.selectOne(wrapper);
        if (admin == null) {
            throw new RuntimeException("管理员用户名或密码错误");
        }
        return UUID.randomUUID().toString().replace("-", "");
    }

    @Override
    public Map<String, Long> getStatistics() {
        Map<String, Long> statistics = new HashMap<>();
        statistics.put("userCount", userMapper.selectCount(null));
        statistics.put("toolCount", aiToolMapper.selectCount(null));
        statistics.put("promptCount", promptMapper.selectCount(null));
        statistics.put("articleCount", articleMapper.selectCount(null));
        return statistics;
    }
}
