//
//  ODRandomManager.h
//  OnDuty
//
//  Created by Vision on 16/3/16.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

#import "VBObject.h"

typedef void (^randomSucess)(id result);


@interface ODRandomManager : VBObject

/**
 *  随机打乱数组
 */
+ (NSArray *)randomObjectForArray:(NSArray *)array;


/**
 *  根据权重随机获取数组中的一个元素
 *
 *  @param array       随机元素数组
 *  @param weightArray 权重数组 范例: @[@1,@2.....]
 *
 *  @return 一个随机元素
 */
+ (id)getRandomObjectForArray:(NSArray *)array withWeightArray:(NSArray *)weightArray;


/**
 *  根据权重随机获取数组中的一个元素block方法
 *
 *  @param array       随机元素数组
 *  @param weightArray 权重数组 范例: @[@1,@2.....]
 */
+ (void)getRandomObjectForArray:(NSArray *)array withWeightArray:(NSArray *)weightArray success:(randomSucess)success;

//------------项目方法-----------
/**
 *  根据权重获取谁值日
 *   默认星期六 星期天为命中周 
 *
 *  @param array 参与的人
 */
+ (void)getRandomArrayForArray:(NSArray *)array success:(randomSucess)success;
@end
