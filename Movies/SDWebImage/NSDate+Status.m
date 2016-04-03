//
//  NSDate+Status.m
//  WeiBo
//
//  Created by qingyun on 16/3/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NSDate+Status.h"

@implementation NSDate (Status)

+ (instancetype)statusDateWithString:(NSString *)dateString {
    NSString *dateFormatter = @"EEEE MMM ss HH:mm:ss zzz yyyy";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormatter;
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    return [formatter dateFromString:dateString];
}

@end
