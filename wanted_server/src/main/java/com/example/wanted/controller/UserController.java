package com.example.wanted.controller;

import com.example.wanted.model.User;
import com.example.wanted.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
public class UserController {

    final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    //@PostMapping("/user")
    @RequestMapping(value = "/user", method = RequestMethod.POST, consumes = "application/json", produces = "application/json;charset=UTF-8")
    public String saveUser(@RequestBody User user) {
        //List<User> users = userService.findAll();
        //System.out.println(users);
        //檢查用戶名是否被使用
        if (userService.checkNameUsed(user.getName())) {
            return "该用戶名已被使用";
        } else {
            userService.save(user);
            //System.out.println(user);
            return "注冊成功";
        }


    }

    @RequestMapping(value = "/vertification", method = RequestMethod.POST, consumes = "application/json", produces = "application/json;charset=UTF-8")
    public int checkUser(@RequestBody User user) {
        //System.out.println(user);
        //檢查用戶密碼是否正确
        if (userService.checkNameUsed(user.getName())) {
            int res = userService.checkPasswordUsed(user);
            return res;//"密码不正确，请重试";

        } else {
            return -2;//"此用户名尚未注册";
        }

    }

    @RequestMapping(value = "/getUserName", method = RequestMethod.POST)
    public String getUser(@RequestParam("userId")String userId){
        return userService.getUserName(Integer.parseInt(userId));
    }

    @RequestMapping(value = "/deleteUser", method = RequestMethod.POST)
    public String deleteUser(@RequestParam("userId")String userId){
        return userService.deleteUser(Integer.parseInt(userId));
    }

}
