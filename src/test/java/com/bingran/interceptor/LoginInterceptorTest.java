package com.bingran.interceptor;

import com.bingran.entity.SysUser;
import jakarta.servlet.http.HttpSession;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import static org.assertj.core.api.Assertions.assertThat;

class LoginInterceptorTest {

    @Test
    void redirectsPageRequestToLoginWhenUserIsMissing() throws Exception {
        LoginInterceptor interceptor = new LoginInterceptor();
        MockHttpServletRequest request = new MockHttpServletRequest("GET", "/user/index");
        MockHttpServletResponse response = new MockHttpServletResponse();

        boolean allowed = interceptor.preHandle(request, response, new Object());

        assertThat(allowed).isFalse();
        assertThat(response.getRedirectedUrl()).isEqualTo("/login");
    }

    @Test
    void returnsJsonUnauthorizedForApiRequestWhenUserIsMissing() throws Exception {
        LoginInterceptor interceptor = new LoginInterceptor();
        MockHttpServletRequest request = new MockHttpServletRequest("GET", "/api/user/list");
        MockHttpServletResponse response = new MockHttpServletResponse();

        boolean allowed = interceptor.preHandle(request, response, new Object());

        assertThat(allowed).isFalse();
        assertThat(response.getStatus()).isEqualTo(401);
        assertThat(response.getContentAsString()).contains("\"code\":401");
        assertThat(response.getContentAsString()).contains("请先登录");
    }

    @Test
    void blocksNormalUserFromAdminPage() throws Exception {
        LoginInterceptor interceptor = new LoginInterceptor();
        MockHttpServletRequest request = new MockHttpServletRequest("GET", "/admin/index");
        MockHttpServletResponse response = new MockHttpServletResponse();
        HttpSession session = request.getSession();
        SysUser user = new SysUser();
        user.setRole("user");
        session.setAttribute("user", user);

        boolean allowed = interceptor.preHandle(request, response, new Object());

        assertThat(allowed).isFalse();
        assertThat(response.getRedirectedUrl()).isEqualTo("/user/index");
    }
}
