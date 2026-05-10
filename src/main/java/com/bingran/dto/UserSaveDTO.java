package com.bingran.dto;

import lombok.Data;

@Data
public class UserSaveDTO {
    private Long id;
    private String username;
    private String password;
    private String phone;
    private String role;
    private String status;
}
