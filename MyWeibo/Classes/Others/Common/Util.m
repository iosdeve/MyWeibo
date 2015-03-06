//
//  Util.m
//  MyWeibo
//
//  Created by ChenXin on 3/5/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import "Util.h"
#import "Account.h"
#import "NewFeatureController.h"
#import "CustomTabBarController.h"

#define ArchiveAccountPath [DocumentPath stringByAppendingPathComponent:@"account.data"]

@implementation Util

/**
 *  保存account对象到文件
 */
+(void) saveAccount:(Account *) account{
    account.saveTime=[NSDate date];
    [NSKeyedArchiver archiveRootObject:account toFile:ArchiveAccountPath];
}

/**
 *  从文件中获取保存到Account
 */
+(Account *) getAccount{
    Account *account=[NSKeyedUnarchiver unarchiveObjectWithFile:ArchiveAccountPath];
    NSDate *now=[NSDate date];
    //计算出token过期时间
    NSDate *expireDate=[account.saveTime dateByAddingTimeInterval:account.expires_in];
    //如果过期时间大于现在时间，返回account，否则返回null
    if ([expireDate compare:now]==NSOrderedDescending) {
        return account;
    }
    return nil;
}

/**
 *  显示window的根控制器，是显示新特性，还是进入主界面
 */
+(void) chooseRootViewController{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *appVersion=[userDefault objectForKey:@"CFBundleVersion"];
    NSString *currentVersion=[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //判断沙盒里的版本和当前app版本是否一致，如果相同直接进入主界面，如果不同显示新特性界面
    if ([appVersion isEqualToString:currentVersion]) {
        //显示状态栏,项目默认设置不显示，便于lanchimage全屏显示
        [UIApplication sharedApplication].statusBarHidden=NO;
        [UIApplication sharedApplication].keyWindow.rootViewController=[[CustomTabBarController alloc] init];
    }else{
        //保持当前app版本到沙盒，并且调用synchronize立即保存
        [userDefault setObject:currentVersion forKey:@"CFBundleVersion"];
        [userDefault synchronize];
        NewFeatureController *newFeature=[[NewFeatureController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController=newFeature;
    }

}

@end
