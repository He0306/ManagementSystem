package com.test.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * <p>
 *
 * </p>
 *
 * @author 何超
 * @since 2022-12-12
 */
@Getter
@Setter
@ApiModel(value = "Orders对象", description = "")
public class Orders implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private Integer userId;

    @ApiModelProperty("订单编号")
    private String no;

    @ApiModelProperty("名称")
    private String name;

    @ApiModelProperty("订单时间")
    private String time;

    @ApiModelProperty("支付状态")
    private String state;

    @ApiModelProperty("订单总价")
    private BigDecimal total;

    @ApiModelProperty("订单支付时间")
    private String paymentTime;

    @ApiModelProperty("订单流水号")
    private String alipayNo;

    @ApiModelProperty("退款时间")
    private String returnTime;


}
