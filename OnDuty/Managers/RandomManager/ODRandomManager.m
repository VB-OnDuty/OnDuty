//
//  ODRandomManager.m
//  OnDuty
//
//  Created by Vision on 16/3/16.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

#import "ODRandomManager.h"

@implementation ODRandomManager


/**
 *  随机获取数组中的一个元素
 */
+ (NSArray *)randomObjectForArray:(NSArray *)array{
    if (array.count == 0 || !array) {
        return nil;
    }
    NSMutableArray *exchangeArray = [NSMutableArray arrayWithArray:array];
    NSInteger count = [exchangeArray count];
    for (NSInteger i = 0; i < count; ++i) {
        NSInteger n = (arc4random() % (count - i)) + i;
        [exchangeArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    return exchangeArray;
}
/**
 *  根据权重随机获取数组中的一个元素
 *    权重数组范例: @[@1,@2.....];
 */
+ (id)getRandomObjectForArray:(NSArray *)array withWeightArray:(NSArray *)weightArray{
    if (array.count == 0 || !array) {
        return nil;
    }
    if (weightArray.count == 0 || !weightArray || weightArray.count != array.count) {
        VBLogError(@"WeightArray error");
    }
    //计数总权重
    NSInteger totalWeight = 0;
    for (NSNumber *number in weightArray) {
        totalWeight += [number integerValue];
    }
    //随机权重
    NSInteger randomNum = arc4random() % totalWeight + 1;
    //根据随机权重寻找对象
    __block NSInteger currentNum = 0;
    __block id object = nil;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger weightNum = [weightArray[idx] integerValue];
        currentNum += weightNum;
        if (currentNum >= randomNum) {
            object = obj;
            *stop = YES;
        }
    }];
    return object;
}

+ (void)getRandomObjectForArray:(NSArray *)array withWeightArray:(NSArray *)weightArray success:(randomSucess)success{
    success([ODRandomManager getRandomObjectForArray:array withWeightArray:weightArray]);
}
@end
