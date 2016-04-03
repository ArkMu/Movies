//
//  ActorInfoModel.h
//  Movies
//
//  Created by qingyun on 16/4/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActorModel : NSObject

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *cnm;
@property (nonatomic, assign) NSInteger cr;
@property (nonatomic, strong) NSString *enm;
@property (nonatomic, assign) NSInteger actorId;
@property (nonatomic, strong) NSString *roles;
@property (nonatomic, strong) NSString *still;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;


@end
