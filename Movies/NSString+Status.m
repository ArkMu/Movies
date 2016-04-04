//
//  NSString+Status.m
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NSString+Status.h"

@implementation NSString (Status)

+ (instancetype)createDateStringWithTimeInterval:(NSInteger)intervalGet {
    NSDate *pastedDate = [NSDate dateWithTimeIntervalSince1970:intervalGet];
    
    NSTimeInterval interval = -[pastedDate timeIntervalSinceNow];
    
    if (interval < 60) {
        return [NSString stringWithFormat:@"%f秒前", interval];
    } else if (interval < 60 * 60) {
        return [NSString stringWithFormat:@"%f分前", interval / 60];
    } else if (interval < 60 * 60 * 24) {
        return [NSString stringWithFormat:@"%f小时前", interval / 60 / 60];
    } else if (interval < 60 * 60 * 24 * 30) {
        return [NSString stringWithFormat:@"%f天前", interval / 60 / 60 / 24];
    } else {
        return [NSDateFormatter localizedStringFromDate:pastedDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    }
}

@end
