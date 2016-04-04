//
//  ScrollViewCell.h
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollViewModel;

@interface ScrollViewCell : UITableViewCell <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray<ScrollViewModel *> *modelArr;

@property (nonatomic, strong) void (^gotoWebView)(NSString *webUrl);

@end
