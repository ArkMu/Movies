//
//  HcmtModel.h
//  Movies
//
//  Created by qingyun on 16/4/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HcmtModel : NSObject

@property (nonatomic, assign) NSInteger approve;
@property (nonatomic, assign) BOOL approved;
@property (nonatomic, strong) NSString *avatarurl;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) BOOL isMajor;
@property (nonatomic, assign) NSInteger movieId;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, assign) NSInteger oppose;
@property (nonatomic, assign) NSInteger reply;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger spoiler;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, assign) NSInteger sureViewed;
@property (nonatomic, strong) NSDictionary *tagList;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger UserLevel;
@property (nonatomic, strong) NSString *vipInfo;
@property (nonatomic, assign) NSInteger vipType;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
