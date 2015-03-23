//
//  HttpTool.m
//  MyWeibo
//
//  Created by ChenXin on 3/23/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

@implementation HttpTool

/**
 *  封装POST请求提交的数据，提交到服务器
 *
 *  @param url       服务器到url地址
 *  @param parameter post的参数
 *  @param success   成功时调用的block
 *  @param faile     失败时调用的block
 */
+(void)postURL:(NSString *)url parameter:(NSDictionary *)parameter success:(SuccessBlock)success faile:(FaileBlock)faile{
    AFHTTPRequestOperationManager *requestManager=[AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer=[AFJSONResponseSerializer serializer];
    [requestManager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        faile(error);
    }];

}

/**
 *  封装POST请求提交的数据，提交到服务器
 *
 *  @param url       服务器到url地址
 *  @param parameter post的参数
 *  @param success   成功时调用的block
 *  @param faile     失败时调用的block
 */
+(void)getURL:(NSString *)url parameter:(NSDictionary *)parameter success:(void (^)(id))success faile:(void (^)(NSError *))faile{
    AFHTTPRequestOperationManager *requestManager=[AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer=[AFJSONResponseSerializer serializer];
    [requestManager GET:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        faile(error);
    }];
}

/**
 *  封装POST包含上传文件请求提交的数据，提交到服务器
 *
 *  @param url       服务器到url地址
 *  @param parameter post的参数
 *  @param data      需要提交到服务器二进制文件数据
 *  @param success   成功时调用的block
 *  @param faile     失败时调用的block
 */
+(void)postURL:(NSString *)url parameter:(NSDictionary *)parameter binaryDatas:(NSArray *)datas success:(SuccessBlock)success faile:(FaileBlock)faile{
    AFHTTPRequestOperationManager *requestManager=[AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer=[AFJSONResponseSerializer serializer];
    [requestManager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i=0; i<datas.count; i++) {
            FormData *fd=datas[i];
            [formData appendPartWithFileData:fd.data name:fd.parameter fileName:fd.fileName mimeType:fd.mimeType];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        faile(error);
    }];

}

@end

/**
 *  封装提交文件形式的数据
 */
@implementation FormData


@end
