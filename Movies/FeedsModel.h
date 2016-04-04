//
//  FeedsModel.h
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface FeedsModel : NSObject

@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) NSInteger feedType;
@property (nonatomic, assign) NSInteger groupId;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSMutableArray *imageArr;

@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger upCount;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UserModel *User;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
