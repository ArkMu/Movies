//
//  FMDBShare.m
//  Movies
//
//  Created by qingyun on 16/4/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FMDBShare.h"

#import "FMDatabase.h"
#import "HotMovieModel.h"

#define  HotMovie @"hotMovie.db"

@interface FMDBShare ()

@property (nonatomic, strong) FMDatabase *dbBase;

@end

@implementation FMDBShare

+ (instancetype)shareDataBase {
    static dispatch_once_t once;
    static FMDBShare *share;
    
    dispatch_once(&once, ^{
        share = [[FMDBShare alloc] init];
        
        if (![share.dbBase open]) {
            NSLog(@"%@", [share.dbBase lastErrorMessage]);
            return;
        }
        
        [share createTable];
    });
    
    return share;
}

- (NSString *)filePathWithFileName:(NSString *)fileName {
    NSString *fileDirectory = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    return [fileDirectory stringByAppendingPathComponent:fileName];
}

- (FMDatabase *)dbBase {
    if (_dbBase) {
        return _dbBase;
    }
    
    _dbBase = [FMDatabase databaseWithPath:[self filePathWithFileName:HotMovie]];
    return _dbBase;
}

- (BOOL)createTable {
    
    BOOL result = [self.dbBase executeUpdate:@"create table if not exists HotMovie(Id integer primary key, img text, nm text, mk float, showInfo text, scm text)"];
    
    if (!result) {
        NSLog(@"%@", [self.dbBase lastErrorMessage]);
    }
    return result;
}

- (BOOL)insertInfoIntoTable:(HotMovieModel *)model {
    BOOL result = [self.dbBase executeUpdate:@"insert into HotMovie(Id, img, nm, mk, showInfo, scm) values (?,?,?,?,?,?)", @(model.Id), model.img, model.nm, @(model.mk), model.showInfo, model.scm];
    if (!result) {
        NSLog(@"%@", [self.dbBase lastErrorMessage]);
    }
    
    return result;
}

- (NSMutableArray *)selectFromTableWithId:(NSInteger)Id {
    FMResultSet *set = [self.dbBase executeQuery:@"select * from HotMovie where Id=?", @(Id)];
    
    while ([set next]) {
        return [NSMutableArray arrayWithObject:[HotMovieModel modelWithDictionary:[set resultDictionary]]];
    }
    
    return nil;
}

- (NSMutableArray *)selectAllInfoFromTable {
    FMResultSet *set = [self.dbBase executeQuery:@"select * from HotMovie"];
    
    NSMutableArray *mArr = [NSMutableArray array];
    while ([set next]) {
        HotMovieModel *model = [HotMovieModel modelWithDictionary:[set resultDictionary]];
        [mArr addObject:model];
    }
    
    return mArr;
}

@end
