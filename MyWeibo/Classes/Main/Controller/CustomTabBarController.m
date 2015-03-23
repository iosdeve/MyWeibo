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
#import "CustomTabBar.h"
#import "CustomNavigationController.h"
#import "ComposeController.h"
#import "HttpTool.h"
#import "Util.h"
#import "Account.h"
#import "UnreadMessageCount.h"
#import "MJExtension.h"

@interface CustomTabBarController () <CustomTabBarDelegate>
@property(nonatomic ,weak) CustomTabBar *customTabbar;
//主页控制器
@property(nonatomic, weak) HomeController *home;
//消息控制器
@property(nonatomic, weak) MessageController *message;
//发现控制器
@property(nonatomic, weak) DiscoverController *discover;
//我控制器
@property(nonatomic, weak) MeController *me;

@end

@implementation CustomTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化自定义TabBar
    [self setupCustomTabBar];
    
    HomeController *home=[[HomeController alloc] init];
//    home.tabBarItem.badgeValue=@"1";
    [self setupChildrenViewController:home title:@"首页" imageName:@"tabbar_home.png" selectedImageName:@"tabbar_home_selected.png"];
    MessageController *message=[[MessageController alloc] init];
    message.tabBarItem.badgeValue=@"0";
    [self setupChildrenViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected.png"];
    DiscoverController *discover=[[DiscoverController alloc] init];
    [self setupChildrenViewController:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected.png"];
    MeController *me=[[MeController alloc] init];
    [self setupChildrenViewController:me title:@"我" imageName:@"tabbar_profile.png" selectedImageName:@"tabbar_profile_selected.png"];
    self.home=home;
    self.message=message;
    self.discover=discover;
    self.me=me;
    //从服务器循环获取未读消息的数量
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(fetchUnreadMessageCount) userInfo:nil repeats:YES];
    //将循环获取消息数量放到后台线程的子线程取执行，默认是放到主线线程取调用，如果不这么做的化，当主线忙的时候，定时器就不会执行，
    //NSRunLoopCommonModes 是子线程
    //NSDefaultRunLoopMode 是主线程
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
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
    CustomNavigationController *nav=[[CustomNavigationController alloc] initWithRootViewController:controller];
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
    //为自定义tabbar设置代理
    customTabbar.delegate=self;
    [self.tabBar addSubview:customTabbar];
    self.customTabbar=customTabbar;
}

/**
 *  点击tabbar按钮时的代理方法
 */
-(void)tabBar:(CustomTabBar *)tabBar didSelectFromIndex:(int)from toIndex:(int)to{
    //切换TabBarController的子控制器
    self.selectedIndex=to;
    if (to==0) {
        //如果是首页清空tabItem上的徽标，自动下拉刷新微博
        [self.home beginRefreshStatus];
    }
}
/**
 *  点击加号按钮的代理方法
 */
-(void)tabBarPlusButtonClick:(CustomTabBar *)tabBar{
    ComposeController *composeVC=[[ComposeController alloc] init];
    CustomNavigationController *composeNav=[[CustomNavigationController alloc] initWithRootViewController:composeVC];
    [self presentViewController:composeNav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *从服务器获取未读消息的数量
 */
-(void) fetchUnreadMessageCount{
    Account *account=[Util getAccount];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"source"]=AppKey;
    parameters[@"access_token"]=account.access_token;
    parameters[@"uid"]=@(account.uid);
    
    [HttpTool getURL:UnreadMessageCountURL parameter:parameters success:^(id responseObject) {
        //获取未读消息数量，并设置徽标
        UnreadMessageCount *unreadCount=[UnreadMessageCount objectWithKeyValues:responseObject];
        self.home.tabBarItem.badgeValue=[NSString stringWithFormat:@"%d",unreadCount.status];
        self.message.tabBarItem.badgeValue=[NSString stringWithFormat:@"%d",unreadCount.messageCount];
        self.me.tabBarItem.badgeValue=[NSString stringWithFormat:@"%d",unreadCount.follower];
        //设置app图标右上角的未读消息数
        [UIApplication sharedApplication].applicationIconBadgeNumber=2;
        NSLog(@"%@",unreadCount);
    } faile:^(NSError *error) {
        
    }];
}

@end
