//
//  HttpTool.h
//  MyWeibo
//
//  Created by ChenXin on 3/23/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessBlock)(id responseObject);
typedef void(^FaileBlock)(NSError *error);

@interface HttpTool : NSObject

/**
 *  封装POST请求提交的数据，提交到服务器
 *
 *  @param url       服务器到url地址
 *  @param parameter post的参数
 *  @param success   成功时调用的block
 *  @param faile     失败时调用的block
 */
+(void) postURL:(NSString *) url parameter:(NSDictionary *) parameter success:(SuccessBlock) success faile:(FaileBlock) faile;

/**
 *  封装GET请求提交的数据，提交到服务器
 *
 *  @param url       服务器到url地址
 *  @param parameter post的参数
 *  @param success   成功时调用的block
 *  @param faile     失败时调用的block
 */
+(void) getURL:(NSString *) url parameter:(NSDictionary *) parameter success:(void (^) (id responseObject)) success faile: (void (^) (NSError *error)) faile;

/**
 *  封装POST包含上传文件请求提交的数据，提交到服务器
 *
 *  @param url       服务器到url地址
 *  @param parameter post的参数
 *  @param data      需要提交到服务器二进制文件数据
 *  @param success   成功时调用的block
 *  @param faile     失败时调用的block
 */
+(void) postURL:(NSString *) url parameter:(NSDictionary *) parameter binaryDatas:(NSArray *) datas success:(SuccessBlock) success faile:(FaileBlock) faile;

@end

/**
 *  封装提交文件形式的数据
 */
@interface FormData: NSObject
//文件名称
@property(nonatomic, copy) NSString *fileName;
//服务器对应的参数名称
@property(nonatomic, copy) NSString *parameter;
//数据类型
@property(nonatomic, copy) NSString *mimeType;
//二进制数据
@property(nonatomic, strong) NSData *data;

@end
