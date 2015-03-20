//
//  ComposeToolBar.h
//  MyWeibo
//
//  Created by ChenXin on 3/20/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  自定义键盘上方的tool bar

#import <UIKit/UIKit.h>
@class ComposeToolBar;

typedef enum : NSUInteger {
    ComposeToolBarButtonTypeCamera,
    ComposeToolBarButtonTypeAlbum,
    ComposeToolBarButtonTypeEmoticon,
    ComposeToolBarButtonTypeMetion,
    ComposeToolBarButtonTypeTrend
} ComposeToolBarButtonType;

@protocol ComposeToolBarDelegate <NSObject>
//点击tool bar上的按钮的代理方法
-(void) composeToolBar:(ComposeToolBar *) toolBar clickButtonType:(ComposeToolBarButtonType) buttonType;

@end

@interface ComposeToolBar : UIView

@property(nonatomic, weak) id<ComposeToolBarDelegate> delegate;

@end
