//
//  AppDelegate.m
//  Movies
//
//  Created by qingyun on 16/4/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AppDelegate.h"

#import <AVOSCloud/AVOSCloud.h>
#import "Account.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

#import "WXApi.h"

#import "WeiboSDK.h"

#define kCollectFile @"collect.plist"

@interface AppDelegate ()

@end

BMKMapManager *_mapManager;

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AVOSCloud setApplicationId:@"u3ARmi1yfOS1hesiXWkAu11s-gzGzoHsz"
                      clientKey:@"PpjhdEb4IcBfNO8TuA6CuMRE"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (![[Account shareAccount] isLogin]) {
        self.window.rootViewController = [SB instantiateViewControllerWithIdentifier:@"Login"];
    } else {
        self.window.rootViewController = [SB instantiateViewControllerWithIdentifier:@"MainVC"];
    }
    
    [self.window makeKeyAndVisible];
    
    _collectArr = [NSMutableArray arrayWithContentsOfFile:[self createCollectPlist]];
    
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"s86ilWqB4Y19QvNLm4lkpOG4GQ8pWNsw" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed");
    }
    
    // sharesdk
    [ShareSDK registerApp:@"118a38f5eccf4" activePlatforms:@[@(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType) {
        switch (platformType) {
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType) {
            case SSDKPlatformTypeSinaWeibo:
                [appInfo SSDKSetupSinaWeiboByAppKey:@"2378750555" appSecret:@"e6c2b035d9dbd4d74caaf5ff0dfd5894" redirectUri:@"https://api.weibo.com/oauth2/default.html" authType:SSDKAuthTypeBoth];
                break;
                
            default:
                break;
        }
    }];
    
    return YES;
}

- (void)changeRootView {
    UIStoryboard *story = self.window.rootViewController.storyboard;
    UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"MainVC"];
    self.window.rootViewController = vc;
}

- (NSMutableArray *)collectArr {
    if (_collectArr == nil) {
        _collectArr = [NSMutableArray array];
    }
    
    return _collectArr;
}

- (NSString *)createCollectPlist {
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *filePath = [document stringByAppendingPathComponent:kCollectFile];
    
    return filePath;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (![userDefault valueForKey:@"isFirst"]) {
        AVObject *obj = [AVObject objectWithClassName:@"collect"];
        [obj setObject:self.collectArr forKey:@"collection"];
        [obj setObject:[Account shareAccount].userName forKey:@"userName"];
        
        [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [userDefault setValue:obj.objectId forKey:@"objectId"];
            }
            if (error) {
                NSLog(@"%@", error);
            }
        }];
        [userDefault setValue:@(YES) forKey:@"isFirst"];
    } else {
        NSString *objectId = [userDefault valueForKey:@"objectId"];
        
        AVObject *obj = [AVObject objectWithClassName:@"collect" objectId:objectId];
        [obj setObject:self.collectArr forKey:@"collection"];
        
        [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            }
        }];
    }
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    AVObject *obj = [AVObject objectWithClassName:@"collect"];
    [obj setObject:self.collectArr forKey:@"collection"];
    [obj setObject:[Account shareAccount].userName forKey:@"userName"];
    
    [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
    
}

@end
