package com.bingran.exception;

import com.bingran.common.Result;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class GlobalExceptionHandlerTest {

    @Test
    void businessExceptionIsConvertedToFailedResult() {
        GlobalExceptionHandler handler = new GlobalExceptionHandler();

        Result<Object> result = handler.handleBusinessException(new BusinessException(404, "天气不存在"));

        assertThat(result.getCode()).isEqualTo(404);
        assertThat(result.getMessage()).isEqualTo("天气不存在");
        assertThat(result.getData()).isNull();
    }

    @Test
    void illegalArgumentExceptionIsConvertedToParameterError() {
        GlobalExceptionHandler handler = new GlobalExceptionHandler();

        Result<Object> result = handler.handleIllegalArgumentException(new IllegalArgumentException("用户名不能为空"));

        assertThat(result.getCode()).isEqualTo(400);
        assertThat(result.getMessage()).isEqualTo("用户名不能为空");
        assertThat(result.getData()).isNull();
    }
}
