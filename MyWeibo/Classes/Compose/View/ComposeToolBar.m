//
//  ComposeToolBar.m
//  MyWeibo
//
//  Created by ChenXin on 3/20/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  自定义键盘上方的tool bar

#import "ComposeToolBar.h"

@implementation ComposeToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置view靠底部
        self.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
        //设置toolbar的背景颜色
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        //添加按钮到toolbar中
        [self addImageBtnItem:@"compose_camerabutton_background"].tag=ComposeToolBarButtonTypeCamera;
        [self addImageBtnItem:@"compose_toolbar_picture"].tag=ComposeToolBarButtonTypeAlbum;
        [self addImageBtnItem:@"compose_emoticonbutton_background"].tag=ComposeToolBarButtonTypeEmoticon;
        [self addImageBtnItem:@"compose_mentionbutton_background"].tag=ComposeToolBarButtonTypeMetion;
        [self addImageBtnItem:@"compose_trendbutton_background"].tag=ComposeToolBarButtonTypeTrend;
    }
    return self;
}
/**
 *添加按钮到toolbar中
 *
 *  @param image 按钮的图标
 *
 */
-(UIButton *) addImageBtnItem:(NSString *) image{
    UIButton *button=[[UIButton alloc] init];
    [button setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:[image stringByAppendingString:@"_highlighted"]] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(imageBtnItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}

//点击按钮后执行的方法，并执行代理方法
-(void) imageBtnItemClick:(UIButton *) button{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:clickButtonType:)]) {
        [self.delegate composeToolBar:self clickButtonType:button.tag];
    }
}

-(void) layoutSubviews{
    [super layoutSubviews];
    CGFloat width=self.frame.size.width/self.subviews.count;
    CGFloat height=44.0;
    for (int i=0; i<self.subviews.count; i++) {
        UIButton *button=self.subviews[i];
        button.frame=CGRectMake(i*width, 0, width, height);
    }
}

@end
