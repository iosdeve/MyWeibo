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
#import "UIImage+Custom.h"
#import "CustomTabBar.h"

@interface CustomTabBarController ()
@property(nonatomic ,weak) CustomTabBar *customTabbar;
@end

@implementation CustomTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化自定义TabBar
    [self setupCustomTabBar];
    
    HomeController *home=[[HomeController alloc] init];
    [self setupChildrenViewController:home title:@"首页" imageName:@"tabbar_home.png" selectedImageName:@"tabbar_home_selected.png"];
    MessageController *message=[[MessageController alloc] init];
    [self setupChildrenViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected.png"];
    DiscoverController *discover=[[DiscoverController alloc] init];
    [self setupChildrenViewController:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected.png"];
    MeController *me=[[MeController alloc] init];
    [self setupChildrenViewController:me title:@"我" imageName:@"tabbar_profile.png" selectedImageName:@"tabbar_profile_selected.png"];
}

/**
 *  当view即将出现时，tabBar才被初始化，所以要在此方法中移除原有tabBar中的view
 */
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //移除原有tabBar中的view
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
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
    controller.tabBarItem.image=[UIImage imageWithName:imageName];
    //设置选中图标不被系统渲染，默认iOS7渲染成蓝色。
    UIImage *selectImage=[UIImage imageWithName:selectedImageName];
    if (iOS7) {
        controller.tabBarItem.selectedImage=[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        //iOS6不支持imageWithRenderingMode方法
        controller.tabBarItem.selectedImage=selectImage;
    }
    
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];
    
    [self.customTabbar addBarButtionWithItem:controller.tabBarItem];

}

/**
 *  初始化自定义tabBar
 */
-(void) setupCustomTabBar{
    CustomTabBar *customTabbar=[[CustomTabBar alloc] init];
    //设置自定义Tabbar的frame大小和自带的大小相同
    customTabbar.frame=self.tabBar.bounds;
    customTabbar.backgroundColor=[UIColor orangeColor];
    [self.tabBar addSubview:customTabbar];
    self.customTabbar=customTabbar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
