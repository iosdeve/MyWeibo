//
//  SearhField.m
//  MyWeibo
//
//  Created by ChenXin on 3/4/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
// 自定义搜索框

#import "SearhField.h"

@implementation SearhField

//快速创建对象
+(SearhField *) searchField{
    return [[SearhField alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clearButtonMode=UITextFieldViewModeAlways;
        self.font=[UIFont systemFontOfSize:13];
        // 设置搜索框左边放大镜图标
        UIImageView *leftImageView=[[UIImageView alloc] initWithImage:[UIImage imageWithName:@""]];
        leftImageView.frame=CGRectMake(0, 0, 30, 30);
        self.leftView=leftImageView;
        self.leftView.contentMode=UIViewContentModeCenter;
        //设置提示占位文字的颜色
        NSMutableDictionary *attribute=[NSMutableDictionary dictionary];
        attribute[NSForegroundColorAttributeName]=[UIColor grayColor];
        self.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"搜索" attributes:nil];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //设置左边图片frame
    self.leftView.frame=CGRectMake(0, 0, 30, self.frame.size.height);
}

@end
