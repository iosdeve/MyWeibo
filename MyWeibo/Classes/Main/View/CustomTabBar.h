//
//  CustomTabBar.h
//  MyWeibo
//
//  Created by ChenXin on 3/2/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
// 自定义TabBar

#import <UIKit/UIKit.h>

@interface CustomTabBar : UIView

/**
 *  根据UITabBarItem添加自定义item
 *
 *  @param item 参照的UITabBarItem
 */
-(void) addBarButtionWithItem:(UITabBarItem *) item;

@end
