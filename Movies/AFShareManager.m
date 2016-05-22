//
//  AFShareManager.m
//  美食家
//
//  Created by qingyun on 16/3/30.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AFShareManager.h"

@implementation AFShareManager

+ (instancetype)shareManager {
    static dispatch_once_t once;
    static AFShareManager *manager = nil;
    
    dispatch_once(&once, ^{
        manager = [[AFShareManager alloc] init];
    });
    
    return manager;
}

- (AFHTTPSessionManager *)baseHttpRequest {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:20];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/javascription", @"application/json", nil];
    return manager;
}

#pragma mark - GET
- (void)getResultWithParameter:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [manager GET:urlStr parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
}

#pragma mark - POST
- (void)postResultWithParameter:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [manager POST:urlStr parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errStr);
    }];
}

@end
