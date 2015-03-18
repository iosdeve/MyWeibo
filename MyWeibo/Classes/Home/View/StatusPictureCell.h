//
//  StatusPictureCell.h
//  MyWeibo
//
//  Created by ChenXin on 3/18/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  微博单张配图

#import <UIKit/UIKit.h>
@class  StatusPhoto;

@interface StatusPictureCell : UIImageView
//微博配图模型
@property(nonatomic, strong) StatusPhoto *photo;

@end
