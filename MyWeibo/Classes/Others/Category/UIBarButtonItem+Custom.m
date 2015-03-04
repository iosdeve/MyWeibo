//
//  UIBarButtonItem+Custom.m
//  MyWeibo
//
//  Created by ChenXin on 3/4/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  自定义BarButtonItem

#import "UIBarButtonItem+Custom.h"

@implementation UIBarButtonItem (Custom)

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
+(UIBarButtonItem *) barButtonItemWithIcon:(NSString *) icon hilightIcon:(NSString *) hilightIcon target:(id) target action:(SEL) action{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:icon]  forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:hilightIcon] forState:UIControlStateHighlighted];
    //要设置按钮的大小，否则无法显示
    button.bounds=(CGRect){CGPointZero,button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

@end
