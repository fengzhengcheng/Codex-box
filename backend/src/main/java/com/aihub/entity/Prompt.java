package com.aihub.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("prompt")
public class Prompt {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String title;

    private String content;

    private String tags;

    private Long categoryId;

    private Integer status;

    private Long views;

    private Integer isRecommend;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
}
