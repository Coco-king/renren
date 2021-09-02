/*
 * Copyright (c) 2016-2019 人人开源 All rights reserved.
 *
 * https://www.renren.io
 *
 * 版权所有，侵权必究！
 */
package io.renren.common.utils;

import io.renren.common.exception.RRException;
import lombok.NonNull;
import org.apache.http.HttpStatus;

import java.util.HashMap;
import java.util.Map;

/**
 * 返回数据
 *
 * @author Mark sunlightcs@gmail.com
 */
public class R extends HashMap<String, Object> {

    private static final long serialVersionUID = 1L;

    public R() {
        push("code", 0);
        push("msg", "success");
    }

    public static R error() {
        return error(HttpStatus.SC_INTERNAL_SERVER_ERROR, "未知异常，请联系管理员");
    }

    public static R error(String msg) {
        return error(HttpStatus.SC_INTERNAL_SERVER_ERROR, msg);
    }

    public static R error(int code, String msg) {
        R r = new R();
        r.push("code", code);
        r.push("msg", msg);
        return r;
    }

    public static R ok(String msg) {
        R r = new R();
        r.push("msg", msg);
        return r;
    }

    public static R ok(Map<String, Object> map) {
        R r = new R();
        r.putAll(map);
        return r;
    }

    public static R ok() {
        return new R();
    }

    public R push(String key, Object value) {
        super.put(key, value);
        return this;
    }

    public int getCode() {
        Object code = this.get("code");
        if (code == null) {
            throw new RRException("获取返回状态码失败，状态码为空");
        }
        if (!code.getClass().equals(Integer.class)) {
            throw new RRException("获取返回状态码失败，状态码不是一个数字");
        }
        return (int) code;
    }

    public <T> T getData(@NonNull Class<T> clazz) {
        Object data = this.get("data");
        if (data == null) {
            return null;
        }
        if (!clazz.equals(data.getClass())) {
            throw new RRException("获取数据失败，实际的类型：" + data.getClass() + "，期望的类型：" + clazz);
        }
        return clazz.cast(data);
    }
}
