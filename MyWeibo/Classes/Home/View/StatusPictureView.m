//
//  StatusPicture.m
//  MyWeibo
//
//  Created by ChenXin on 3/18/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  微博九宫格配图

#import "StatusPictureView.h"
#import "StatusPhoto.h"
#import "StatusPictureCell.h"

@implementation StatusPictureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //为配图预设9张图片
        for (int i=0; i<9; i++) {
            StatusPictureCell *cell=[[StatusPictureCell alloc] init];
            [self addSubview:cell];
        }
    }
    return self;
}
//设置配图数据
-(void)setPhotos:(NSArray *)photos{
    for (int i=0; i<self.subviews.count; i++) {
        StatusPictureCell *cell=self.subviews[i];
        //如果当前的图片的索引小于图片数据数量，则设置图片
        if (i<photos.count) {
            cell.photo=photos[i];
            cell.hidden=NO;
            //计算图片的frame
            int columns=photos.count==4 ? 2 :3;
            CGFloat cellX=(i%columns)*(StatusPictureWH+StatusPictureMargin);
            CGFloat cellY=(i/columns)*(StatusPictureWH+StatusPictureMargin);
            cell.frame=CGRectMake(cellX, cellY, StatusPictureWH, StatusPictureWH);
        }else{
            cell.hidden=YES;
        }
    }
}

//返回微博配图的宽高，根据图片的数量
+(CGSize) thisViewSize:(int) count{
    int columns=count==4 ? 2 :3;
    int rows=(count+columns-1)/columns;
    CGFloat width=(columns-1)*(StatusPictureWH+StatusPictureMargin)+StatusPictureWH;
    CGFloat height=(rows-1)*(StatusPictureWH+StatusPictureMargin)+StatusPictureWH;
    return CGSizeMake(width, height);
}

@end
