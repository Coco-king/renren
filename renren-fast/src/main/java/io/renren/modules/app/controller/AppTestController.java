/*
 * Copyright (c) 2016-2019 人人开源 All rights reserved.
 *
 * https://www.renren.io
 *
 * 版权所有，侵权必究！
 */
package io.renren.modules.app.controller;

import io.renren.common.utils.R;
import io.renren.modules.app.annotation.Login;
import io.renren.modules.app.annotation.LoginUser;
import io.renren.modules.app.entity.UserEntity;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * APP测试接口
 *
 * @author Mark sunlightcs@gmail.com
 */
@RestController
@RequestMapping("/app")
@Api("APP测试接口")
public class AppTestController {

    @Login
    @ApiOperation("获取用户信息")
    @GetMapping("/userInfo")
    public R userInfo(@LoginUser UserEntity user) {
        return R.ok().push("user", user);
    }

    @Login
    @ApiOperation("获取用户ID")
    @GetMapping("/userId")
    public R userInfo(@RequestAttribute("userId") Integer userId) {
        return R.ok().push("userId", userId);
    }

    @ApiOperation("忽略Token验证测试")
    @GetMapping("/notToken")
    public R notToken() {
        return R.ok().push("msg", "无需token也能访问。。。");
    }

}
