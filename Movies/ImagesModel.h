//
//  ImagesModel.h
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

// feed.json



#import <Foundation/Foundation.h>

@interface ImagesModel : NSObject

@property (nonatomic, assign) NSInteger authorId;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger sizeType;
@property (nonatomic, assign) NSInteger targetId;
@property (nonatomic, assign) NSInteger targetType;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) NSInteger width;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
