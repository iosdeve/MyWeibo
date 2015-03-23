//
//  UnreadMessageCount.m
//  MyWeibo
//
//  Created by ChenXin on 3/23/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import "UnreadMessageCount.h"

@implementation UnreadMessageCount

-(int)messageCount{
    //未读消息数量
    _messageCount=self.cmt+self.dm+self.mention_cmt+self.mention_status;
    return _messageCount;
}

@end
