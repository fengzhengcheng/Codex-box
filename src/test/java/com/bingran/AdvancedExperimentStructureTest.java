package com.bingran;

import com.bingran.annotation.OperationLog;
import com.bingran.controller.AdminUserController;
import com.bingran.controller.AdminWeatherController;
import com.bingran.controller.LoginController;
import com.bingran.dto.UserSaveDTO;
import com.bingran.dto.WeatherSaveDTO;
import com.bingran.entity.CityWeather;
import com.bingran.entity.SysUser;
import com.bingran.service.CityWeatherService;
import com.bingran.service.SysUserService;
import com.bingran.service.UserFavoriteService;
import com.bingran.service.UserOperationLogService;
import org.junit.jupiter.api.Test;
import org.springframework.transaction.annotation.Transactional;

import static org.assertj.core.api.Assertions.assertThat;

class AdvancedExperimentStructureTest {

    @Test
    void writeServiceMethodsUseDeclarativeTransactions() throws Exception {
        assertThat(SysUserService.class.getMethod("save", SysUser.class).isAnnotationPresent(Transactional.class)).isTrue();
        assertThat(SysUserService.class.getMethod("saveFromDTO", UserSaveDTO.class).isAnnotationPresent(Transactional.class)).isTrue();
        assertThat(SysUserService.class.getMethod("delete", Long.class).isAnnotationPresent(Transactional.class)).isTrue();
        assertThat(CityWeatherService.class.getMethod("save", CityWeather.class).isAnnotationPresent(Transactional.class)).isTrue();
        assertThat(CityWeatherService.class.getMethod("saveFromDTO", WeatherSaveDTO.class).isAnnotationPresent(Transactional.class)).isTrue();
        assertThat(CityWeatherService.class.getMethod("delete", Long.class).isAnnotationPresent(Transactional.class)).isTrue();
        assertThat(UserFavoriteService.class.getMethod("save", com.bingran.entity.UserFavorite.class).isAnnotationPresent(Transactional.class)).isTrue();
        assertThat(UserOperationLogService.class.getMethod("save", com.bingran.entity.UserOperationLog.class).isAnnotationPresent(Transactional.class)).isTrue();
    }

    @Test
    void coreControllerOperationsDeclareOperationLog() throws Exception {
        assertThat(LoginController.class.getMethod("login", String.class, String.class, jakarta.servlet.http.HttpSession.class, org.springframework.web.servlet.mvc.support.RedirectAttributes.class)
                .isAnnotationPresent(OperationLog.class)).isTrue();
        assertThat(LoginController.class.getMethod("register", SysUser.class, org.springframework.web.servlet.mvc.support.RedirectAttributes.class)
                .isAnnotationPresent(OperationLog.class)).isTrue();
        assertThat(AdminUserController.class.getMethod("add", SysUser.class, org.springframework.web.servlet.mvc.support.RedirectAttributes.class)
                .isAnnotationPresent(OperationLog.class)).isTrue();
        assertThat(AdminWeatherController.class.getMethod("add", CityWeather.class, org.springframework.web.servlet.mvc.support.RedirectAttributes.class)
                .isAnnotationPresent(OperationLog.class)).isTrue();
    }
}
