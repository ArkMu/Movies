//
//  NSString+Status.h
//  食享天下
//
//  Created by qingyun on 16/3/23.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Status)

+ (instancetype)createDateStringWithData:(NSDate *)date;
+ (instancetype)sourceWithHtmlString:(NSString *)html;

@end
