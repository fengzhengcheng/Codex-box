package com.bingran.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class UserOperationLog {
    private Long id;
    private Long userId;
    private String operationContent;
    private String operationIp;
    private LocalDateTime operationTime;
}
