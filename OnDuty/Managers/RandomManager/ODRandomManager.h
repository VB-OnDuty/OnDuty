//
//  ODRandomManager.h
//  OnDuty
//
//  Created by Vision on 16/3/16.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

#import "VBObject.h"

@interface ODRandomManager : VBObject

/**
 *  随机打乱数组
 */
+ (NSArray *)randomObjectForArray:(NSArray *)array;
/**
 *  根据权重随机获取数组中的一个元素
 *    权重数组范例: @[@1,@2.....];
 */
+ (id)getRandomObjectForArray:(NSArray *)array withWeightArray:(NSArray *)weightArray;
@end
