//
//  ScrollViewModel.h
//  Movies
//
//  Created by qingyun on 16/4/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollViewModel : NSObject

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *commonTitle;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *imgUrlSize;
@property (nonatomic, strong) NSString *bigImgTypeUrl;
@property (nonatomic, strong) NSString *bigImgUrlSize;
@property (nonatomic, strong) NSString *app;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *typeDesc;
@property (nonatomic, strong) NSArray *standIdList;
@property (nonatomic, assign) NSInteger starttime;
@property (nonatomic, assign) NSInteger endTime;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger newUser;
@property (nonatomic, assign) NSInteger closable;
@property (nonatomic, assign) NSInteger channelType;
@property (nonatomic, strong) NSDictionary *channelListMap;
@property (nonatomic, strong) NSString *businessName;
@property (nonatomic, strong) NSString *businessIds;
@property (nonatomic, strong) NSString *url; //meituanmovie://www.meituan.com/forum/newsDetail?id=10509
@property (nonatomic, strong) NSArray *movieIdList;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
