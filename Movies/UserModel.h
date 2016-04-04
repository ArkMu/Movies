//
//  UserModel.h
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityModel;

@interface UserModel : NSObject

@property (nonatomic, strong) NSString *age;
@property (nonatomic, assign) NSInteger avatarType;
@property (nonatomic, strong) NSString *avatarurl;
@property (nonatomic, assign) NSInteger birthday;
@property (nonatomic, strong) CityModel *City;
@property (nonatomic, assign) NSInteger currentExp;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString *interest;
@property (nonatomic, strong) NSString *maoyanAge;
@property (nonatomic, strong) NSString *marriage;
@property (nonatomic, strong) NSString *nextTitle;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *occupation;
@property (nonatomic, assign) NSInteger registerTime;
@property (nonatomic, assign) NSInteger roleType;
@property (nonatomic, strong) NSString *signature;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger topicCount;
@property (nonatomic, assign) NSInteger totalExp;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger userLevel;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *vipInfo;
@property (nonatomic, assign) NSInteger vipType;
@property (nonatomic, assign) NSInteger visitorCount;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
