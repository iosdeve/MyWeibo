//
//  NSDate+Extra.h
//  MyWeibo
//
//  Created by ChenXin on 3/16/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  实现两个日期时间差的汉字描述，比如刚刚，几分钟前，几小时前，昨天等等

#import <Foundation/Foundation.h>

@interface NSDate (Extra)

/**
 *  计算传入时间和当前时间进行比较的时间差文字描述
 *
 *  @param date 要比较的时间
 *
 *  @return 时间差的文字描述
 */
-(NSString *) timeDescriptionFrom:(NSDate *) date;

@end
