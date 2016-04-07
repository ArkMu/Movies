//
//  MoviePlayModel.h
//  Movies
//
//  Created by qingyun on 16/4/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoviePlayModel : NSObject

@property (nonatomic, assign) NSInteger comment;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, assign) NSInteger movieId;
@property (nonatomic, strong) NSString *movieName;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger showSt;
@property (nonatomic, strong) NSString *tl;
@property (nonatomic, assign) NSInteger tm;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) NSInteger wish;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
