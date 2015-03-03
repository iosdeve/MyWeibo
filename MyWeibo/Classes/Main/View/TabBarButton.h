//
//  TabBarButton.h
//  MyWeibo
//
//  Created by ChenXin on 3/2/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
// 自定义TabBarButton按钮

#import <UIKit/UIKit.h>

@interface TabBarButton : UIButton

//包含有TabBarItem，用来设置按钮当图标和文字
@property(nonatomic, strong) UITabBarItem *item;

@end
