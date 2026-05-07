package com.bingran.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class SysRole {
    private Long id;
    private String roleCode;
    private String roleName;
    private String roleDesc;
    private LocalDateTime createTime;
}
