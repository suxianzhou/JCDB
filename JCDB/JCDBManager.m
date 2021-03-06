//
//  JCDBManager.m
//  JCDB
//
//  Created by ChenJianjun on 16/6/16.
//  Copyright © 2016 Boych<https://github.com/Boych>. All rights reserved.
//

#import "JCDBManager.h"
#import <FMDB/FMDB.h>

@implementation JCDBManager

+ (instancetype)sharedManager
{
    static JCDBManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[JCDBManager alloc] init];
    });
    return sharedManager;
}

- (void)createWithDBName:(NSString *)dbName
{
    NSAssert(dbName.length > 0, @"dbName is illegal");
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingPathComponent:dbName];
    if (_dbQueue) {
        [self closeDB];
    }
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
}

- (void)createWithDBPath:(NSString *)dbPath
{
    NSAssert(dbPath.length > 0, @"dbPath is illegal");
    if (_dbQueue) {
        [self closeDB];
    }
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
}

- (void)closeDB
{
    [_dbQueue close];
    _dbQueue = nil;
}

@end
