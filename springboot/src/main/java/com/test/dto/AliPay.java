package com.test.dto;

/**
 * @author: 何超
 * @date: 2022/12/12
 */

import lombok.Data;

@Data
public class AliPay {

    private String traceNo;

    private double totalAmount;

    private String subject;

    private String alipayTraceNo;
}


