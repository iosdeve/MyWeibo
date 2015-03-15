//
//  StatusFrame.m
//  MyWeibo
//
//  Created by ChenXin on 3/15/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import "StatusFrame.h"
#import "Status.h"
#import "User.h"

@implementation StatusFrame

/**
 *  设置微博数据，用来计算各个subviews的Frame
 */
-(void)setStatus:(Status *)status{
    _status=status;
    //整个cell的宽度
    //原创微博的背景图片
    CGFloat cellW=[UIScreen mainScreen].bounds.size.width;
    CGFloat statusBackgroundX=0;
    CGFloat statusBackgroundY=0;
    CGFloat statusBackgroundW=cellW;
    CGFloat statusBackgroundH=0;
    //原创微博用户图标
    CGFloat userIconX=GlobalCellMargin;
    CGFloat userIconY=GlobalCellMargin;
    CGFloat userIconWH=35.0;
    _userIconF=CGRectMake(userIconX, userIconY, userIconWH, userIconWH);
    //原创微博的用户昵称
    CGFloat userTextX=CGRectGetMaxX(_userIconF)+GlobalCellMargin;
    CGFloat userTextY=userIconY;
    CGSize userTextSize=[status.user.name sizeWithFont:CellNickNameFont];
    _userTextF=(CGRect){{userTextX,userTextY},userTextSize};
    if (status.user.isVip) {
        //原创微博的VIP图片
        CGFloat vipIconX=CGRectGetMaxX(_userTextF)+GlobalCellMargin;
        CGFloat vipIconY=GlobalCellMargin;
        CGFloat vipIconWH=14.0;
        _vipIconF=CGRectMake(vipIconX, vipIconY, vipIconWH, vipIconWH);
    }
    //原创微博的发布时间
    CGFloat createTimeX=userTextX;
    CGFloat createTimeY=CGRectGetMaxY(_userTextF)+GlobalCellMargin;
    CGSize createTimeSize=[status.created_at sizeWithFont:CellSourceCreateFont];
    _createTimeF=(CGRect){{createTimeX,createTimeY}, createTimeSize};
    //原创微博的发布来源
    CGFloat sourceTextX=CGRectGetMaxX(_createTimeF)+GlobalCellMargin;
    CGFloat sourceTextY=createTimeY;
    CGSize sourceTextSize=[status.source sizeWithFont:CellSourceCreateFont];
    _sourceTextF=(CGRect){{sourceTextX, sourceTextY},sourceTextSize};
    //原创微博的内容
    CGFloat statusTextX=userIconX;
    CGFloat statusTextY=CGRectGetMaxY(_userIconF)+GlobalCellMargin;
    CGSize statusTextSize=[status.text sizeWithFont:CellStatusTextFont constrainedToSize:CGSizeMake(cellW-2*GlobalCellMargin, MAXFLOAT)];
    NSLog(@"%@--%@",NSStringFromCGSize(statusTextSize),status.text);
    _statusTextF=(CGRect){{statusTextX,statusTextY},statusTextSize};
    if (status.thumbnail_pic) {
        //原创微博的配图
        CGFloat photoX=userIconX;
        CGFloat photoY=CGRectGetMaxY(_statusTextF)+GlobalCellMargin;
        CGFloat photoWH=70.0;
        _photoF=CGRectMake(photoX, photoY, photoWH, photoWH);
    }
    if (status.retweeted_status) {
        //转发微博的背景图片
        CGFloat retweetStatusBackgroundX=userIconX;
        CGFloat retweetStatusBackgroundY=CGRectGetMaxY(_statusTextF)+GlobalCellMargin;
        CGFloat retweetStatusBackgroundW=statusBackgroundW-2*GlobalCellMargin;
        CGFloat retweetStatusBackgroundH=0;
        //转发微博的用户昵称
        CGFloat retweetUserTextX=GlobalCellMargin;
        CGFloat retweetUserTextY=GlobalCellMargin;
        CGSize retweetUserTextSize=[status.retweeted_status.user.name sizeWithFont:CellNickNameFont];
        _retweetUserTextF=(CGRect){{retweetUserTextX,retweetUserTextY},retweetUserTextSize};
        //转发微博的内容
        CGFloat retweetStatusTextX=retweetUserTextX;
        CGFloat retweetStatusTextY=CGRectGetMaxY(_retweetUserTextF)+GlobalCellMargin;
        CGFloat retweetStatusTextW=retweetStatusBackgroundW-2*GlobalCellMargin;
        CGSize retweetStatusTextSize=[status.retweeted_status.text sizeWithFont:CellStatusTextFont constrainedToSize:CGSizeMake(retweetStatusTextW-2*GlobalCellMargin, MAXFLOAT)];
        _retweetStatusTextF=(CGRect){{retweetStatusTextX,retweetStatusTextY},retweetStatusTextSize};
        if (status.retweeted_status.thumbnail_pic) {
            //转发微博的配图
            CGFloat retweetPhotoX=retweetStatusTextX;
            CGFloat retweetPhotoY=CGRectGetMaxY(_retweetStatusTextF)+GlobalCellMargin;
            CGFloat retweetPhotoWH=70.0;
            _retweetPhotoF=CGRectMake(retweetPhotoX,retweetPhotoY,retweetPhotoWH,retweetPhotoWH);
            retweetStatusBackgroundH=CGRectGetMaxY(_retweetPhotoF)+GlobalCellMargin;
        }else{
            retweetStatusBackgroundH=CGRectGetMaxY(_retweetStatusTextF)+GlobalCellMargin;
        }
        _retweetStatusBackgroundF=CGRectMake(retweetStatusBackgroundX, retweetStatusBackgroundY, retweetStatusBackgroundW, retweetStatusBackgroundH);
        statusBackgroundH=CGRectGetMaxY(_retweetStatusBackgroundF)+GlobalCellMargin;
    }else{
        if (status.thumbnail_pic) {
            statusBackgroundH=CGRectGetMaxY(_photoF)+GlobalCellMargin;
        }else{
            statusBackgroundH=CGRectGetMaxY(_statusTextF)+GlobalCellMargin;
        }
    }
    _statusBackgroundF=CGRectMake(statusBackgroundX, statusBackgroundY, statusBackgroundW, statusBackgroundH);
    _cellHight=statusBackgroundH+GlobalCellMargin;
}

@end
