//
//  Status.h
//  MyWeibo
//
//  Created by ChenXin on 3/6/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  微博模型

#import <Foundation/Foundation.h>
@class User;

@interface Status : NSObject
/**
 *  微博的内容(文字)
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博的转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博的作者
 */
@property (nonatomic, strong) User *user;
@end
