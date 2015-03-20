//
//  ComposeToolBar.m
//  MyWeibo
//
//  Created by ChenXin on 3/20/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import "ComposeToolBar.h"

@implementation ComposeToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        [self addImageBtnItem:@"compose_camerabutton_background"].tag=ComposeToolBarButtonTypeCamera;
        [self addImageBtnItem:@"compose_toolbar_picture"].tag=ComposeToolBarButtonTypeAlbum;
        [self addImageBtnItem:@"compose_emoticonbutton_background"].tag=ComposeToolBarButtonTypeEmoticon;
        [self addImageBtnItem:@"compose_mentionbutton_background"].tag=ComposeToolBarButtonTypeMetion;
        [self addImageBtnItem:@"compose_trendbutton_background"].tag=ComposeToolBarButtonTypeTrend;
    }
    return self;
}

-(UIButton *) addImageBtnItem:(NSString *) image{
    UIButton *button=[[UIButton alloc] init];
    [button setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:[image stringByAppendingString:@"_highlighted"]] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(imageBtnItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}

-(void) imageBtnItemClick:(UIButton *) button{
    
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
