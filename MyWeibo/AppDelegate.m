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

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    /*
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *appVersion=[userDefault objectForKey:@"CFBundleVersion"];
    NSString *currentVersion=[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //判断沙盒里的版本和当前app版本是否一致，如果相同直接进入主界面，如果不同显示新特性界面
    if ([appVersion isEqualToString:currentVersion]) {
        //显示状态栏,项目默认设置不显示，便于lanchimage全屏显示
         application.statusBarHidden=NO;
        self.window.rootViewController=[[CustomTabBarController alloc] init];
    }else{
        //保持当前app版本到沙盒，并且调用synchronize立即保存
        [userDefault setObject:currentVersion forKey:@"CFBundleVersion"];
        [userDefault synchronize];
        NewFeatureController *newFeature=[[NewFeatureController alloc] init];
        self.window.rootViewController=newFeature;
    }
     */
    Account *account=[NSKeyedUnarchiver unarchiveObjectWithFile:[DocumentPath stringByAppendingPathComponent:@"account.data"]];
    NSLog(@"%@",account.access_token);
    LoginController *login=[[LoginController alloc] init];
    self.window.rootViewController=login;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

@end
