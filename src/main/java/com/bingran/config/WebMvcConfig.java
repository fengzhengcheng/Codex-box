package com.bingran.config;

import com.bingran.interceptor.LoginInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Autowired
    private LoginInterceptor loginInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns("/user/**", "/admin/**", "/api/user/**", "/api/weather/**")
                .excludePathPatterns(
                        "/login",
                        "/register",
                        "/forget",
                        "/api/auth/**",
                        "/css/**",
                        "/js/**",
                        "/images/**",
                        "/static/**",
                        "/favicon.ico"
                );
    }
}
