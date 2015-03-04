//
//  ButtonWithRightIcon.m
//  MyWeibo
//
//  Created by ChenXin on 3/4/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//自定义button，图标靠右对齐

#import "ButtonWithRightIcon.h"

@implementation ButtonWithRightIcon

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置当高亮状态时候不调整image
        self.adjustsImageWhenHighlighted=NO;
        self.titleLabel.font=[UIFont boldSystemFontOfSize:18];
        self.titleLabel.textAlignment=NSTextAlignmentRight;
        self.imageView.contentMode=UIViewContentModeCenter;
        //设置按钮的背景图片
        [self setBackgroundImage:[UIImage imageResize:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}
/**
 *  根据文字自动调整按钮的宽度
 */
-(void)setFrame:(CGRect)frame{
    CGSize size=[self.titleLabel.text sizeWithFont:self.titleLabel.font];
    CGFloat w=size.width+(self.currentImage.size.width+5)+5;
    CGFloat h=frame.size.height;
    frame.size.width=w;
    frame.size.height=h;
    [super setFrame:frame];
}

/**
 *  自定义图标frame
 */
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat x=contentRect.size.width-(self.currentImage.size.width+5);
    CGFloat y=0;
    CGFloat w=self.currentImage.size.width+5;
    CGFloat h=contentRect.size.height;
    return CGRectMake(x, y, w, h);
}

/**
 *  自定义文字的frame
 */
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat x=0;
    CGFloat y=0;
    CGFloat w=contentRect.size.width-(self.currentImage.size.width+5);
    CGFloat h=contentRect.size.height;
    return CGRectMake(x, y, w, h);
}


@end
