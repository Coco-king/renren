/*
 * Copyright (c) 2016-2019 人人开源 All rights reserved.
 *
 * https://www.renren.io
 *
 * 版权所有，侵权必究！
 */
package io.renren.common.exception;

import com.sun.javaws.exceptions.InvalidArgumentException;
import io.renren.common.utils.R;
import org.apache.shiro.authz.AuthorizationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.ConversionNotSupportedException;
import org.springframework.beans.TypeMismatchException;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.validation.BindException;
import org.springframework.web.HttpMediaTypeNotAcceptableException;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingPathVariableException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.async.AsyncRequestTimeoutException;
import org.springframework.web.multipart.support.MissingServletRequestPartException;
import org.springframework.web.servlet.NoHandlerFoundException;

import javax.servlet.http.HttpServletRequest;

/**
 * 异常处理器
 *
 * @author Mark sunlightcs@gmail.com
 */
@RestControllerAdvice
public class RRExceptionHandler {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    /**
     * 处理自定义异常
     */
    @ExceptionHandler(RRException.class)
    public R handleRRException(RRException e, HttpServletRequest request) {
        logger.error("{} {}, 发生业务异常, 原因:{}", request.getMethod(), request.getRequestURI(), e.getMessage());
        return R.error(e.getCode(), e.getMessage());
    }

    @ExceptionHandler(NoHandlerFoundException.class)
    public R handlerNoFoundException(NoHandlerFoundException e, HttpServletRequest request) {
        logger.error("{} {}, 发生路径不存在异常, 原因:{}", request.getMethod(), request.getRequestURI(), e.getMessage());
        return R.error(4040, "路径不存在，请检查路径是否正确");
    }

    @ExceptionHandler(DuplicateKeyException.class)
    public R handleDuplicateKeyException(DuplicateKeyException e, HttpServletRequest request) {
        logger.error("{} {}, 发生数据库重复记录异常, 原因:{}", request.getMethod(), request.getRequestURI(), e.getMessage());
        return R.error(5000, "数据库中已存在该记录");
    }

    @ExceptionHandler(AuthorizationException.class)
    public R handleAuthorizationException(AuthorizationException e, HttpServletRequest request) {
        logger.error("{} {}, 发生权限异常, 原因:{}", request.getMethod(), request.getRequestURI(), e.getMessage());
        return R.error(4010, "没有权限，请联系管理员授权");
    }

    /**
     * 参数异常处理
     */
    @ExceptionHandler(InvalidArgumentException.class)
    public R invalidArgumentException(InvalidArgumentException e, HttpServletRequest request) {
        logger.error("{} {}, 发生参数异常, 原因:{}", request.getMethod(), request.getRequestURI(), e.getMessage());
        return R.error(5000, e.getMessage());
    }


    /**
     * 数据库异常
     */
    @ExceptionHandler(DataAccessException.class)
    public R dataAccessException(DataAccessException e, HttpServletRequest request) {
        logger.error("{} {}, 发生数据库异常, 原因:{}", request.getMethod(), request.getRequestURI(), e.getMessage());
        return R.error(5000, e.getMessage());
    }

    /**
     * 空指针异常
     */
    @ExceptionHandler(NullPointerException.class)
    public R nullPointerException(NullPointerException e, HttpServletRequest request) {
        logger.error("{} {}, 发生空指针异常, 原因:{}", request.getMethod(), request.getRequestURI(), e.getMessage());
        return R.error(5000, e.getMessage());
    }

    /**
     * 其它异常
     */
    @ExceptionHandler(Exception.class)
    public R handleException(Exception e, HttpServletRequest request) {
        // 其他内部spring mvc异常
        R r = mvcExceptionResolve(e);
        if (r != null) {
            if (HttpStatus.Series.valueOf(r.getCode()) == HttpStatus.Series.CLIENT_ERROR) {
                logger.warn("{} {}, 发生异常, 原因:{}", request.getMethod(), request.getRequestURI(), e.getMessage());
            } else {
                logger.error("{} {}, 发生异常, 原因:{}", request.getMethod(), request.getRequestURI(), e.getMessage());
            }
            return r;
        }

        logger.error("{} {}, 发生异常, 原因:{}", request.getMethod(), request.getRequestURI(), e.getMessage());
        return R.error(9999, e.getMessage());
    }

    /**
     * MVC异常处理
     */
    protected R mvcExceptionResolve(Exception ex) {
        if (ex instanceof NoHandlerFoundException) {
            return R.error(HttpStatus.NOT_FOUND.value(), HttpStatus.NOT_FOUND.getReasonPhrase());
        } else if (ex instanceof HttpRequestMethodNotSupportedException) {
            return R.error(HttpStatus.METHOD_NOT_ALLOWED.value(), ex.getMessage());
        } else if (ex instanceof HttpMediaTypeNotSupportedException) {
            return R.error(HttpStatus.UNSUPPORTED_MEDIA_TYPE.value(), ex.getMessage());
        } else if (ex instanceof HttpMediaTypeNotAcceptableException) {
            return R.error(HttpStatus.NOT_ACCEPTABLE.value(), HttpStatus.NOT_ACCEPTABLE.getReasonPhrase());
        } else if (ex instanceof MissingPathVariableException) {
            return R.error(HttpStatus.BAD_REQUEST.value(), "Missing path variable");
        } else if (ex instanceof MissingServletRequestParameterException) {
            return R.error(HttpStatus.BAD_REQUEST.value(), HttpStatus.BAD_REQUEST.getReasonPhrase());
        } else if (ex instanceof ServletRequestBindingException) {
            return R.error(HttpStatus.BAD_REQUEST.value(), HttpStatus.BAD_REQUEST.getReasonPhrase());
        } else if (ex instanceof ConversionNotSupportedException) {
            return R.error(HttpStatus.BAD_REQUEST.value(), HttpStatus.BAD_REQUEST.getReasonPhrase());
        } else if (ex instanceof TypeMismatchException) {
            return R.error(HttpStatus.BAD_REQUEST.value(), HttpStatus.BAD_REQUEST.getReasonPhrase());
        } else if (ex instanceof HttpMessageNotReadableException) {
            return R.error(HttpStatus.BAD_REQUEST.value(), HttpStatus.BAD_REQUEST.getReasonPhrase());
        } else if (ex instanceof HttpMessageNotWritableException) {
            return R.error(HttpStatus.INTERNAL_SERVER_ERROR.value(), HttpStatus.INTERNAL_SERVER_ERROR.getReasonPhrase());
        } else if (ex instanceof MethodArgumentNotValidException) {
            return R.error(HttpStatus.BAD_REQUEST.value(), HttpStatus.BAD_REQUEST.getReasonPhrase());
        } else if (ex instanceof MissingServletRequestPartException) {
            return R.error(HttpStatus.BAD_REQUEST.value(), HttpStatus.BAD_REQUEST.getReasonPhrase());
        } else if (ex instanceof BindException) {
            return R.error(HttpStatus.BAD_REQUEST.value(), HttpStatus.BAD_REQUEST.getReasonPhrase());
        } else if (ex instanceof AsyncRequestTimeoutException) {
            return R.error(HttpStatus.SERVICE_UNAVAILABLE.value(), HttpStatus.SERVICE_UNAVAILABLE.getReasonPhrase());
        }
        return null;
    }
}
