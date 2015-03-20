//
//  Account.h
//  MyWeibo
//
//  Created by ChenXin on 3/5/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
// 登陆成功后返回的accessToken相关信息

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>
// 用于交互的accesstoken
@property(nonatomic, copy) NSString *access_token;
// token过期时间
@property(nonatomic, assign) long long expires_in;
@property(nonatomic, assign) long long remind_in;
// 用户Id
@property(nonatomic, assign) long long uid;
//保存时间
@property(nonatomic, strong) NSDate *saveTime;
//用户昵称
@property(nonatomic, copy) NSString *name;

/**
 *  从字典转换为对象KVC
 */
+(id) accountFromeDict:(NSDictionary *) dict;

@end
