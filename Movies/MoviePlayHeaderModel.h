//
//  MoviePlayHeaderModel.h
//  Movies
//
//  Created by qingyun on 16/4/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoviePlayHeaderModel : NSObject

@property (nonatomic, assign) NSInteger globalReleased;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pubdesc;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger showSt;
@property (nonatomic, strong) NSString *ver;
@property (nonatomic, assign) NSInteger wish;
@property (nonatomic, assign) NSInteger wishst;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
