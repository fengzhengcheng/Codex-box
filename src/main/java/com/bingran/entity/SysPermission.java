package com.bingran.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class SysPermission {
    private Long id;
    private String permissionCode;
    private String permissionName;
    private String permissionPath;
    private String permissionType;
    private Long parentId;
    private LocalDateTime createTime;
}
