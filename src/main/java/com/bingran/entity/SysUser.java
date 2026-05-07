package com.bingran.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class SysUser {
    private Long id;
    private String username;
    private String password;
    private String phone;
    private String role;
    private String avatar;
    private String status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
