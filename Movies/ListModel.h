//
//  ListModel.h
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject

@property (nonatomic, strong) NSString *img;
@property (nonatomic, assign) NSInteger movieId;
@property (nonatomic, strong) NSString *movieName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *originName;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) NSInteger VideoId;
@property (nonatomic, assign) NSInteger wish;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
