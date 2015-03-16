//
//  User.h
//  MyWeibo
//
//  Created by ChenXin on 3/6/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

@interface User : NSObject
/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户的头像
 */
@property (nonatomic, copy) NSString *profile_image_url;
/**
 *  是否为Vip
 */
@property (nonatomic, assign, getter = isVip) int mbtype;
/**
 *  是否为会员
 */
@property (nonatomic, assign) int mbrank;

@end
