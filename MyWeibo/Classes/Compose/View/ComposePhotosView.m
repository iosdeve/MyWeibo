//
//  ComposePhotosView.m
//  MyWeibo
//
//  Created by ChenXin on 3/22/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  微博发送图片的配图

#import "ComposePhotosView.h"
#define ImageHW 50.0
#define ImageMargin 10
#define ImageColumn 5

@interface ComposePhotosView ()
//用来记录选择的图片
@property(nonatomic, strong) NSMutableArray *images;

@end

@implementation ComposePhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addImageViews];
    }
    return self;
}

//添加预设好九张图片
-(void) addImageViews{
    for (int i=0; i<9; i++) {
        UIImageView *imageView=[[UIImageView alloc] init];
        [self addSubview:imageView];
    }
}
//预设好九张图片的位置
-(void)layoutSubviews{
    [super layoutSubviews];
    int count=self.subviews.count;
    for (int i=0; i<count; i++) {
        CGFloat x=(i%ImageColumn)*(ImageHW+ImageMargin);
        CGFloat y=(i/ImageColumn)*(ImageHW+ImageMargin);
        UIImageView *imageView=self.subviews[i];
        imageView.frame=CGRectMake(x, y, ImageHW, ImageHW);
        NSLog(@"%@",NSStringFromCGRect(imageView.frame));
    }
    
}

//选择的图片
-(NSMutableArray *)images{
    if (_images==nil) {
        _images=[NSMutableArray array];
    }
    return _images;
}
//为配图view添加一张图片
-(void) addImage:(UIImage *) image{
    int count=self.images.count;
    UIImageView *imageView=self.subviews[count];
    imageView.image=image;
    [self.images addObject:image];
}
//选择的图片
-(NSArray *) getPhotos{
    return self.images;
}

@end
