//
//  Util.h
//  MyWeibo
//
//  Created by ChenXin on 3/5/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  Account;

@interface Util : NSObject

/**
 *  保存account对象到文件
 */
+(void) saveAccount:(Account *) account;

/**
 *  从文件中获取保存到Account
 */
+(Account *) getAccount;

/**
 *  显示window的根控制器，是显示新特性，还是进入主界面
 */
+(void) chooseRootViewController;

@end
