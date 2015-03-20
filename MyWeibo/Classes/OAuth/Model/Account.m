//
//  Account.m
//  MyWeibo
//
//  Created by ChenXin on 3/5/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
// 登陆成功后返回的accessToken相关信息

#import "Account.h"

@implementation Account

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeObject:self.saveTime forKey:@"saveTime"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.access_token=[aDecoder decodeObjectForKey:@"access_token"];
        self.uid=[aDecoder decodeInt64ForKey:@"uid"];
        self.expires_in=[aDecoder decodeInt64ForKey:@"expires_in"];
        self.remind_in=[aDecoder decodeInt64ForKey:@"remind_in"];
        self.saveTime=[aDecoder decodeObjectForKey:@"saveTime"];
        self.name=[aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

/**
 *  从字典转换为对象KVC
 *
 *  @param dict
 *
 *  @return
 */
-(id)initWithDict:(NSDictionary *) dict{
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

/**
 *  从字典转换为对象KVC
 */
+(id) accountFromeDict:(NSDictionary *) dict{
    Account *account=[[Account alloc] initWithDict:dict];
    return account;
}

@end
