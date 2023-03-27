package com.test.exception;

import lombok.Getter;

//自定义异常
@Getter
public class ServiceException extends RuntimeException {
    private final String code;

    public ServiceException(String code, String msg) {
        super(msg);
        this.code = code;
    }
}
