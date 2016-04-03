//
//  DetailHeaderView.h
//  Movies
//
//  Created by qingyun on 16/4/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieModel;

@interface DetailHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) MovieModel *model;

@end
