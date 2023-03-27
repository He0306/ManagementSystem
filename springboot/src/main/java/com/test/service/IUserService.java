package com.test.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.test.dto.UserDTO;
import com.test.dto.UserPasswordDTO;
import com.test.entity.User;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author 何超
 * @since 2022-03-24
 */
public interface IUserService extends IService<User> {

    UserDTO login(UserDTO userDTO);

    User register(UserDTO userDTO);

    void updatePassword(UserPasswordDTO userPasswordDTO);

    Page<User> findPage(Page<User> page, String username, String email, String address);

    Object logout(String token);
}
