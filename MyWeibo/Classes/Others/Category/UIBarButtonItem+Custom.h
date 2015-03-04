//
//  UIBarButtonItem+Custom.h
//  MyWeibo
//
//  Created by ChenXin on 3/4/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  自定义BarButtonItem

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Custom)

/**
 *  根据传入图片，自定义BarButtonItem
 *
 *  @param icon        默认图片名
 *  @param hilightIcon 高亮图片名
 *  @param target      事件响应对象
 *  @param action      事件响应方法
 *
 *  @return
 */
+(UIBarButtonItem *) barButtonItemWithIcon:(NSString *) icon hilightIcon:(NSString *) hilightIcon target:(id) target action:(SEL) action;

@end
