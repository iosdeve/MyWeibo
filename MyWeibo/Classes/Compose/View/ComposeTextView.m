//
//  ComposeTextView.m
//  MyWeibo
//
//  Created by ChenXin on 3/20/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  发表评论的textview

#import "ComposeTextView.h"

@interface ComposeTextView () <UITextViewDelegate>
//提醒文字的view
@property(nonatomic, weak) UILabel *placeHolderLabel;
//微博配图的view
@property(nonatomic, weak) UIImageView *pictureView;

@end

@implementation ComposeTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加label作为提示view
        UILabel *placeHolderLabel=[[UILabel alloc] init];
        //默认不显示
        placeHolderLabel.hidden=YES;
        placeHolderLabel.textColor=[UIColor lightGrayColor];
        //允许多行显示
        placeHolderLabel.numberOfLines=0;
        //插入到父控件到底部
        [self insertSubview:placeHolderLabel atIndex:0];
        self.placeHolderLabel=placeHolderLabel;
        //设置textview默认可以滚动
        self.alwaysBounceVertical=YES;
        self.delegate=self;
        //添加textview文本改变到通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentTextChanged) name:UITextViewTextDidChangeNotification object:self];
        
        UIImageView *pictView=[[UIImageView alloc] init];
        pictView.frame=CGRectMake(10, 100, 50, 50);
        [self addSubview:pictView];
        self.pictureView=pictView;
    }
    return self;
}
//设置提示文字
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder=[placeholder copy];
    self.placeHolderLabel.text=placeholder;
    //有提示文字则显示
    if (placeholder.length>0) {
        self.placeHolderLabel.hidden=NO;
    }else{
        self.placeHolderLabel.hidden=YES;
    }
}
//设置提示文字到frame
-(void)layoutSubviews{
    [super layoutSubviews];
    //设置提示文字距离父控件有点间距
    CGFloat x=5.0;
    CGFloat y=7.0;
    CGSize labelSize=[self.placeholder sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width-2*x, self.frame.size.height-2*y)];
    //设置提示控件到颜色
    self.placeHolderLabel.font=self.font;
    self.placeHolderLabel.frame=CGRectMake(x, y, labelSize.width, labelSize.height);
}
//接收textview文本改变到通知
-(void) contentTextChanged{
    if (self.text.length>0) {
        self.placeHolderLabel.hidden=YES;
    }else{
        self.placeHolderLabel.hidden=NO;
    }
}

/**
 *  当滚动textview的时候隐藏键盘
 *
 *  @param scrollView <#scrollView description#>
 *  @param decelerate <#decelerate description#>
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"scrollViewDidEndDragging");
    [self resignFirstResponder];
}
//设置微博的图片
-(void)setPicture:(UIImage *)picture{
    _picture=picture;
    self.pictureView.image=picture;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
