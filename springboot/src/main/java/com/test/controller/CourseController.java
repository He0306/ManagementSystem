package com.test.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.test.commom.Result;
import com.test.entity.Course;
import com.test.service.ICourseService;
import com.test.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author 何超
 * @since 2022-04-12
 */
@RestController
@RequestMapping("/course")
public class CourseController {

    @Autowired
    private ICourseService courseService;

    @Autowired
    private IUserService userService;

    //查询或新增
    @PostMapping
    public Result save(@RequestBody Course course) {
        courseService.saveOrUpdate(course);
        return Result.success();
    }

    //是否启用
    @PostMapping("/update")
    public Result update(@RequestBody Course course) {
        return Result.success(courseService.updateById(course));
    }

    @PostMapping("/studentCourse/{courseId}/{studentId}")
    public Result studentCourse(@PathVariable Integer courseId, @PathVariable Integer studentId) {
        courseService.setStudentCourse(courseId, studentId);
        return Result.success();
    }

    //根据ID删除
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        courseService.removeById(id);
        return Result.success();
    }

    @PostMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        courseService.removeByIds(ids);
        return Result.success();
    }

    //查询全部
    @GetMapping
    public Result findAll() {
        return Result.success(courseService.list());
    }

    //根据ID查询
    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(courseService.getById(id));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String name) {
//        Page<Course> page = new Page<>(pageNum, pageSize);
//        QueryWrapper<Course> queryWrapper = new QueryWrapper<>();
//        queryWrapper.like("name", name);
//        List<Course> records = page.getRecords();
//        for (Course record : records) {
//           User user = userService.getById(record.getTeacherId());
//           if(user != null) {
//               record.setTeacher(user.getNickname());
//           }
//       }
        Page<Course> coursePage = courseService.findPage(new Page<>(pageNum, pageSize), name);
        return Result.success(coursePage);
    }
}

