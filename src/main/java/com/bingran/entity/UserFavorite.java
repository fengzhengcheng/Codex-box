package com.bingran.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class UserFavorite {
    private Long id;
    private Long userId;
    private String favoriteCities;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
