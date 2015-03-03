//
//  UIImage+Custom.h
//  MyWeibo
//
//  Created by ChenXin on 3/2/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//UIImage分类，自动构建IOS6，IOS7图片

#import <UIKit/UIKit.h>

@interface UIImage (Custom)

/**
 *  传入图片名称，根据当前系统版本，返回ios6，ios7图片
 *
 *  @param name 图片名称
 *
 *  @return 返回UIImage
 */
+(UIImage *) imageWithName:(NSString *) name;

@end