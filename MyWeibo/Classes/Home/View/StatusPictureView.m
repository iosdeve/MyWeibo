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
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@implementation StatusPictureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //为配图预设9张图片
        for (int i=0; i<9; i++) {
            StatusPictureCell *cell=[[StatusPictureCell alloc] init];
            cell.tag=i;
            //为单张图片添加点击事件
            [cell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPhoto:)]];
            [self addSubview:cell];
        }
    }
    return self;
}

/**
 *  点击微博配图后操作
 */
-(void) clickPhoto:(UIGestureRecognizer *) gesture{
    StatusPictureCell *cell=(StatusPictureCell *)gesture.view;
    int count=self.photos.count;
    NSMutableArray *photoList=[[NSMutableArray alloc] initWithCapacity:count];
    //用第三方框架集成图片浏览器
    for (int i=0; i<count; i++) {
        MJPhoto *photo=[[MJPhoto alloc] init];
        StatusPhoto *photoModel=self.photos[i];
        photo.srcImageView=cell;
        NSString *imagURL=[photoModel.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        photo.url=[NSURL URLWithString:imagURL];
        [photoList addObject:photo];
    }
   
    MJPhotoBrowser *photoBrowser=[[MJPhotoBrowser alloc] init];
    //设置图片数组
    photoBrowser.photos=photoList;
    //设置当要显示图片的索引
    photoBrowser.currentPhotoIndex=cell.tag;
    [photoBrowser show];
    NSLog(@"%d",cell.tag);
}

//设置配图数据
-(void)setPhotos:(NSArray *)photos{
    _photos=photos;
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
            if (photos.count==1) {
                //如果图片只有一张，尺寸时九宫格的尺寸的2倍
                cell.frame=CGRectMake(cellX, cellY, 2*StatusPictureWH, 2*StatusPictureWH);
                //设置图片显示模式为全部显示在view中
                cell.contentMode=UIViewContentModeScaleAspectFit;
            }else{
                cell.frame=CGRectMake(cellX, cellY, StatusPictureWH, StatusPictureWH);
                //设置图片显示模式为充满，超出的部分会剪掉
                cell.contentMode=UIViewContentModeScaleAspectFill;
            }
        }else{
            cell.hidden=YES;
        }
    }
}

//返回微博配图的宽高，根据图片的数量
+(CGSize) thisViewSize:(int) count{
    if (count==1) {
        //如果图片只有一张，直接返回一张的宽高
        return CGSizeMake(StatusPictureWH*2, StatusPictureWH*2);
    }
    int columns=count==4 ? 2 :3;
    int rows=(count+columns-1)/columns;
    CGFloat width=(columns-1)*(StatusPictureWH+StatusPictureMargin)+StatusPictureWH;
    CGFloat height=(rows-1)*(StatusPictureWH+StatusPictureMargin)+StatusPictureWH;
    return CGSizeMake(width, height);
}

@end
