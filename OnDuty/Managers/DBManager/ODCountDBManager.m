//
//  ODCountDBManager.m
//  OnDuty
//
//  Created by Vision on 16/3/16.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

#import "ODCountDBManager.h"

@implementation ODCountDBManager
{
    VBDBManager *_dbMgr;
}
+ (id)sharedManager{
    static ODCountDBManager *c_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        c_manager = [[ODCountDBManager alloc]init];
    });
    return c_manager;
}

- (id)init{
    self = [super init];
    if (self) {
        _dbMgr = [VBDBManager defaultMgr];
        [self createTables];
    }
    return self;
}
- (void)createTables {
    [[_dbMgr fmDabaseQueue] inDatabase:^(FMDatabase *db) {
        const char table_sql[] = {
            "CREATE TABLE IF NOT EXISTS CountInfoList ("
            "name                 VARCHAR(32) PRIMARY KEY,"
            "dutyCount            INTEGER "
            ")"
        };
        [db executeUpdate:[NSString stringWithUTF8String:table_sql]];
    }];
    
}

/*** 插入 */
//根据模型插入数据
- (BOOL)insertCountInfo:(ODCountModel *)info{
    __block BOOL retValue = NO;
    [self deleteCountInfo:info];
    
    [[_dbMgr fmDabaseQueue] inDatabase:^(FMDatabase *db) {
        
        NSString *sql = @"INSERT INTO CountInfoList (name, dutyCount) VALUES(?, ?)";
        retValue = [db executeUpdate:sql,
                    [info name],
                    [info dutyCount]
                    ];
        
    }];
    
    return retValue;
}
//根据名字插入一个新的成员数据 (新建一个成员)
- (BOOL)insertCountInfoWithName:(NSString *)name{
    ODCountModel *info = [[ODCountModel alloc]init];
    info.name = name;
    info.dutyCount = 1;
    return [self insertCountInfo:info];
}



/*** 删除 */
//根据模型删除数据
- (void)deleteCountInfo:(ODCountModel *)info{
    if (info.name.length > 0) {
        [[_dbMgr fmDabaseQueue] inDatabase:^(FMDatabase *db) {
            
            NSString *sql = [NSString stringWithFormat:@"DELETE FROM CountInfoList WHERE name='%@'", info.name];
            [db executeUpdate:sql];
        }];
    }
}
//根据名字一个成员数据 (删除一个成员)
- (void)deleteCountInfoWithName:(NSString *)name{
    ODCountModel *info = [[ODCountModel alloc]init];
    info.name = name;
    [self deleteCountInfo:info];
}


//查找
- (ODCountModel *)selectCountInfoWithName:(NSString *)name{
    __block ODCountModel *resultInfo = nil;
    [[_dbMgr fmDabaseQueue] inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT *  FROM CountInfoList WHERE name='%@'", name];
        
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            ODCountModel *info = [[ODCountModel alloc] init];
            info.name = [rs stringForColumn:@"name"];
            info.dutyCount = [rs intForColumn:@"dutyCount"];
            resultInfo = info;
        }
        [rs close];
    }];
    return resultInfo;
}
//获取列表所有数据
- (NSArray *)getDataArray {
    __block NSMutableArray *listArray = [[NSMutableArray alloc] init];
    
    [[_dbMgr fmDabaseQueue] inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT *  FROM CountInfoList"];
        
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            ODCountModel *info = [[ODCountModel alloc] init];
            info.name = [rs stringForColumn:@"name"];
            info.dutyCount = [rs intForColumn:@"dutyCount"];
            [listArray addObject:info];
        }
        [rs close];
    }];
    
    return listArray;
}
//获取所有人名
- (NSArray *)getAllMemberArray{
    __block NSMutableArray *listArray = [[NSMutableArray alloc] init];
    
    [[_dbMgr fmDabaseQueue] inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT *  FROM CountInfoList"];
        
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            ODCountModel *info = [[ODCountModel alloc] init];
            info.name = [rs stringForColumn:@"name"];
            info.dutyCount = [rs intForColumn:@"dutyCount"];
            [listArray addObject:info.name];
        }
        [rs close];
    }];
    
    return listArray;
}
//根据人名数组获取 - dutyCount
- (NSArray *)getDutyCountWith:(NSArray *)nameArr{
    __block NSMutableArray *listArray = [[NSMutableArray alloc] init];
    [nameArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ODCountModel *info = [self selectCountInfoWithName:obj];
        if (info) {
            [listArray addObject:[NSNumber numberWithInteger:info.dutyCount]];
        } else {
            VBLogError(@"查询不到%@",obj);
            *stop = YES;
            listArray = nil;
        }
        info = nil;
    }];
    return listArray;
}

@end
