//
//  Status.m
//  MyWeibo
//
//  Created by ChenXin on 3/6/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
// 微博模型

#import "Status.h"
#import "NSDate+Extra.h"
#import "MJExtension.h"
#import "StatusPhoto.h"

@implementation Status

-(NSDictionary *)objectClassInArray{
    return @{@"pic_urls" : [StatusPhoto class]};
}

/**
 *  处理微博创建时间
 */
-(NSString *)created_at{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    format.dateFormat=@"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *date=[format dateFromString:_created_at];
    return [[NSDate date] timeDescriptionFrom:date];
}
/**
 *  处理来源，取出标签符号
 *
 */
-(void)setSource:(NSString *)source{
    NSRange range1=[source rangeOfString:@">"];
    NSRange range2=[source rangeOfString:@"</"];
    NSString *newSource=[source substringWithRange:NSMakeRange(range1.location+1, range2.location-range1.location-1)];
    _source=[NSString stringWithFormat:@"来自%@",newSource];
}

@end
