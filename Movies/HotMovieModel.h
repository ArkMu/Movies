//
//  HotMovieModel.h
//  Movies
//
//  Created by qingyun on 16/4/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HotMovieModel : NSObject

@property (nonatomic, strong) NSString *cat;
@property (nonatomic, assign) NSInteger civilPubSt;
@property (nonatomic, strong) NSString *dir;
@property (nonatomic, assign) NSInteger dur;
@property (nonatomic, assign) NSInteger effectShowNum;
@property (nonatomic, strong) NSString *fra;
@property (nonatomic, strong) NSString *frt;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) BOOL globalReleased;
@property (nonatomic, strong) NSArray *headLines;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, assign) BOOL late;
@property (nonatomic, assign) NSInteger localPubSt;
@property (nonatomic, assign) float mk;
@property (nonatomic, strong) NSArray *newsHeadline;
@property (nonatomic, strong) NSString *nm;
@property (nonatomic, assign) NSInteger pn;
@property (nonatomic, assign) NSInteger preSale;
@property (nonatomic, assign) BOOL preShow;
@property (nonatomic, assign) NSInteger pubDate;
@property (nonatomic, assign) NSInteger pubShowNum;
@property (nonatomic, assign) NSInteger recentShowDate;
@property (nonatomic, assign) NSInteger recentShowNum;
@property (nonatomic, strong) NSString *rt;
@property (nonatomic, assign) float sc;
@property (nonatomic, strong) NSString *scm;
@property (nonatomic, strong) NSString *showInfo;
@property (nonatomic, assign) NSInteger showNum;
@property (nonatomic, assign) NSInteger showst;
@property (nonatomic, assign) NSInteger snum;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, assign) NSInteger totalShowNum;
@property (nonatomic, strong) NSString *ver;
@property (nonatomic, assign) NSInteger videoId;
@property (nonatomic, strong) NSString *videoName;
@property (nonatomic, strong) NSString *videourl;
@property (nonatomic, assign) NSInteger vnum;
@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, assign) NSInteger wish;
@property (nonatomic, assign) NSInteger wishst;


- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;


@end
