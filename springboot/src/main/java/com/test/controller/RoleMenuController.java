package com.test.controller;

import com.test.commom.Result;
import com.test.service.IRoleMenuService;
import com.test.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/roleMenu")
public class RoleMenuController {

    @Autowired
    IRoleMenuService roleMenuService;

    @Autowired
    IRoleService roleService;


    //绑定角色和菜单的关系
    @PostMapping("/{roleId}")
    public Result roleMenu(@PathVariable Integer roleId, @RequestBody List<Integer> menuIds) {
        roleService.setRoleMenu(roleId, menuIds);
        return Result.success();
    }

    @GetMapping("/{roleId}")
    public Result getRoleMenu(@PathVariable Integer roleId) {
        return Result.success(roleService.getRoleMenu(roleId));
    }
}
