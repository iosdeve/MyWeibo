//
//  CustomTabBarController.m
//  MyWeibo
//
//  Created by ChenXin on 3/2/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import "CustomTabBarController.h"
#import "HomeController.h"
#import "MessageController.h"
#import "DiscoverController.h"
#import "MeController.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    HomeController *home=[[HomeController alloc] init];
    [self setupChildrenViewController:home title:@"首页" imageName:@"tabbar_home.png" selectedImageName:@"tabbar_home_selected.png"];
    
    MessageController *message=[[MessageController alloc] init];
    [self setupChildrenViewController:message title:@"消息" imageName:@"tabbar_message_center.png" selectedImageName:@"tabbar_message_center_selected.png"];
    DiscoverController *discover=[[DiscoverController alloc] init];
    [self setupChildrenViewController:discover title:@"发现" imageName:@"tabbar_discover.png" selectedImageName:@"tabbar_discover_selected.png"];
    MeController *me=[[MeController alloc] init];
    [self setupChildrenViewController:me title:@"我" imageName:@"tabbar_profile.png" selectedImageName:@"tabbar_profile_selected.png"];
}

/**
 *  设置controller的导航标题，底部item图标和文字
 *
 *  @param controller        被设置controller
 *  @param title             导航标题，底部item显示的文字
 *  @param imageName         底部item的图标名称
 *  @param selectedImageName 选中的item名称
 */
-(void) setupChildrenViewController:(UIViewController *) controller title:(NSString *) title imageName:(NSString *) imageName selectedImageName:(NSString *) selectedImageName

{
    //设置导航标题和底部Item标题
    //也可以统一使用controller.navigationItem.title来设置
    controller.tabBarItem.title=title;
    controller.navigationItem.title=title;
    controller.tabBarItem.image=[UIImage imageNamed:imageName];
    //设置选中图标不被系统渲染，默认iOS7渲染成蓝色。
    controller.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
