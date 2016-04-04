//
//  FooterModel.m
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FooterModel.h"

#import "ImageModel.h"

@implementation FooterModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _desc = dict[@"description"];
        _Id = [dict[@"id"] integerValue];
        _image = [ImageModel modelWithDictionary:dict[@"image"]];
        _title = dict[@"title"];
        _url = dict[@"url"];
    }
    
    return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

@end
