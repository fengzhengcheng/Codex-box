package com.aihub.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("ai_tool")
public class AiTool {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String name;

    private String description;

    private String logo;

    private String url;

    private Long categoryId;

    private Integer status;

    private Long views;

    private Integer isRecommend;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
}
