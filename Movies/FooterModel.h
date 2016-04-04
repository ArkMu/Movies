//
//  FooterModel.h
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImageModel;

@interface FooterModel : NSObject

@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) ImageModel *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;    //meituanmovie://www.meituan.com/web?url=http://m.maoyan.com/groups?_v_=yes

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
