//
//  ODCountDBManager.h
//  OnDuty
//
//  Created by Vision on 16/3/16.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

#import "VBObject.h"


@interface ODCountDBManager :VBObject

+ (id)sharedManager;
/*** 插入 */
//根据模型插入数据
- (BOOL)insertCountInfo:(ODCountModel *)info;
//根据名字插入一个新的成员数据 (新建一个成员)
- (BOOL)insertCountInfoWithName:(NSString *)name;


/*** 删除 */
//根据模型删除数据
- (void)deleteCountInfo:(ODCountModel *)info;
//根据名字一个成员数据 (删除一个成员)
- (void)deleteCountInfoWithName:(NSString *)name;

/*** 修改 */

//更新dutyCount 根据名字
- (BOOL)updateDutyCount:(NSInteger)count WithName:(NSString *)name;
//在现有dutyCount基础上加1
- (BOOL)updateDutyCountPlusOneWithName:(NSString *)name;
/*** 查找 */
- (ODCountModel *)selectCountInfoWithName:(NSString *)name;
//获取列表所有数据
- (NSArray *)getDataArray;
//获取所有人名
- (NSArray *)getAllMemberArray;
//根据人名数组获取 - dutyCount
- (NSArray *)getDutyCountWith:(NSArray *)nameArr;
@end
