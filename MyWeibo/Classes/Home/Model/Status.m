//
//  Status.m
//  MyWeibo
//
//  Created by ChenXin on 3/6/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
// 微博模型

#import "Status.h"
#import "NSDate+Extra.h"

@implementation Status

-(NSString *)created_at{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    format.dateFormat=@"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *date=[format dateFromString:_created_at];
    return [[NSDate date] timeDescriptionFrom:date];
}

@end
