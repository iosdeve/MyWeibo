//
//  CustomTabBar.m
//  MyWeibo
//
//  Created by ChenXin on 3/2/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//自定义TabBar

#import "CustomTabBar.h"

@implementation CustomTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/**
 *  根据UITabBarItem添加自定义item
 *
 *  @param item 参照的UITabBarItem
 */
-(void)addBarButtionWithItem:(UITabBarItem *)item{
    UIButton *button=[[UIButton alloc] init];
    [button setTitle:item.title forState:UIControlStateNormal];
    [button setImage:item.image forState:UIControlStateNormal];
    [button setImage:item.selectedImage forState:UIControlStateSelected];
    [self addSubview:button];
}

/**
 * 调整每个BarButton的Frame位置
 * 让其平均分配
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w=self.frame.size.width/self.subviews.count;
    CGFloat h=self.frame.size.height;
    CGFloat y=0;
    for (int i=0; i<self.subviews.count; i++) {
        CGFloat x=i*w;
        UIButton *button=self.subviews[i];
        button.frame=CGRectMake(x, y, w, h);
    }
}

@end
