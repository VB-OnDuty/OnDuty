//
//  ODDutyCell.h
//  OnDuty
//
//  Created by Vision on 16/3/22.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

#import "VBTableViewCell.h"
#import "ODDutyLable.h"

@interface ODDutyCell : VBTableViewCell

@property (nonatomic, strong) ODDutyLable *dateLB;

@property (nonatomic, strong) UIImageView *photoIV;

@property (nonatomic, strong) ODDutyLable * nameLB;

@property (nonatomic, strong) ODDutyLable *tipLB;


- (void)makeCellFilter:(CGFloat)value;
- (void)cellAlphaWithContentoffsetY:(CGFloat)y;
@end
