//
//  StatusToolBar.h
//  MyWeibo
//
//  Created by ChenXin on 3/17/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  自定义微博底部工具栏

#import <UIKit/UIKit.h>
#import "Status.h"

@interface StatusToolBar : UIImageView

/**
 *  设置底部工具栏一些数量到显示
 */
@property(nonatomic,strong) Status *status;

@end
