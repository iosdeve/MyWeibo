//
//  StatusCell.m
//  MyWeibo
//
//  Created by ChenXin on 3/9/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  自定义微博展示的UITableViewCell

#import "StatusCell.h"

@interface StatusCell ()
//原创微博的背景图片
@property(nonatomic,weak) UIImageView *statusBackground;
//原创微博用户图标
@property(nonatomic,weak) UIImageView *userIcon;
//原创微博的VIP图片
@property(nonatomic,weak) UIImageView *vipIcon;
//原创微博的配图
@property(nonatomic,weak) UIImageView *photo;
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
@property(nonatomic,weak) UIImageView *retweetPhoto;

@end

@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

/**
 *  设置原创微博的视图
 */
-(void) setupStatusSubViews{
    //背景图片
    UIImageView *statusBackground=[[UIImageView alloc] init];
    [self.contentView addSubview:statusBackground];
    self.statusBackground=statusBackground;
    
    //原创微博用户图标
    UIImageView *userIcon=[[UIImageView alloc] init];
    [self.statusBackground addSubview:userIcon];
    self.userIcon=userIcon;
    //原创微博的VIP图片
    UIImageView *vipIcon=[[UIImageView alloc] init];
    [self.statusBackground addSubview:vipIcon];
    self.vipIcon=vipIcon;
    //原创微博的配图
    UIImageView *photo=[[UIImageView alloc] init];
    [self.statusBackground addSubview:photo];
    self.photo=photo;
    //原创微博的用户昵称
    UILabel *userText=[[UILabel alloc] init];
    [self.statusBackground addSubview:userText];
    self.userText=userText;
    //原创微博的发布时间
    UILabel *createTime=[[UILabel alloc] init];
    [self.statusBackground addSubview:createTime];
    self.createTime=createTime;
    //原创微博的发布来源
    UILabel *sourceText=[[UILabel alloc] init];
    [self.statusBackground addSubview:sourceText];
    self.sourceText=sourceText;
    //原创微博的内容
    UILabel *statusText=[[UILabel alloc] init];
    [self.statusBackground addSubview:statusText];
    self.statusText=statusText;
    
}
/**
 *  设置转发微博的视图
 */
-(void) setupRetweetStatusSubViews{
    //转发微博的背景图片
    UIImageView *retweetStatusBackground=[[UIImageView alloc] init];
    [self.backgroundView addSubview:retweetStatusBackground];
    self.retweetStatusBackground=retweetStatusBackground;
    //转发微博的用户昵称
    UILabel *retweetUserText=[[UILabel alloc] init];
    [self.retweetStatusBackground addSubview:retweetUserText];
    self.retweetUserText=retweetUserText;
    //转发微博的内容
    UILabel *retweetStatusText=[[UILabel alloc] init];
    [self.retweetStatusBackground addSubview:retweetStatusText];
    self.retweetStatusText=retweetStatusText;
    //转发微博的配图
    UIImageView *retweetPhoto=[[UIImageView alloc] init];
    [self.retweetStatusBackground addSubview:retweetPhoto];
    self.retweetPhoto=retweetPhoto;
}
/**
 *  设置微博底部工具条
 */
-(void) setupBootomBar{
    
}

@end
