//
//  NSDate+Extra.m
//  MyWeibo
//
//  Created by ChenXin on 3/16/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  实现两个日期时间差的汉字描述，比如刚刚，几分钟前，几小时前，昨天等等

#import "NSDate+Extra.h"

@implementation NSDate (Extra)

/**
 *  计算传入时间和当前时间进行比较的时间差文字描述
 *
 *  @param date 要比较的时间
 *
 *  @return 时间差的文字描述
 */
-(NSString *) timeDescriptionFrom:(NSDate *) date{
    //要返回等时间描述
    NSString *timeDes=nil;
    //初始化当前等calendar对象
    NSCalendar *calend=[NSCalendar currentCalendar];
    //获取年，月，日
    int unit=NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    //获取传入date的年月日
    NSDateComponents *fromComponents=[calend components:unit fromDate:date];
    //获取当前date的年月日
    NSDateComponents *toComponents=[calend components:unit fromDate:self];
    //获取传入date和当前date的时分秒差
    NSDateComponents *hmsCompent=[calend components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date toDate:self options:0];
    NSDateFormatter *formate=[[NSDateFormatter alloc] init];
    //如果是当天
    if (toComponents.year==fromComponents.year && toComponents.month==fromComponents.month && toComponents.day==fromComponents.day) {
        if (hmsCompent.hour>=1) {
            timeDes=[NSString stringWithFormat:@"%d小时前",hmsCompent.hour];
        }else if(hmsCompent.minute>=1){
            timeDes=[NSString stringWithFormat:@"%d分钟前",hmsCompent.minute];
        }else{
            timeDes=@"刚刚";
        }
    }
    //如果是当月
    else if(toComponents.year==fromComponents.year && toComponents.month==fromComponents.month){
        if (hmsCompent.hour>24 && hmsCompent.hour<48) {
            timeDes=[NSString stringWithFormat:@"昨天"];
        }else{
            timeDes=[NSString stringWithFormat:@"%d天前",toComponents.day-fromComponents.day];
        }
    }else if(toComponents.year==fromComponents.year){
        formate.dateFormat=@"MM-dd HH:mm";
        timeDes=[formate stringFromDate:date];
    }else{
        formate.dateFormat=@"yyyy-MM-dd HH:mm";
        timeDes=[formate stringFromDate:date];
    }
    return timeDes;
}

@end
