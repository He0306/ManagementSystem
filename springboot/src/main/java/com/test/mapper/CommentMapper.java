package com.test.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.test.entity.Comment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author 何超
 * @since 2022-10-03
 */
@Mapper
public interface CommentMapper extends BaseMapper<Comment> {

    List<Comment> findCommentDetail(@Param("articleId") Integer articleId);
}
