//
//  UnreadMessageCount.h
//  MyWeibo
//
//  Created by ChenXin on 3/23/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnreadMessageCount : NSObject
@property(nonatomic, assign) int status; // 新微博未读数
@property(nonatomic, assign) int follower;	//	新粉丝数
@property(nonatomic, assign) int cmt;	//	新评论数
@property(nonatomic, assign) int dm;	//	新私信数
@property(nonatomic, assign) int mention_status;	//	新提及我的微博数
@property(nonatomic, assign) int mention_cmt;	//	新提及我的评论数
@property(nonatomic, assign) int group;	//	微群消息未读数
@property(nonatomic, assign) int private_group;	//	私有微群消息未读数
@property(nonatomic, assign) int notice;	//	新通知未读数
@property(nonatomic, assign) int invite	;//	新邀请未读数
@property(nonatomic, assign) int badge;	//	新勋章数
@property(nonatomic, assign) int photo;	//	相册消息未读数
@property(nonatomic, assign) int msgbox;//	{{{3}}}
//未读消息数量
@property(nonatomic, assign) int messageCount;

@end
