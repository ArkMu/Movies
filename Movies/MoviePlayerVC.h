//
//  MoviePlayerVC.h
//  Movies
//
//  Created by qingyun on 16/4/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviePlayerVC : UIViewController

@property (nonatomic, strong) NSString *videoUrl;

@property (nonatomic, assign) NSInteger movieId;

@property (nonatomic, strong) NSString *movieName;

@end
