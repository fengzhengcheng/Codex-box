package com.bingran.interceptor;

import com.bingran.entity.SysUser;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.IOException;

@Component
public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        SysUser user = session == null ? null : (SysUser) session.getAttribute("user");

        if (user == null) {
            rejectUnauthenticated(request, response);
            return false;
        }

        if (isAdminPath(request) && !"admin".equals(user.getRole())) {
            rejectForbidden(request, response);
            return false;
        }

        return true;
    }

    private boolean isAdminPath(HttpServletRequest request) {
        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        if (contextPath != null && !contextPath.isEmpty() && uri.startsWith(contextPath)) {
            uri = uri.substring(contextPath.length());
        }
        if (uri.startsWith("/admin")) {
            return true;
        }
        if (uri.startsWith("/api/user")) {
            return true;
        }
        if (uri.startsWith("/api/weather")) {
            return !uri.startsWith("/api/weather/search") && !uri.startsWith("/api/weather/list");
        }
        return false;
    }

    private void rejectUnauthenticated(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (isApiRequest(request)) {
            writeJson(response, 401, "请先登录");
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    private void rejectForbidden(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (isApiRequest(request)) {
            writeJson(response, 403, "没有权限访问");
        } else {
            response.sendRedirect(request.getContextPath() + "/user/index");
        }
    }

    private boolean isApiRequest(HttpServletRequest request) {
        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        if (contextPath != null && !contextPath.isEmpty() && uri.startsWith(contextPath)) {
            uri = uri.substring(contextPath.length());
        }
        return uri.startsWith("/api/");
    }

    private void writeJson(HttpServletResponse response, int code, String message) throws IOException {
        response.setStatus(code);
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write("{\"code\":" + code + ",\"message\":\"" + message + "\",\"data\":null}");
    }
}
