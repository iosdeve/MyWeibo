//
//  HomeController.h
//  MyWeibo
//
//  Created by ChenXin on 3/2/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeController : UITableViewController

/**
 *  开始刷新，用于外部调用
 */
-(void) beginRefreshStatus;

@end
