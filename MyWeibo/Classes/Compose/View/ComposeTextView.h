//
//  ComposeTextView.h
//  MyWeibo
//
//  Created by ChenXin on 3/20/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  发表评论的textview

#import <UIKit/UIKit.h>

@interface ComposeTextView : UITextView
/**
 *  提示文字
 */
@property(nonatomic, copy) NSString *placeholder;
//微博图片
@property(nonatomic, copy) UIImage *picture;

@end
