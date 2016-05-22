//
//  FileReviewsModel.m
//  Movies
//
//  Created by qingyun on 16/4/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FilmReviewsModel.h"

#import "AuthorModel.h"

@implementation FilmReviewsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _Id = (NSInteger)value;
    }
    
//    if ([key isEqualToString:@"author"]) {
//        NSDictionary *dict = (NSDictionary *)value;
//        _author = [AuthorModel modelWithDictionary:dict];
//    }
}


- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _author = [AuthorModel modelWithDictionary:dict[@"author"]];
        _commentCount = [dict[@"commentCount"] integerValue];
        _text = dict[@"text"];
        _title = dict[@"title"];
        _upCount = [dict[@"upCount"] integerValue];
        _url = dict[@"url"];
        
    }
    
    return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

@end
