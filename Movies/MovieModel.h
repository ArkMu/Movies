//
//  MovieModel.h
//  Movies
//
//  Created by qingyun on 16/4/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject 

@property (nonatomic, strong) NSString *cat;
@property (nonatomic, assign) BOOL commented;
@property (nonatomic, strong) NSString *dir;
@property (nonatomic, strong) NSString *dra;
@property (nonatomic, assign) NSInteger dur;
@property (nonatomic, strong) NSString *enm;
@property (nonatomic, strong) NSString *fra;
@property (nonatomic, strong) NSString *frt;
@property (nonatomic, assign) BOOL globalReleased;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, assign) BOOL musicNum;
@property (nonatomic, strong) NSString *nm;
@property (nonatomic, assign) BOOL onSale;
@property (nonatomic, strong) NSString *photos;
@property (nonatomic, assign) NSInteger pn;
@property (nonatomic, strong) NSString *proCompany;
@property (nonatomic, strong) NSString *pubDesc;
@property (nonatomic, strong) NSString *relCompany;
@property (nonatomic, strong) NSString *rt;
@property (nonatomic, assign) float sc;
@property (nonatomic, strong) NSString *scm;
@property (nonatomic, assign) NSInteger showst;
@property (nonatomic, assign) NSInteger snum;
@property (nonatomic, strong) NSString *src;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *vd;
@property (nonatomic, strong) NSString *ver;
@property (nonatomic, strong) NSString *videoImg;
@property (nonatomic, strong) NSString *videoName;
@property (nonatomic, strong) NSString *videourl;
@property (nonatomic, assign) NSInteger vnum;
@property (nonatomic, assign) NSInteger wish;
@property (nonatomic, assign) NSInteger wishst;

@property (nonatomic, strong) NSString *shootingCty;  // 影片拍摄场地

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
