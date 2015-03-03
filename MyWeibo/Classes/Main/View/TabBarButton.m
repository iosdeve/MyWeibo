//
//  TabBarButton.m
//  MyWeibo
//
//  Created by ChenXin on 3/2/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
// 自定义TabBarButton按钮

#import "TabBarButton.h"

#define TitleSelectedColor iOS7? MyColor(238, 122, 9) : MyColor(248, 161, 21)
#define TitleNormalColor iOS7? [UIColor blackColor] : [UIColor whiteColor]

#define ImageIconHRatio 0.6

@implementation TabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置item图标居中
        self.imageView.contentMode=UIViewContentModeCenter;
        //设置item文字大小
        self.titleLabel.font=[UIFont systemFontOfSize:12.0];
        //设置item文字居中对齐
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        //设置item文字被选中时的颜色
        [self setTitleColor:TitleSelectedColor forState:UIControlStateSelected];
        //设置item文字正常时的颜色
        [self setTitleColor:TitleNormalColor forState:UIControlStateNormal];
        //设置item被选中时的背景
        if (!iOS7) {
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        }
    }
    return self;
}
//覆盖父类方法，让按钮点击时不出现高亮效果
-(void)setHighlighted:(BOOL)highlighted{};

/**
 *  包含有TabBarItem，用来设置按钮图标和文字
 *
 *  @param item ;
 */
-(void)setItem:(UITabBarItem *)item{
    _item=item;
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
}

/**
 *  自定义图标frame
 */
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat x=0;
    CGFloat y=2;
    CGFloat w=contentRect.size.width;
    CGFloat h=contentRect.size.height*ImageIconHRatio;
    return CGRectMake(x, y, w, h);
}

/**
 *  自定义文字的frame
 */
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat x=0;
    CGFloat y=contentRect.size.height*ImageIconHRatio-3;
    CGFloat w=contentRect.size.width;
    CGFloat h=contentRect.size.height-y;
    return CGRectMake(x, y, w, h);
}

@end
