//
//  SearchMovieModel.h
//  Movies
//
//  Created by qingyun on 16/4/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchMovieModel : NSObject

@property (nonatomic, strong) NSString *cat;
@property (nonatomic, assign) NSInteger dur;
@property (nonatomic, strong) NSString *enm;
@property (nonatomic, strong) NSString *fra;
@property (nonatomic, strong) NSString *frt;
@property (nonatomic, assign) NSInteger globalReleased;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *nm;
@property (nonatomic, strong) NSString *pubDesc;
@property (nonatomic, assign) float sc;
@property (nonatomic, strong) NSString *show;
@property (nonatomic, assign) NSInteger showst;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *ver;
@property (nonatomic, assign) NSInteger wish;
@property (nonatomic, assign) NSInteger wishst;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;


@end
