//
//  FileReviewsModel.h
//  Movies
//
//  Created by qingyun on 16/4/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AuthorModel;

@interface FilmReviewsModel : NSObject

@property (nonatomic, strong) AuthorModel *author;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger upCount;
@property (nonatomic, strong) NSString *url;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
