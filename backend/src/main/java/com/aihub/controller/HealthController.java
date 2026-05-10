package com.aihub.controller;

import com.aihub.common.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class HealthController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/health")
    public Result<Map<String, Object>> health() {
        Map<String, Object> info = new HashMap<>();
        info.put("status", "OK");
        info.put("service", "AIHub Pro Backend");
        try {
            List<Map<String, Object>> tables = jdbcTemplate.queryForList(
                "SELECT COUNT(*) as cnt FROM information_schema.tables WHERE table_schema = DATABASE()");
            info.put("database", "connected");
            info.put("tableCount", tables.get(0).get("cnt"));
        } catch (Exception e) {
            info.put("database", "error: " + e.getMessage());
        }
        return Result.success(info);
    }
}
