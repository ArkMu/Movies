//
//  AppDelegate.h
//  Movies
//
//  Created by qingyun on 16/4/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)changeRootView ;

@property (nonatomic, strong) NSMutableArray *collectArr;

- (NSString *)createCollectPlist;

@end

