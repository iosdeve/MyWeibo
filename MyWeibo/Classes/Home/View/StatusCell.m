//
//  StatusCell.m
//  MyWeibo
//
//  Created by ChenXin on 3/9/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  自定义微博展示的UITableViewCell

#import "StatusCell.h"
#import "StatusFrame.h"
#import "Status.h"
#import "UIImageView+WebCache.h"
#import "User.h"
#import "StatusToolBar.h"
#import "StatusPhoto.h"
#import "StatusPictureView.h"

@interface StatusCell ()
//原创微博的背景图片
@property(nonatomic,weak) UIImageView *statusBackground;
//原创微博用户图标
@property(nonatomic,weak) UIImageView *userIcon;
//原创微博的VIP图片
@property(nonatomic,weak) UIImageView *vipIcon;
//原创微博的配图
@property(nonatomic,weak) StatusPictureView *photo;
//原创微博的用户昵称
@property(nonatomic,weak) UILabel *userText;
//原创微博的发布时间
@property(nonatomic,weak) UILabel *createTime;
//原创微博的发布来源
@property(nonatomic,weak) UILabel *sourceText;
//原创微博的内容
@property(nonatomic,weak) UILabel *statusText;

//转发微博的背景图片
@property(nonatomic,weak) UIImageView *retweetStatusBackground;
//转发微博的用户昵称
@property(nonatomic,weak) UILabel *retweetUserText;
//转发微博的内容
@property(nonatomic,weak) UILabel *retweetStatusText;
//转发微博的配图
@property(nonatomic,weak) StatusPictureView *retweetPhoto;

//微博底部的工具条
@property(nonatomic, weak) StatusToolBar *toolBar;

@end

@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupStatusSubViews];
        [self setupRetweetStatusSubViews];
        [self setupBootomBar];
        //设置选中单元格的背景颜色为空，改变默认的选中背景变蓝
        self.selectedBackgroundView=[[UIView alloc] init];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x=GlobalCellMargin;
    frame.size.width=frame.size.width-2*GlobalCellMargin;
    [super setFrame:frame];
    
}

-(void)setStatusFrame:(StatusFrame *)statusFrame{
    _statusFrame=statusFrame;
    [self setupStatusSubViewsData];
    [self setupRetweetStatusSubViewsData];
    [self setupBootomBarData];
}

/**
 *  设置原创微博的视图
 */
-(void) setupStatusSubViews{
    //背景图片
    UIImageView *statusBackground=[[UIImageView alloc] init];
    statusBackground.image=[UIImage imageResize:@"timeline_card_top_background"];
    statusBackground.highlightedImage=[UIImage imageResize:@"timeline_card_top_background_highlighted"];
    [self.contentView addSubview:statusBackground];
    self.statusBackground=statusBackground;
    //原创微博用户图标
    UIImageView *userIcon=[[UIImageView alloc] init];
    [self.statusBackground addSubview:userIcon];
    self.userIcon=userIcon;
    //原创微博的VIP图片
    UIImageView *vipIcon=[[UIImageView alloc] init];
    vipIcon.contentMode=UIViewContentModeCenter;
    [self.statusBackground addSubview:vipIcon];
    self.vipIcon=vipIcon;
    //原创微博的配图
    StatusPictureView *photo=[[StatusPictureView alloc] init];
    [self.statusBackground addSubview:photo];
    self.photo=photo;
    //原创微博的用户昵称
    UILabel *userText=[[UILabel alloc] init];
    userText.font=CellNickNameFont;
    userText.backgroundColor=[UIColor clearColor];;
    [self.statusBackground addSubview:userText];
    self.userText=userText;
    //原创微博的发布时间
    UILabel *createTime=[[UILabel alloc] init];
    createTime.backgroundColor=[UIColor clearColor];
    createTime.font=CellSourceCreateFont;
    createTime.textColor=CellCreateColor;
    [self.statusBackground addSubview:createTime];
    self.createTime=createTime;
    //原创微博的发布来源
    UILabel *sourceText=[[UILabel alloc] init];
    sourceText.backgroundColor=[UIColor clearColor];
    sourceText.font=CellSourceCreateFont;
    sourceText.textColor=CellSourceColor;
    [self.statusBackground addSubview:sourceText];
    self.sourceText=sourceText;
    //原创微博的内容
    UILabel *statusText=[[UILabel alloc] init];
    statusText.backgroundColor=[UIColor clearColor];
    statusText.font=CellStatusTextFont;
    statusText.numberOfLines=0;
    [self.statusBackground addSubview:statusText];
    self.statusText=statusText;
    
}

/**
 *  设置原创微博的数据
 */
-(void) setupStatusSubViewsData{
    //背景图片
    self.statusBackground.frame=self.statusFrame.statusBackgroundF;
    //原创微博用户图标
    [self.userIcon setImageWithURL:[NSURL URLWithString:self.statusFrame.status.user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.userIcon.frame=self.statusFrame.userIconF;
    //原创微博的VIP图片
    if (self.statusFrame.status.user.isVip) {
        self.vipIcon.hidden=NO;
        self.vipIcon.image=[UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d",self.statusFrame.status.user.mbrank]];
        self.vipIcon.frame=self.statusFrame.vipIconF;
    }else{
        self.vipIcon.hidden=YES;
    }
    if (self.statusFrame.status.pic_urls.count) {
        //原创微博的配图
        self.photo.photos=self.statusFrame.status.pic_urls;
        self.photo.hidden=NO;
        self.photo.frame=self.statusFrame.photoF;
    }else{
        self.photo.hidden=YES;
    }
    
    //原创微博的用户昵称
    self.userText.text=self.statusFrame.status.user.name;
    self.userText.frame=self.statusFrame.userTextF;
    //原创微博的发布时间
    self.createTime.text=self.statusFrame.status.created_at;
    //原创微博的发布时间的frame
    CGFloat createTimeX=CGRectGetMaxX(self.statusFrame.userIconF)+GlobalCellMargin;
    CGFloat createTimeY=CGRectGetMaxY(self.statusFrame.userTextF)+GlobalCellMargin;
    CGSize createTimeSize=[self.statusFrame.status.created_at sizeWithFont:CellSourceCreateFont];
    self.statusFrame.createTimeF=(CGRect){{createTimeX,createTimeY}, createTimeSize};
    self.createTime.frame=self.statusFrame.createTimeF;
    //原创微博的发布来源
    self.sourceText.text=self.statusFrame.status.source;
    //原创微博的发布来源的frame
    CGFloat sourceTextX=CGRectGetMaxX(self.statusFrame.createTimeF)+GlobalCellMargin;
    CGFloat sourceTextY=self.statusFrame.createTimeF.origin.y;
    CGSize sourceTextSize=[self.statusFrame.status.source sizeWithFont:CellSourceCreateFont];
    self.statusFrame.sourceTextF=(CGRect){{sourceTextX, sourceTextY},sourceTextSize};
    self.sourceText.frame= self.statusFrame.sourceTextF;
    //原创微博的内容
    self.statusText.text=self.statusFrame.status.text;
    self.statusText.frame=self.statusFrame.statusTextF;
    
}
/**
 *  设置转发微博的视图
 */
-(void) setupRetweetStatusSubViews{
    //转发微博的背景图片
    UIImageView *retweetStatusBackground=[[UIImageView alloc] init];
    retweetStatusBackground.image=[UIImage imageResize:@"timeline_retweet_background" left:0.9 top:0.5];
    [self.statusBackground addSubview:retweetStatusBackground];
    self.retweetStatusBackground=retweetStatusBackground;
    //转发微博的用户昵称
    UILabel *retweetUserText=[[UILabel alloc] init];
    retweetUserText.backgroundColor=[UIColor clearColor];
    retweetUserText.font=CellNickNameFont;
    retweetUserText.textColor=CellRetweetNickNameColor;
    [self.retweetStatusBackground addSubview:retweetUserText];
    self.retweetUserText=retweetUserText;
    //转发微博的内容
    UILabel *retweetStatusText=[[UILabel alloc] init];
    retweetStatusText.font=CellStatusTextFont;
    retweetStatusText.numberOfLines=0;
    retweetStatusText.backgroundColor=[UIColor clearColor];
    [self.retweetStatusBackground addSubview:retweetStatusText];
    self.retweetStatusText=retweetStatusText;
    //转发微博的配图
    StatusPictureView *retweetPhoto=[[StatusPictureView alloc] init];
    [self.retweetStatusBackground addSubview:retweetPhoto];
    self.retweetPhoto=retweetPhoto;
}

/**
 *  设置转发微博的视图数据内容
 */
-(void) setupRetweetStatusSubViewsData{
    if (self.statusFrame.status.retweeted_status) {
        self.retweetStatusBackground.hidden=NO;
        //转发微博的背景图片
        self.retweetStatusBackground.frame=self.statusFrame.retweetStatusBackgroundF;
        //转发微博的用户昵称
        NSString *retweetNickName=[NSString stringWithFormat:@"@%@",self.statusFrame.status.retweeted_status.user.name];
        self.retweetUserText.text=retweetNickName;
        self.retweetUserText.frame=self.statusFrame.retweetUserTextF;
        //转发微博的内容
        self.retweetStatusText.text=self.statusFrame.status.retweeted_status.text;
        self.retweetStatusText.frame=self.statusFrame.retweetStatusTextF;
        //转发微博的配图
        if (self.statusFrame.status.retweeted_status.pic_urls.count) {
            self.retweetPhoto.hidden=NO;
            self.retweetPhoto.photos=elf.statusFrame.status.retweeted_status.pic_urls;
            self.retweetPhoto.frame=self.statusFrame.retweetPhotoF;
        }else{
            self.retweetPhoto.hidden=YES;
        }
    }else{
        self.retweetStatusBackground.hidden=YES;
    }
}

/**
 *  设置微博底部工具条
 */
-(void) setupBootomBar{
    StatusToolBar *toolBar=[[StatusToolBar alloc] init];
    toolBar.image=[UIImage imageResize:@"timeline_card_bottom_background"];
    toolBar.highlightedImage=[UIImage imageResize:@"timeline_card_bottom_background_highlighted"];
    [self.contentView addSubview:toolBar];
    self.toolBar=toolBar;
}

/**
 *  设置微博底部工具条的数据
 */
-(void) setupBootomBarData{
    self.toolBar.status=self.statusFrame.status;
    self.toolBar.frame=self.statusFrame.toolBarF;
}

@end
