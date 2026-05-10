package com.aihub;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.aihub.mapper")
public class AihubProApplication {

    public static void main(String[] args) {
        SpringApplication.run(AihubProApplication.class, args);
        System.out.println("========================================");
        System.out.println("  AI Hub Pro Backend 启动成功！");
        System.out.println("  访问地址: http://localhost:8080");
        System.out.println("========================================");
    }
}
