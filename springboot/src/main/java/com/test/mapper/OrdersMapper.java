package com.test.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.test.entity.Orders;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author 何超
 * @since 2022-12-12
 */
@Mapper
public interface OrdersMapper extends BaseMapper<Orders> {

    void updateState(@Param("no") String tradeNo, @Param("state") String state, @Param("paymentTime") String gmtPayment, @Param("alipayNo") String alipayTradeNo);

    void updatePayState(@Param("no") String traceNo, @Param("state") String state, @Param("now") String now);

    Orders getByNo(@Param("no") String traceNo);
}
