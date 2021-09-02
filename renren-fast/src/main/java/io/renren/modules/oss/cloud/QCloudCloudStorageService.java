/*
 * Copyright (c) 2016-2019 人人开源 All rights reserved.
 *
 * https://www.renren.io
 *
 * 版权所有，侵权必究！
 */
package io.renren.modules.oss.cloud;

import com.qcloud.cos.COSClient;
import com.qcloud.cos.ClientConfig;
import com.qcloud.cos.auth.BasicCOSCredentials;
import com.qcloud.cos.auth.COSCredentials;
import com.qcloud.cos.exception.CosClientException;
import com.qcloud.cos.http.HttpProtocol;
import com.qcloud.cos.model.CannedAccessControlList;
import com.qcloud.cos.model.CreateBucketRequest;
import com.qcloud.cos.model.ObjectMetadata;
import com.qcloud.cos.region.Region;
import io.renren.common.exception.RRException;
import org.apache.commons.io.IOUtils;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * 腾讯云存储
 *
 * @author Mark sunlightcs@gmail.com
 */
public class QCloudCloudStorageService extends AbstractCloudStorageService {

    private COSClient client;

    public QCloudCloudStorageService(CloudStorageConfig config) {
        this.config = config;

        //初始化
        init();
    }

    private void init() {
        COSCredentials credentials = new BasicCOSCredentials(
            config.getQcloudSecretId(),
            config.getQcloudSecretKey()
        );

        //初始化客户端配置，设置bucket所在的区域，华南：gz 华北：tj 华东：sh
        ClientConfig clientConfig = new ClientConfig(new Region(config.getQcloudRegion()));
        clientConfig.setHttpProtocol(HttpProtocol.https);

        client = new COSClient(credentials, clientConfig);

        String bucketName = config.getQcloudBucketName();
        if (!client.doesBucketExist(bucketName)) {
            CreateBucketRequest createBucketRequest = new CreateBucketRequest(bucketName);
            // 设置 bucket 的权限为 公共读
            createBucketRequest.setCannedAcl(CannedAccessControlList.PublicRead);
            // 创建桶
            client.createBucket(createBucketRequest);
        }
    }

    @Override
    public String upload(byte[] data, String path) {
        //腾讯云必需要以"/"开头
        if (!path.startsWith("/")) {
            path = "/" + path;
        }

        ObjectMetadata objectMetadata = new ObjectMetadata();
        //设置输入流长度
        objectMetadata.setContentLength(data.length);
        try {
            //上传到腾讯云
            client.putObject(
                config.getQcloudBucketName(), path, new ByteArrayInputStream(data), objectMetadata
            );
        } catch (CosClientException e) {
            throw new RRException("文件上传失败，" + e.getMessage());
        }

        return config.getQcloudDomain() + path;
    }

    @Override
    public String upload(InputStream inputStream, String path) {
        try {
            byte[] data = IOUtils.toByteArray(inputStream);
            return this.upload(data, path);
        } catch (IOException e) {
            throw new RRException("上传文件失败", e);
        }
    }

    @Override
    public String uploadSuffix(byte[] data, String suffix) {
        return upload(data, getPath(config.getQcloudPrefix(), suffix));
    }

    @Override
    public String uploadSuffix(InputStream inputStream, String suffix) {
        return upload(inputStream, getPath(config.getQcloudPrefix(), suffix));
    }
}
