//
//  ODDutyLable.m
//  OnDuty
//
//  Created by Vision on 16/3/22.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

#import "ODDutyLable.h"

@implementation ODDutyLable
- (instancetype)init{
    self = [super init];
    if (self) {
        self.font = [UIFont fontWithName:@"MFLiHei_Noncommercial-Regular" size:13];
        self.textColor = [UIColor blackColor];
    }
    return self;
}

@end
