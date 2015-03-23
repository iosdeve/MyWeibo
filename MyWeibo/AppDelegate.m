//
//  AppDelegate.m
//  MyWeibo
//
//  Created by ChenXin on 3/2/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomTabBarController.h"
#import "NewFeatureController.h"
#import "LoginController.h"
#import "Account.h"
#import "Util.h"
#import "SDWebImageManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //先调用此方法，让［UIApplication sharedApplication］有返回值
    [self.window makeKeyAndVisible];
    //如果有保存的账号，并且未过期
    if ([Util getAccount]) {
        //显示window的根控制器，是显示新特性，还是进入主界面
        [Util chooseRootViewController];
    }else{
        LoginController *login=[[LoginController alloc] init];
        self.window.rootViewController=login;
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

//程序进入后台调用的方法
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //此方法是为app申请后台执行，但是app在后台运行所保持的时间并不确定
    //操作系统会更具情况回收系统资源，有可能此后台执行在一段时间后挂掉
    //当操作系统要干掉他后台执行的时候，会调用其中的block的方法
    [application beginBackgroundTaskWithExpirationHandler:^{
        //当操作系统要干掉他后台执行的时候，会调用其中的block的方法
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 *  当收到内存警告时，释放SDWebImage的内存
 *
 */
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end
