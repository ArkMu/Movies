//
//  FeedsModel.m
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FeedsModel.h"

#import "UserModel.h"
#import "ImageModel.h"

@implementation FeedsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _Id = (NSInteger)value;
    }
    if ([key isEqualToString:@"user"]) {
        _User = [UserModel modelWithDictionary:(NSDictionary *)value];
    }
    if ([key isEqualToString:@"images"]) {
        NSArray *arr = (NSArray *)value;
        
        _imageArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            ImageModel *model = [ImageModel modelWithDictionary:dict];
            [_imageArr addObject:model];
        }
    }
    if ([key isEqualToString:@"description"]) {
        _desc = (NSString *)value;
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
    return  [[self alloc] initWithDictionary:dict];
}
@end
