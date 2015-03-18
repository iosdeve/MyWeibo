//
//  StatusPictureCell.m
//  MyWeibo
//
//  Created by ChenXin on 3/18/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import "StatusPictureCell.h"
#import "UIImageView+WebCache.h"
#import "StatusPhoto.h"

@interface StatusPictureCell ()
//gif图片下面到指示标记
@property(nonatomic,weak) UIImageView *gifView;

@end

@implementation StatusPictureCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //gif图片下面到指示标记
        UIImageView *gifView=[[UIImageView alloc] initWithImage:[UIImage imageWithName:@"timeline_image_gif"]];
        [self addSubview:gifView];
        self.gifView=gifView;
        //设置图片模式，看到整个图片
        self.contentMode=UIViewContentModeScaleAspectFit;
    }
    return self;
}

//设置微博到单张图片
-(void)setPhoto:(StatusPhoto *)photo{
    self.gifView.hidden=![photo.thumbnail_pic hasSuffix:@"gif"];
    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //设置gif标记到定位点，在最右下方
    self.gifView.layer.anchorPoint=CGPointMake(1.0, 1.0);
    //设置gif的位置等于父控件的宽高，这样就可以让gif小标记紧靠在右下角
    self.gifView.layer.position=CGPointMake(self.frame.size.width, self.frame.size.height);
}

@end
