//
//  ComposePhotosView.h
//  MyWeibo
//
//  Created by ChenXin on 3/22/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  微博发送图片的配图

#import <UIKit/UIKit.h>

@interface ComposePhotosView : UIView
//为配图view添加一张图片
-(void) addImage:(UIImage *) image;
//选择的图片
-(NSArray *) getPhotos;

@end
