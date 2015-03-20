//
//  CustomTabBar.h
//  MyWeibo
//
//  Created by ChenXin on 3/2/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
// 自定义TabBar

#import <UIKit/UIKit.h>
@class CustomTabBar;

@protocol CustomTabBarDelegate <NSObject>
@optional
/**
 *  点击tabbar按钮时的代理方法
 *
 *  @param tabBar
 *  @param from   切换前的按钮index
 *  @param to     选中按钮的index
 */
-(void) tabBar:(CustomTabBar *) tabBar didSelectFromIndex:(int) from toIndex:(int) to;
/**
 *  点击中间加号按钮的代理方法
 *
 *  @param tabBar
 */
-(void) tabBarPlusButtonClick:(CustomTabBar *) tabBar;

@end

@interface CustomTabBar : UIView

@property(nonatomic, weak) id<CustomTabBarDelegate> delegate;

/**
 *  根据UITabBarItem添加自定义item
 *
 *  @param item 参照的UITabBarItem
 */
-(void) addBarButtionWithItem:(UITabBarItem *) item;

@end
