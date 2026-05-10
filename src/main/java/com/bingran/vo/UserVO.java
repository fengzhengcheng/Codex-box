package com.bingran.vo;

import com.bingran.entity.SysUser;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UserVO {
    private Long id;
    private String username;
    private String phone;
    private String role;
    private String avatar;
    private String status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static UserVO fromEntity(SysUser user) {
        if (user == null) {
            return null;
        }
        UserVO vo = new UserVO();
        vo.setId(user.getId());
        vo.setUsername(user.getUsername());
        vo.setPhone(user.getPhone());
        vo.setRole(user.getRole());
        vo.setAvatar(user.getAvatar());
        vo.setStatus(user.getStatus());
        vo.setCreateTime(user.getCreateTime());
        vo.setUpdateTime(user.getUpdateTime());
        return vo;
    }
}
