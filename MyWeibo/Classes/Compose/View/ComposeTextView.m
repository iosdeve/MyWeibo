//
//  ComposeTextView.m
//  MyWeibo
//
//  Created by ChenXin on 3/20/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  发表评论的textview

#import "ComposeTextView.h"

@interface ComposeTextView ()

@property(nonatomic, weak) UILabel *placeHolderLabel;

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
        //添加textview文本改变到通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentTextChanged) name:UITextViewTextDidChangeNotification object:self];
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

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
