/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : localhost:3306
 Source Schema         : renren_fast

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 02/09/2021 20:15:32
*/

SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`
(
    `SCHED_NAME`    varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `TRIGGER_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `BLOB_DATA`     blob NULL,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    INDEX           `SCHED_NAME`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`
(
    `SCHED_NAME`    varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `CALENDAR`      blob                                                    NOT NULL,
    PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`
(
    `SCHED_NAME`      varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `TRIGGER_NAME`    varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `TRIGGER_GROUP`   varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `TIME_ZONE_ID`    varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers`
VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', '0 0/30 * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`
(
    `SCHED_NAME`        varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `ENTRY_ID`          varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL,
    `TRIGGER_NAME`      varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `TRIGGER_GROUP`     varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `INSTANCE_NAME`     varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `FIRED_TIME`        bigint                                                  NOT NULL,
    `SCHED_TIME`        bigint                                                  NOT NULL,
    `PRIORITY`          int                                                     NOT NULL,
    `STATE`             varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL,
    `JOB_NAME`          varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `JOB_GROUP`         varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `IS_NONCONCURRENT`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
    INDEX               `IDX_QRTZ_FT_TRIG_INST_NAME`(`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE,
    INDEX               `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY`(`SCHED_NAME`, `INSTANCE_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
    INDEX               `IDX_QRTZ_FT_J_G`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
    INDEX               `IDX_QRTZ_FT_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
    INDEX               `IDX_QRTZ_FT_T_G`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    INDEX               `IDX_QRTZ_FT_TG`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`
(
    `SCHED_NAME`        varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `JOB_NAME`          varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `JOB_GROUP`         varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `DESCRIPTION`       varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `JOB_CLASS_NAME`    varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `IS_DURABLE`        varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL,
    `IS_NONCONCURRENT`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL,
    `IS_UPDATE_DATA`    varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL,
    `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL,
    `JOB_DATA`          blob NULL,
    PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
    INDEX               `IDX_QRTZ_J_REQ_RECOVERY`(`SCHED_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
    INDEX               `IDX_QRTZ_J_GRP`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details`
VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', NULL, 'io.renren.modules.job.utils.ScheduleJob', '0', '0', '0', '0',
        0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002E696F2E72656E72656E2E6D6F64756C65732E6A6F622E656E746974792E5363686564756C654A6F62456E7469747900000000000000010200074C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7870740008746573745461736B7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017AE86906B87874000E3020302F3330202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000174000672656E72656E74000CE58F82E695B0E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0013000000007800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`
(
    `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `LOCK_NAME`  varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL,
    PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks`
VALUES ('RenrenScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks`
VALUES ('RenrenScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`
(
    `SCHED_NAME`    varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`
(
    `SCHED_NAME`        varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `INSTANCE_NAME`     varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `LAST_CHECKIN_TIME` bigint                                                  NOT NULL,
    `CHECKIN_INTERVAL`  bigint                                                  NOT NULL,
    PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state`
VALUES ('RenrenScheduler', 'Codecrab1630584748679', 1630584885273, 15000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`
(
    `SCHED_NAME`      varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `TRIGGER_NAME`    varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `TRIGGER_GROUP`   varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `REPEAT_COUNT`    bigint                                                  NOT NULL,
    `REPEAT_INTERVAL` bigint                                                  NOT NULL,
    `TIMES_TRIGGERED` bigint                                                  NOT NULL,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`
(
    `SCHED_NAME`    varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `TRIGGER_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `STR_PROP_1`    varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `STR_PROP_2`    varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `STR_PROP_3`    varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `INT_PROP_1`    int NULL DEFAULT NULL,
    `INT_PROP_2`    int NULL DEFAULT NULL,
    `LONG_PROP_1`   bigint NULL DEFAULT NULL,
    `LONG_PROP_2`   bigint NULL DEFAULT NULL,
    `DEC_PROP_1`    decimal(13, 4) NULL DEFAULT NULL,
    `DEC_PROP_2`    decimal(13, 4) NULL DEFAULT NULL,
    `BOOL_PROP_1`   varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `BOOL_PROP_2`   varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`
(
    `SCHED_NAME`     varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `TRIGGER_NAME`   varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `TRIGGER_GROUP`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `JOB_NAME`       varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `JOB_GROUP`      varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `DESCRIPTION`    varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `NEXT_FIRE_TIME` bigint NULL DEFAULT NULL,
    `PREV_FIRE_TIME` bigint NULL DEFAULT NULL,
    `PRIORITY`       int NULL DEFAULT NULL,
    `TRIGGER_STATE`  varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL,
    `TRIGGER_TYPE`   varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL,
    `START_TIME`     bigint                                                  NOT NULL,
    `END_TIME`       bigint NULL DEFAULT NULL,
    `CALENDAR_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `MISFIRE_INSTR`  smallint NULL DEFAULT NULL,
    `JOB_DATA`       blob NULL,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    INDEX            `IDX_QRTZ_T_J`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
    INDEX            `IDX_QRTZ_T_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
    INDEX            `IDX_QRTZ_T_C`(`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE,
    INDEX            `IDX_QRTZ_T_G`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE,
    INDEX            `IDX_QRTZ_T_STATE`(`SCHED_NAME`, `TRIGGER_STATE`) USING BTREE,
    INDEX            `IDX_QRTZ_T_N_STATE`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
    INDEX            `IDX_QRTZ_T_N_G_STATE`(`SCHED_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
    INDEX            `IDX_QRTZ_T_NEXT_FIRE_TIME`(`SCHED_NAME`, `NEXT_FIRE_TIME`) USING BTREE,
    INDEX            `IDX_QRTZ_T_NFT_ST`(`SCHED_NAME`, `TRIGGER_STATE`, `NEXT_FIRE_TIME`) USING BTREE,
    INDEX            `IDX_QRTZ_T_NFT_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`) USING BTREE,
    INDEX            `IDX_QRTZ_T_NFT_ST_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_STATE`) USING BTREE,
    INDEX            `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
    CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers`
VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', 'TASK_1', 'DEFAULT', NULL, 1630585800000, -1, 5, 'WAITING', 'CRON',
        1627479868000, 0, NULL, 2,
        0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002E696F2E72656E72656E2E6D6F64756C65732E6A6F622E656E746974792E5363686564756C654A6F62456E7469747900000000000000010200074C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7870740008746573745461736B7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017AE86906B87874000E3020302F3330202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000174000672656E72656E74000CE58F82E695B0E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0013000000007800);

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job`
(
    `job_id`          bigint NOT NULL AUTO_INCREMENT COMMENT '??????id',
    `bean_name`       varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'spring bean??????',
    `params`          varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '??????',
    `cron_expression` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'cron?????????',
    `status`          tinyint NULL DEFAULT NULL COMMENT '????????????  0?????????  1?????????',
    `remark`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '??????',
    `create_time`     datetime NULL DEFAULT NULL COMMENT '????????????',
    PRIMARY KEY (`job_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '????????????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schedule_job
-- ----------------------------
INSERT INTO `schedule_job`
VALUES (1, 'testTask', 'renren', '0 0/30 * * * ?', 0, '????????????', '2021-07-27 22:40:35');

-- ----------------------------
-- Table structure for schedule_job_log
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job_log`;
CREATE TABLE `schedule_job_log`
(
    `log_id`      bigint  NOT NULL AUTO_INCREMENT COMMENT '????????????id',
    `job_id`      bigint  NOT NULL COMMENT '??????id',
    `bean_name`   varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'spring bean??????',
    `params`      varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '??????',
    `status`      tinyint NOT NULL COMMENT '????????????    0?????????    1?????????',
    `error`       varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '????????????',
    `times`       int     NOT NULL COMMENT '??????(???????????????)',
    `create_time` datetime NULL DEFAULT NULL COMMENT '????????????',
    PRIMARY KEY (`log_id`) USING BTREE,
    INDEX         `job_id`(`job_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '??????????????????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schedule_job_log
-- ----------------------------
INSERT INTO `schedule_job_log`
VALUES (1, 1, 'testTask', 'renren', 0, NULL, 1, '2021-07-28 22:00:00');
INSERT INTO `schedule_job_log`
VALUES (2, 1, 'testTask', 'renren', 0, NULL, 0, '2021-07-28 22:30:00');
INSERT INTO `schedule_job_log`
VALUES (3, 1, 'testTask', 'renren', 0, NULL, 0, '2021-07-28 23:00:00');
INSERT INTO `schedule_job_log`
VALUES (4, 1, 'testTask', 'renren', 0, NULL, 0, '2021-07-28 23:07:40');
INSERT INTO `schedule_job_log`
VALUES (5, 1, 'testTask', 'renren', 0, NULL, 0, '2021-07-28 23:08:58');
INSERT INTO `schedule_job_log`
VALUES (6, 1, 'testTask', 'renren', 0, NULL, 0, '2021-07-28 23:09:40');
INSERT INTO `schedule_job_log`
VALUES (7, 1, 'testTask', 'renren', 0, NULL, 0, '2021-07-28 23:10:28');
INSERT INTO `schedule_job_log`
VALUES (8, 1, 'testTask', 'renren', 0, NULL, 1, '2021-07-28 23:30:00');
INSERT INTO `schedule_job_log`
VALUES (9, 1, 'testTask', 'renren', 0, NULL, 4, '2021-07-29 00:00:02');

-- ----------------------------
-- Table structure for sys_captcha
-- ----------------------------
DROP TABLE IF EXISTS `sys_captcha`;
CREATE TABLE `sys_captcha`
(
    `uuid`        char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci   NOT NULL COMMENT 'uuid',
    `code`        varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '?????????',
    `expire_time` datetime NULL DEFAULT NULL COMMENT '????????????',
    PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '???????????????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_captcha
-- ----------------------------
INSERT INTO `sys_captcha`
VALUES ('2df4b40e-d598-47de-8b00-7b0819ee5ee6', 'y6p8p', '2021-07-28 21:49:39');
INSERT INTO `sys_captcha`
VALUES ('a13abdf6-77fb-4cc5-8ded-243216c3bc63', 'm6nyx', '2021-07-28 21:49:30');
INSERT INTO `sys_captcha`
VALUES ('e53479a8-5e11-4524-820e-bf8687ebd1cf', 'bdcnc', '2021-07-28 21:49:38');
INSERT INTO `sys_captcha`
VALUES ('f994919c-3b4f-4879-8114-e1d8c0a4a418', 'wbdg8', '2021-07-28 21:49:37');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`
(
    `id`          bigint NOT NULL AUTO_INCREMENT,
    `param_key`   varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'key',
    `param_value` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'value',
    `status`      tinyint NULL DEFAULT 1 COMMENT '??????   0?????????   1?????????',
    `remark`      varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '??????',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `param_key`(`param_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '?????????????????????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config`
VALUES (1, 'CLOUD_STORAGE_CONFIG_KEY',
        '{\"aliyunAccessKeyId\":\"\",\"aliyunAccessKeySecret\":\"\",\"aliyunBucketName\":\"\",\"aliyunDomain\":\"\",\"aliyunEndPoint\":\"\",\"aliyunPrefix\":\"\",\"qcloudBucketName\":\"\",\"qcloudDomain\":\"\",\"qcloudPrefix\":\"\",\"qcloudSecretId\":\"\",\"qcloudSecretKey\":\"\",\"qiniuAccessKey\":\"NrgMfABZxWLo5B-YYSjoE8-AZ1EISdi1Z3ubLOeZ\",\"qiniuBucketName\":\"ios-app\",\"qiniuDomain\":\"http://7xqbwh.dl1.z0.glb.clouddn.com\",\"qiniuPrefix\":\"upload\",\"qiniuSecretKey\":\"uIwJHevMRWU0VLxFvgy0tAcOdGqasdtVlJkdy6vV\",\"type\":1}',
        0, '?????????????????????');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`
(
    `id`          bigint NOT NULL AUTO_INCREMENT,
    `username`    varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '?????????',
    `operation`   varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '????????????',
    `method`      varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '????????????',
    `params`      varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '????????????',
    `time`        bigint NOT NULL COMMENT '????????????(??????)',
    `ip`          varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'IP??????',
    `create_date` datetime NULL DEFAULT NULL COMMENT '????????????',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '????????????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log`
VALUES (1, 'admin', '????????????', 'io.renren.modules.sys.controller.SysMenuController.update()',
        '[{\"menuId\":5,\"parentId\":1,\"name\":\"SQL??????\",\"url\":\"http://localhost:9999/renren-fast/druid/sql.html\",\"type\":1,\"icon\":\"sql\",\"orderNum\":4}]',
        8, '0:0:0:0:0:0:0:1', '2021-07-28 22:13:57');
INSERT INTO `sys_log`
VALUES (2, 'admin', '????????????', 'io.renren.modules.sys.controller.SysUserController.update()',
        '[{\"userId\":1,\"username\":\"admin\",\"password\":\"9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d\",\"salt\":\"YzcmCZNvbXocrsz9dm8e\",\"email\":\"codecrab.top@gmail.com\",\"mobile\":\"17122840624\",\"status\":1,\"roleIdList\":[],\"createUserId\":1}]',
        77, '0:0:0:0:0:0:0:1', '2021-07-28 22:32:33');
INSERT INTO `sys_log`
VALUES (3, 'admin', '????????????', 'io.renren.modules.sys.controller.SysUserController.update()',
        '[{\"userId\":1,\"username\":\"admin\",\"password\":\"9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d\",\"salt\":\"YzcmCZNvbXocrsz9dm8e\",\"email\":\"codecrab.top@gmail.com\",\"mobile\":\"17122840624\",\"status\":1,\"roleIdList\":[],\"createUserId\":1}]',
        3, '0:0:0:0:0:0:0:1', '2021-07-28 22:33:26');
INSERT INTO `sys_log`
VALUES (4, 'admin', '????????????', 'io.renren.modules.sys.controller.SysUserController.update()',
        '[{\"userId\":1,\"username\":\"admin\",\"password\":\"9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d\",\"salt\":\"YzcmCZNvbXocrsz9dm8e\",\"email\":\"codecrab.top@gmail.com\",\"mobile\":\"17122840624\",\"status\":1,\"roleIdList\":[],\"createUserId\":1}]',
        4, '0:0:0:0:0:0:0:1', '2021-07-28 22:41:30');
INSERT INTO `sys_log`
VALUES (5, 'admin', '????????????', 'io.renren.modules.sys.controller.SysUserController.update()',
        '[{\"userId\":1,\"username\":\"admin\",\"password\":\"9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d\",\"salt\":\"YzcmCZNvbXocrsz9dm8e\",\"email\":\"codecrab.top@gmail.com\",\"mobile\":\"17122840624\",\"status\":1,\"roleIdList\":[],\"createUserId\":1}]',
        3, '0:0:0:0:0:0:0:1', '2021-07-28 22:50:07');
INSERT INTO `sys_log`
VALUES (6, 'admin', '????????????', 'io.renren.modules.sys.controller.SysRoleController.save()',
        '[{\"roleId\":1,\"roleName\":\"admin\",\"remark\":\"???????????????\",\"createUserId\":1,\"menuIdList\":[1,2,15,16,17,18,3,19,20,21,22,4,23,24,25,26,5,6,7,8,9,10,11,12,13,14,27,29,30,-666666],\"createTime\":\"Jul 28, 2021 10:51:06 PM\"}]',
        52, '0:0:0:0:0:0:0:1', '2021-07-28 22:51:07');
INSERT INTO `sys_log`
VALUES (7, 'admin', '????????????', 'io.renren.modules.sys.controller.SysRoleController.update()',
        '[{\"roleId\":1,\"roleName\":\"admin\",\"remark\":\"???????????????\",\"createUserId\":1,\"menuIdList\":[1,2,15,16,17,18,3,19,20,21,22,4,23,24,25,26,5,6,7,8,9,10,11,12,13,14,27,29,30,-666666]}]',
        32, '0:0:0:0:0:0:0:1', '2021-07-28 22:52:13');
INSERT INTO `sys_log`
VALUES (8, 'admin', '????????????', 'io.renren.modules.sys.controller.SysRoleController.update()',
        '[{\"roleId\":1,\"roleName\":\"admin\",\"remark\":\"???????????????\",\"createUserId\":1,\"menuIdList\":[1,2,15,16,17,18,3,19,20,21,22,4,23,24,25,26,5,6,7,8,9,10,11,12,13,14,27,29,30,-666666]}]',
        97, '0:0:0:0:0:0:0:1', '2021-07-28 22:59:27');
INSERT INTO `sys_log`
VALUES (9, 'admin', '????????????', 'io.renren.modules.sys.controller.SysRoleController.update()',
        '[{\"roleId\":1,\"roleName\":\"admin\",\"remark\":\"???????????????\",\"createUserId\":1,\"menuIdList\":[1,2,15,16,17,18,3,19,20,21,22,4,23,24,25,26,5,6,7,8,9,10,11,12,13,14,27,29,30,-666666]}]',
        17, '0:0:0:0:0:0:0:1', '2021-07-28 22:59:39');
INSERT INTO `sys_log`
VALUES (10, 'admin', '????????????', 'io.renren.modules.sys.controller.SysRoleController.update()',
        '[{\"roleId\":1,\"roleName\":\"admin\",\"remark\":\"???????????????\",\"createUserId\":1,\"menuIdList\":[1,2,15,16,17,18,3,19,20,21,22,4,23,24,25,26,5,6,7,8,9,10,11,12,13,14,27,29,30,-666666]}]',
        116, '0:0:0:0:0:0:0:1', '2021-07-28 23:00:30');
INSERT INTO `sys_log`
VALUES (11, 'admin', '????????????', 'io.renren.modules.sys.controller.SysRoleController.update()',
        '[{\"roleId\":1,\"roleName\":\"admin\",\"remark\":\"???????????????\",\"createUserId\":1,\"menuIdList\":[1,2,15,16,17,18,3,19,20,21,22,4,23,24,25,26,5,6,7,8,9,10,11,12,13,14,27,29,30,-666666]}]',
        81, '0:0:0:0:0:0:0:1', '2021-07-28 23:06:30');
INSERT INTO `sys_log`
VALUES (12, 'admin', '??????????????????', 'io.renren.modules.job.controller.ScheduleJobController.run()', '[[1]]', 18,
        '0:0:0:0:0:0:0:1', '2021-07-28 23:07:26');
INSERT INTO `sys_log`
VALUES (13, 'admin', '??????????????????', 'io.renren.modules.job.controller.ScheduleJobController.run()', '[[1]]', 8,
        '0:0:0:0:0:0:0:1', '2021-07-28 23:08:58');
INSERT INTO `sys_log`
VALUES (14, 'admin', '??????????????????', 'io.renren.modules.job.controller.ScheduleJobController.run()', '[[1]]', 8,
        '0:0:0:0:0:0:0:1', '2021-07-28 23:09:21');
INSERT INTO `sys_log`
VALUES (15, 'admin', '??????????????????', 'io.renren.modules.job.controller.ScheduleJobController.run()', '[[1]]', 16,
        '0:0:0:0:0:0:0:1', '2021-07-28 23:10:15');
INSERT INTO `sys_log`
VALUES (16, 'admin', '??????????????????', 'io.renren.modules.job.controller.ScheduleJobController.resume()', '[[1]]', 36,
        '0:0:0:0:0:0:0:1', '2021-07-28 23:42:39');
INSERT INTO `sys_log`
VALUES (17, 'admin', '??????????????????', 'io.renren.modules.job.controller.ScheduleJobController.pause()', '[[1]]', 19,
        '0:0:0:0:0:0:0:1', '2021-07-28 23:42:59');
INSERT INTO `sys_log`
VALUES (18, 'admin', '??????????????????', 'io.renren.modules.job.controller.ScheduleJobController.resume()', '[[1,2]]', 10,
        '0:0:0:0:0:0:0:1', '2021-07-28 23:43:38');
INSERT INTO `sys_log`
VALUES (19, 'admin', '??????????????????', 'io.renren.modules.job.controller.ScheduleJobController.resume()', '[[1,2]]', 9,
        '0:0:0:0:0:0:0:1', '2021-07-28 23:43:42');
INSERT INTO `sys_log`
VALUES (20, 'admin', '??????????????????', 'io.renren.modules.job.controller.ScheduleJobController.pause()', '[[1,2]]', 43,
        '0:0:0:0:0:0:0:1', '2021-07-28 23:59:12');
INSERT INTO `sys_log`
VALUES (21, 'admin', '??????????????????', 'io.renren.modules.job.controller.ScheduleJobController.resume()', '[[1]]', 19,
        '0:0:0:0:0:0:0:1', '2021-07-28 23:59:37');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`
(
    `menu_id`   bigint NOT NULL AUTO_INCREMENT,
    `parent_id` bigint NULL DEFAULT NULL COMMENT '?????????ID??????????????????0',
    `name`      varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '????????????',
    `url`       varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '??????URL',
    `perms`     varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '??????(??????????????????????????????user:list,user:create)',
    `type`      int NULL DEFAULT NULL COMMENT '??????   0?????????   1?????????   2?????????',
    `icon`      varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '????????????',
    `order_num` int NULL DEFAULT NULL COMMENT '??????',
    PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '????????????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu`
VALUES (1, 0, '????????????', NULL, NULL, 0, 'system', 0);
INSERT INTO `sys_menu`
VALUES (2, 1, '???????????????', 'sys/user', NULL, 1, 'admin', 1);
INSERT INTO `sys_menu`
VALUES (3, 1, '????????????', 'sys/role', NULL, 1, 'role', 2);
INSERT INTO `sys_menu`
VALUES (4, 1, '????????????', 'sys/menu', NULL, 1, 'menu', 3);
INSERT INTO `sys_menu`
VALUES (5, 1, 'SQL??????', 'http://localhost:9999/renren-fast/druid/sql.html', NULL, 1, 'sql', 4);
INSERT INTO `sys_menu`
VALUES (6, 1, '????????????', 'job/schedule', NULL, 1, 'job', 5);
INSERT INTO `sys_menu`
VALUES (7, 6, '??????', NULL, 'sys:schedule:list,sys:schedule:info', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (8, 6, '??????', NULL, 'sys:schedule:save', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (9, 6, '??????', NULL, 'sys:schedule:update', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (10, 6, '??????', NULL, 'sys:schedule:delete', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (11, 6, '??????', NULL, 'sys:schedule:pause', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (12, 6, '??????', NULL, 'sys:schedule:resume', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (13, 6, '????????????', NULL, 'sys:schedule:run', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (14, 6, '????????????', NULL, 'sys:schedule:log', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (15, 2, '??????', NULL, 'sys:user:list,sys:user:info', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (16, 2, '??????', NULL, 'sys:user:save,sys:role:select', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (17, 2, '??????', NULL, 'sys:user:update,sys:role:select', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (18, 2, '??????', NULL, 'sys:user:delete', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (19, 3, '??????', NULL, 'sys:role:list,sys:role:info', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (20, 3, '??????', NULL, 'sys:role:save,sys:menu:list', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (21, 3, '??????', NULL, 'sys:role:update,sys:menu:list', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (22, 3, '??????', NULL, 'sys:role:delete', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (23, 4, '??????', NULL, 'sys:menu:list,sys:menu:info', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (24, 4, '??????', NULL, 'sys:menu:save,sys:menu:select', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (25, 4, '??????', NULL, 'sys:menu:update,sys:menu:select', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (26, 4, '??????', NULL, 'sys:menu:delete', 2, NULL, 0);
INSERT INTO `sys_menu`
VALUES (27, 1, '????????????', 'sys/config',
        'sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete', 1, 'config', 6);
INSERT INTO `sys_menu`
VALUES (29, 1, '????????????', 'sys/log', 'sys:log:list', 1, 'log', 7);
INSERT INTO `sys_menu`
VALUES (30, 1, '????????????', 'oss/oss', 'sys:oss:all', 1, 'oss', 6);

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss`
(
    `id`          bigint NOT NULL AUTO_INCREMENT,
    `url`         varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'URL??????',
    `create_date` datetime NULL DEFAULT NULL COMMENT '????????????',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '????????????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oss
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`
(
    `role_id`        bigint NOT NULL AUTO_INCREMENT,
    `role_name`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '????????????',
    `remark`         varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '??????',
    `create_user_id` bigint NULL DEFAULT NULL COMMENT '?????????ID',
    `create_time`    datetime NULL DEFAULT NULL COMMENT '????????????',
    PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '??????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role`
VALUES (1, 'admin', '???????????????', 1, '2021-07-28 22:51:07');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`
(
    `id`      bigint NOT NULL AUTO_INCREMENT,
    `role_id` bigint NULL DEFAULT NULL COMMENT '??????ID',
    `menu_id` bigint NULL DEFAULT NULL COMMENT '??????ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '???????????????????????????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu`
VALUES (1, 1, 1);
INSERT INTO `sys_role_menu`
VALUES (2, 1, 2);
INSERT INTO `sys_role_menu`
VALUES (3, 1, 15);
INSERT INTO `sys_role_menu`
VALUES (4, 1, 16);
INSERT INTO `sys_role_menu`
VALUES (5, 1, 17);
INSERT INTO `sys_role_menu`
VALUES (6, 1, 18);
INSERT INTO `sys_role_menu`
VALUES (7, 1, 3);
INSERT INTO `sys_role_menu`
VALUES (8, 1, 19);
INSERT INTO `sys_role_menu`
VALUES (9, 1, 20);
INSERT INTO `sys_role_menu`
VALUES (10, 1, 21);
INSERT INTO `sys_role_menu`
VALUES (11, 1, 22);
INSERT INTO `sys_role_menu`
VALUES (12, 1, 4);
INSERT INTO `sys_role_menu`
VALUES (13, 1, 23);
INSERT INTO `sys_role_menu`
VALUES (14, 1, 24);
INSERT INTO `sys_role_menu`
VALUES (15, 1, 25);
INSERT INTO `sys_role_menu`
VALUES (16, 1, 26);
INSERT INTO `sys_role_menu`
VALUES (17, 1, 5);
INSERT INTO `sys_role_menu`
VALUES (18, 1, 6);
INSERT INTO `sys_role_menu`
VALUES (19, 1, 7);
INSERT INTO `sys_role_menu`
VALUES (20, 1, 8);
INSERT INTO `sys_role_menu`
VALUES (21, 1, 9);
INSERT INTO `sys_role_menu`
VALUES (22, 1, 10);
INSERT INTO `sys_role_menu`
VALUES (23, 1, 11);
INSERT INTO `sys_role_menu`
VALUES (24, 1, 12);
INSERT INTO `sys_role_menu`
VALUES (25, 1, 13);
INSERT INTO `sys_role_menu`
VALUES (26, 1, 14);
INSERT INTO `sys_role_menu`
VALUES (27, 1, 27);
INSERT INTO `sys_role_menu`
VALUES (28, 1, 29);
INSERT INTO `sys_role_menu`
VALUES (29, 1, 30);
INSERT INTO `sys_role_menu`
VALUES (30, 1, -666666);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`
(
    `user_id`        bigint                                                       NOT NULL AUTO_INCREMENT,
    `username`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '?????????',
    `password`       varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '??????',
    `salt`           varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '???',
    `email`          varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '??????',
    `mobile`         varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '?????????',
    `status`         tinyint NULL DEFAULT NULL COMMENT '??????  0?????????   1?????????',
    `create_user_id` bigint NULL DEFAULT NULL COMMENT '?????????ID',
    `create_time`    datetime NULL DEFAULT NULL COMMENT '????????????',
    PRIMARY KEY (`user_id`) USING BTREE,
    UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '????????????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user`
VALUES (1, 'admin', '9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d', 'YzcmCZNvbXocrsz9dm8e',
        'codecrab.top@gmail.com', '17122840624', 1, 1, '2016-11-11 11:11:11');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`
(
    `id`      bigint NOT NULL AUTO_INCREMENT,
    `user_id` bigint NULL DEFAULT NULL COMMENT '??????ID',
    `role_id` bigint NULL DEFAULT NULL COMMENT '??????ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '???????????????????????????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_token
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_token`;
CREATE TABLE `sys_user_token`
(
    `user_id`     bigint                                                        NOT NULL,
    `token`       varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'token',
    `expire_time` datetime NULL DEFAULT NULL COMMENT '????????????',
    `update_time` datetime NULL DEFAULT NULL COMMENT '????????????',
    PRIMARY KEY (`user_id`) USING BTREE,
    UNIQUE INDEX `token`(`token`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '????????????Token' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_token
-- ----------------------------
INSERT INTO `sys_user_token`
VALUES (1, '24c798a10014682e8bf2f26bae59ad29', '2021-09-03 08:12:44', '2021-09-02 20:12:44');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`
(
    `user_id`     bigint                                                       NOT NULL AUTO_INCREMENT,
    `username`    varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '?????????',
    `mobile`      varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '?????????',
    `password`    varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '??????',
    `create_time` datetime NULL DEFAULT NULL COMMENT '????????????',
    PRIMARY KEY (`user_id`) USING BTREE,
    UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '??????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user`
VALUES (1, 'mark', '13612345678', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',
        '2017-03-23 22:37:41');

SET
FOREIGN_KEY_CHECKS = 1;
