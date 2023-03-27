package com.test.config;

/**
 * @author: 何超
 * @date: 2022/12/12
 */

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;


@Data
@Component
@ConfigurationProperties(prefix = "alipay")
public class AliPayConfig {

    private String appId;

    private String appPrivateKey;

    private String alipayPublicKey;

    private String notifyUrl;


}
