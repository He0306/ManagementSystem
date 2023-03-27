package com.test.controller;

import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.test.commom.Result;
import com.test.entity.Comment;
import com.test.service.ICommentService;
import com.test.util.TokenUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;


/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author 何超
 * @since 2022-10-03
 */
@RestController
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private ICommentService commentService;

    //查询或新增
    @PostMapping
    public Result save(@RequestBody Comment comment) {
        if (comment.getId() == null) {
            comment.setTime(DateUtil.now());
            comment.setUserId(TokenUtils.getCurrentUser().getId());
            if (comment.getPid() != null) {
                Integer pid = comment.getPid();
                Comment pComment = commentService.getById(pid);
                if (pComment.getOriginId() != null) {
                    comment.setOriginId(pComment.getOriginId());
                } else {
                    comment.setOriginId(comment.getPid());
                }
            }
        }
        commentService.saveOrUpdate(comment);
        return Result.success();
    }

    //根据ID删除
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        commentService.removeById(id);
        return Result.success();
    }

    @PostMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        commentService.removeByIds(ids);
        return Result.success();
    }

    //查询全部
    @GetMapping
    public Result findAll() {

        return Result.success(commentService.list());
    }

    //查询全部评论
    @GetMapping("/tree/{articleId}")
    public Result findTree(@PathVariable("articleId") Integer articleId) {
        //查询全部评论
        List<Comment> commentList = commentService.findCommentDetail(articleId);
        //过滤最上级ID未0的评论
        List<Comment> originList = commentList.stream().filter(comment -> comment.getOriginId() == null).collect(Collectors.toList());

        for (Comment origin : originList) {
            //获取评论ID和最上级ID相同的评论
            List<Comment> comments = commentList.stream().filter(comment -> origin.getId().equals(comment.getOriginId())).collect(Collectors.toList());
            //找到父级评论的用户ID和用户昵称，并设置给当前的回复对象
            comments.forEach(comment -> {
                Optional<Comment> pComment = commentList.stream().filter(c1 -> c1.getId().equals(comment.getPid())).findFirst();  // 找到当前评论的父级
                pComment.ifPresent((v -> {  // 找到父级评论的用户id和用户昵称，并设置给当前的回复对象
                    comment.setPUserId(v.getUserId());
                    comment.setPnickName(v.getNickname());
                }));
            });
            origin.setChildren(comments);
        }
        return Result.success(originList);
    }

    //根据ID查询
    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(commentService.getById(id));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize) {
        return Result.success(commentService.page(new Page<>(pageNum, pageSize)));
    }
}

