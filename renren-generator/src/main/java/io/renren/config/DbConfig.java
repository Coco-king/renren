/*
 * Copyright (c) 2018 人人开源 All rights reserved.
 * <p>
 * https://www.renren.io
 * <p>
 * 版权所有，侵权必究！
 */
package io.renren.config;

import io.renren.mapper.*;
import io.renren.utils.RRException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Conditional;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import javax.annotation.Resource;

/**
 * 数据库配置
 *
 * @author Mark sunlightcs@gmail.com
 */
@Configuration
public class DbConfig {

    @Value("${renren.database: mysql}")
    private String database;

    @Resource
    private MySQLGeneratorMapper mySQLGeneratorDao;

    @Resource
    private OracleGeneratorMapper oracleGeneratorDao;

    @Resource
    private SQLServerGeneratorMapper sqlServerGeneratorDao;

    @Resource
    private PostgreSQLGeneratorMapper postgreSQLGeneratorDao;

    private static boolean mongo = false;

    @Bean
    @Primary
    @Conditional(MongoNullCondition.class)
    public GeneratorMapper getGeneratorDao() {
        if ("mysql".equalsIgnoreCase(database)) {
            return mySQLGeneratorDao;
        } else if ("oracle".equalsIgnoreCase(database)) {
            return oracleGeneratorDao;
        } else if ("sqlserver".equalsIgnoreCase(database)) {
            return sqlServerGeneratorDao;
        } else if ("postgresql".equalsIgnoreCase(database)) {
            return postgreSQLGeneratorDao;
        } else {
            throw new RRException("不支持当前数据库：" + database);
        }
    }

    @Bean
    @Primary
    @Conditional(MongoCondition.class)
    public GeneratorMapper getMongoDBDao(MongoDBGeneratorMapper mongoDBGeneratorDao) {
        mongo = true;
        return mongoDBGeneratorDao;
    }

    public static boolean isMongo() {
        return mongo;
    }

}
