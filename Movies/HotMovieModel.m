//
//  HotMovieModel.m
//  Movies
//
//  Created by qingyun on 16/4/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HotMovieModel.h"

#import "NewsHeadLinesModel.h"

@implementation HotMovieModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _Id = (NSInteger)value;
    }
    NSMutableArray *headArr = [NSMutableArray array];
    if ([key isEqualToString:@"newsHeadlines"]) {
        NSArray *arr = (NSArray *)value;
        
        for (NSDictionary *dict in arr) {
            NewsHeadLinesModel *model = [NewsHeadLinesModel modelWithDictionary:dict];
            [headArr addObject:model];
        }
        _newsHeadline = headArr;
    }
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}


+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

@end
