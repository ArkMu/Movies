//
//  NSString+Status.m
//  食享天下
//
//  Created by qingyun on 16/3/23.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NSString+Status.h"

@implementation NSString (Status)

+ (instancetype)createDateStringWithData:(NSDate *)date {
    NSTimeInterval interval = -[date timeIntervalSinceNow];
    
    if (interval < 60) {
        return [NSString stringWithFormat:@"%d秒前", (int)interval];
    } else if (interval < 60 * 60) {
        return [NSString stringWithFormat:@"%d分钟前", (int)interval / 60];
    } else if (interval < 60 * 60 * 24) {
        return [NSString stringWithFormat:@"%d小时前", (int)interval / 60 / 60];
    } else if (interval < 60 * 60 * 24 * 30) {
        return [NSString stringWithFormat:@"%d天前", (int)interval / 60 / 60 / 24];
    } else
        return [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
}

+ (instancetype)sourceWithHtmlString:(NSString *)html {
    if (html.length == 0) {
        return nil;
    }
    
    // 创建正则表达式
    NSString *regExString = @">*<";
    NSError *error = nil;
    NSRegularExpression *resultExpression = [NSRegularExpression regularExpressionWithPattern:regExString options:NSRegularExpressionCaseInsensitive error:&error];
    
    // 使用正则表达式
    NSTextCheckingResult *result = [resultExpression firstMatchInString:html options:NSMatchingReportProgress range:NSMakeRange(0, html.length)];
    
    if (result) {
        NSRange resultRange = result.range;
        NSString *resultString = [html substringWithRange:NSMakeRange(resultRange.location + 1, resultRange.length - 2)];
        
        return resultString;
    }
    return nil;
}

@end
