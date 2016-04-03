//
//  FMDBShare.h
//  Movies
//
//  Created by qingyun on 16/4/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>

@class HotMovieModel;

@interface FMDBShare : NSObject

+ (instancetype)shareDataBase;

- (NSString *)filePathWithFileName:(NSString *)fileName;

- (BOOL)createTable;

- (BOOL)insertInfoIntoTable:(HotMovieModel *)model;

- (NSMutableArray *)selectFromTableWithId:(NSInteger)Id;

- (NSMutableArray *)selectAllInfoFromTable;
@end
