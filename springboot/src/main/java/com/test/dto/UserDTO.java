package com.test.dto;

import com.test.entity.Menu;
import lombok.Data;

import java.util.List;

@Data
public class UserDTO {

    private Integer id;
    private String username;
    private String password;
    private String nickname;
    private String avatar;
    private String token;
    private String role;
    private List<Menu> menus;

}
