//
//  StatusPicture.h
//  MyWeibo
//
//  Created by ChenXin on 3/18/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  微博九宫格配图

#import <UIKit/UIKit.h>

@interface StatusPictureView : UIView
//图片url数组
@property(nonatomic, strong) NSArray *photos;

//返回微博配图的宽高，根据图片的数量
+(CGSize) thisViewSize:(int) count;

@end
