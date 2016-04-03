//
//  CityModel.h
//  Movies
//
//  Created by qingyun on 16/4/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

@property (nonatomic, assign) BOOL deleted;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString *nm;
@property (nonatomic, strong) NSString *py;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
