//
//  Account.m
//  Movies
//
//  Created by qingyun on 16/5/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "Account.h"

#define kAccountFile @"account"

@implementation Account

+ (instancetype)shareAccount {
    static dispatch_once_t once;
    static Account *account;

    dispatch_once(&once, ^{
        
        NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *filePath = [document stringByAppendingPathComponent:kAccountFile];
        
        account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
        if (!account) {
            account = [[Account alloc] init];
        }
    });
    
    return account;
}


- (void)saveLogin:(NSString *)userName {
    
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [document stringByAppendingPathComponent:kAccountFile];
    
    self.userName = userName;
    [NSKeyedArchiver archiveRootObject:self toFile:filePath];
    
}

-(BOOL)isLogin {
    if (!self.userName) {
        return NO;
    }
    return YES;
}

- (void)deleteUserInfo {
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [document stringByAppendingPathComponent:kAccountFile];
    
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    
    if (error) {
        NSLog(@"%@", error);
        
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
    }
    
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userName forKey:@"userName"];
}


@end
