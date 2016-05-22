//
//  Account.h
//  Movies
//
//  Created by qingyun on 16/5/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>

@property (nonatomic, strong) NSString *userName;


+ (instancetype)shareAccount;

- (void)saveLogin:(NSString *)userName;

- (BOOL)isLogin;

- (void)deleteUserInfo;

@end
