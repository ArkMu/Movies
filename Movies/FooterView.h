//
//  FooterView.h
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FooterModel;

@interface FooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) NSArray<FooterModel *> *modelArr;

@property (nonatomic, strong) void (^gotoWebView)(NSString *url);

@end
