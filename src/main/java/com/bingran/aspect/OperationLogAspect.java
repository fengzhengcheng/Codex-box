package com.bingran.aspect;

import com.bingran.annotation.OperationLog;
import com.bingran.entity.SysUser;
import com.bingran.entity.UserOperationLog;
import com.bingran.service.UserOperationLogService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Aspect
@Component
public class OperationLogAspect {
    private static final Logger log = LoggerFactory.getLogger(OperationLogAspect.class);

    @Autowired
    private UserOperationLogService userOperationLogService;

    @AfterReturning("@annotation(operationLog)")
    public void recordOperationLog(JoinPoint joinPoint, OperationLog operationLog) {
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        if (attributes == null) {
            return;
        }

        HttpServletRequest request = attributes.getRequest();
        Long userId = findUserId(request, joinPoint.getArgs());
        if (userId == null) {
            return;
        }

        try {
            UserOperationLog operation = new UserOperationLog();
            operation.setUserId(userId);
            operation.setOperationContent(operationLog.value());
            operation.setOperationIp(getClientIp(request));
            userOperationLogService.save(operation);
        } catch (Exception exception) {
            log.warn("记录操作日志失败：{}", exception.getMessage());
        }
    }

    private Long findUserId(HttpServletRequest request, Object[] args) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object sessionUser = session.getAttribute("user");
            if (sessionUser instanceof SysUser) {
                SysUser user = (SysUser) sessionUser;
                if (user.getId() != null) {
                    return user.getId();
                }
            }
        }

        for (Object arg : args) {
            if (arg instanceof SysUser) {
                SysUser user = (SysUser) arg;
                if (user.getId() != null) {
                    return user.getId();
                }
            }
        }
        return null;
    }

    private String getClientIp(HttpServletRequest request) {
        String forwardedFor = request.getHeader("X-Forwarded-For");
        if (forwardedFor != null && !forwardedFor.isBlank()) {
            return forwardedFor.split(",")[0].trim();
        }
        return request.getRemoteAddr();
    }
}
