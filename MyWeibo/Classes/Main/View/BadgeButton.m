//
//  BadgeButton.m
//  MyWeibo
//
//  Created by ChenXin on 3/3/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  徽标按钮，

#import "BadgeButton.h"

@implementation BadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置不可被点击
        self.userInteractionEnabled=NO;
        //设置字体大小
        self.titleLabel.font=[UIFont systemFontOfSize:11];
        //设置button的背景颜色
        [self setBackgroundImage:[UIImage imageResize:@"main_badge"] forState:UIControlStateNormal];
        //默认徽标不显示
        self.hidden=YES;
        
    }
    return self;
}

/**
 *  设置徽标
 *
 *  @param badgeValue 要显示的徽标
 */
-(void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue=[badgeValue copy];
    if (badgeValue.length>0) {
        //如果有值，设置徽标显示
        self.hidden=NO;
        //设置显示的值
        [self setTitle:badgeValue forState:UIControlStateNormal];
        //更具字符串长度来设置徽标按钮的宽度
        CGSize size=[badgeValue sizeWithFont:self.titleLabel.font];
        UIImage *badgeImage=[UIImage imageWithName:@"main_badge"];
        //如果字符串长度大于1，取计算后的宽度＋10
        CGRect f=self.frame;
        f.size.height=badgeImage.size.height;
        if (badgeValue.length>1) {
            f.size.width=size.width+10;
        }else{
            //如果徽标时1位长度，让其长宽等于图表的长宽
            f.size.width=badgeImage.size.width;
        }
        self.frame=f;
        
    }else{
        //如果没有值，隐藏按钮
        self.hidden=YES;
    }
    
}

@end
