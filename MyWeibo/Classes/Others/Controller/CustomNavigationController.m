//
//  CustomNavigationController.m
//  MyWeibo
//
//  Created by ChenXin on 3/3/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
// 自定义Navigation

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

//类初始化时候只被调用一次
+(void)initialize{
    if (!iOS7) {
        //设置NavigationBar的主题
        UINavigationBar *navBar=[UINavigationBar appearance];
        [navBar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        NSMutableDictionary *dictBarTitle=[NSMutableDictionary dictionary];
        dictBarTitle[UITextAttributeFont]=[UIFont boldSystemFontOfSize:19];
        dictBarTitle[UITextAttributeTextColor]=[UIColor blackColor];
        dictBarTitle[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
        [navBar setTitleTextAttributes:dictBarTitle];
        
        //设置ios6的状态栏为黑色，如果不设置，会被主题背景同化
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleBlackOpaque;
        
        //设置barButtionItem的文字主题
        UIBarButtonItem *barItem=[UIBarButtonItem appearance];
        NSMutableDictionary *dictItemTitle=[NSMutableDictionary dictionary];
        dictItemTitle[UITextAttributeFont]=[UIFont systemFontOfSize:11];
        dictItemTitle[UITextAttributeTextColor]=[UIColor darkGrayColor];
        dictItemTitle[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
        [barItem setTitleTextAttributes:dictItemTitle forState:UIControlStateNormal];
        [barItem setTitleTextAttributes:dictItemTitle forState:UIControlStateHighlighted];
        //设置barButtionItem的背景主题
        [barItem setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [barItem setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [barItem setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
}

/**
 *  当push新控制器当时候，自动隐藏底部当tabBar
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //不是根控制器当时候才设置隐藏
    if (self.childViewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
