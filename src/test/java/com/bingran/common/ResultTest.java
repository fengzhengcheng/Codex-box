package com.bingran.common;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class ResultTest {

    @Test
    void successWrapsDataWithUnifiedShape() {
        Result<String> result = Result.success("ok");

        assertThat(result.getCode()).isEqualTo(200);
        assertThat(result.getMessage()).isEqualTo("success");
        assertThat(result.getData()).isEqualTo("ok");
    }

    @Test
    void failWrapsMessageWithNullData() {
        Result<Object> result = Result.fail(400, "参数错误");

        assertThat(result.getCode()).isEqualTo(400);
        assertThat(result.getMessage()).isEqualTo("参数错误");
        assertThat(result.getData()).isNull();
    }
}
