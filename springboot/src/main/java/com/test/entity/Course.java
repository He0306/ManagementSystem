package com.test.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * <p>
 *
 * </p>
 *
 * @author 何超
 * @since 2022-04-12
 */
@Getter
@Setter
@ApiModel(value = "Course对象", description = "")
public class Course implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("ID")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("课程名称")
    private String name;

    @ApiModelProperty("学分")
    private Integer score;

    @ApiModelProperty("上课时间")
    private String times;

    @ApiModelProperty("是否开课")
    private Boolean state;

    @ApiModelProperty("授课老师ID")
    private Integer teacherId;

    @TableField(exist = false)
    private String teacher;


}
