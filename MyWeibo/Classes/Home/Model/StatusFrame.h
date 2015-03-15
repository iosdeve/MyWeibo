//
//  StatusFrame.h
//  MyWeibo
//
//  Created by ChenXin on 3/15/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status;

@interface StatusFrame : NSObject

//原创微博的背景图片
@property(nonatomic,assign) CGRect statusBackgroundF;
//原创微博用户图标
@property(nonatomic,assign) CGRect userIconF;
//原创微博的VIP图片
@property(nonatomic,assign) CGRect vipIconF;
//原创微博的配图
@property(nonatomic,assign) CGRect photoF;
//原创微博的用户昵称
@property(nonatomic,assign) CGRect userTextF;
//原创微博的发布时间
@property(nonatomic,assign) CGRect createTimeF;
//原创微博的发布来源
@property(nonatomic,assign) CGRect sourceTextF;
//原创微博的内容
@property(nonatomic,assign) CGRect statusTextF;
//转发微博的背景图片
@property(nonatomic,assign) CGRect retweetStatusBackgroundF;
//转发微博的用户昵称
@property(nonatomic,assign) CGRect retweetUserTextF;
//转发微博的内容
@property(nonatomic,assign) CGRect retweetStatusTextF;
//转发微博的配图
@property(nonatomic,assign) CGRect retweetPhotoF;
//微博表格的高度
@property(nonatomic,assign) CGFloat cellHight;

/**
 *  设置微博数据，用来计算各个subviews的Frame
 */
@property(nonatomic,strong) Status *status;

@end
