//
//  ODDutyCell.m
//  OnDuty
//
//  Created by Vision on 16/3/22.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

#import "ODDutyCell.h"
#import "ODDutyLable.h"

@interface  ODDutyCell ()

@property (nonatomic, strong) UIView *midLineView;

@property (nonatomic, strong) UIView *bottomLineView;
@end

@implementation ODDutyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)initSubViews{
    _dateLB = [[ODDutyLable alloc]init];
    _dateLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_dateLB];
    
    _midLineView = [[ODDutyLable alloc]init];
    _midLineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_midLineView];
    
    _photoIV = [[UIImageView alloc]init];
    [_photoIV setClipsToBounds:YES];
    _photoIV.layer.masksToBounds = YES;
    _photoIV.layer.cornerRadius = 20;
    [self.contentView addSubview:_photoIV];
    
    _nameLB = [[ODDutyLable alloc]init];
    _nameLB.font = [UIFont fontWithName:@"MFLiHei_Noncommercial-Regular" size:17];
    [self.contentView addSubview:_nameLB];
    
    _tipLB = [[ODDutyLable alloc]init];
    _tipLB.font = [UIFont fontWithName:@"MFLiHei_Noncommercial-Regular" size:17];
    [self.contentView addSubview:_tipLB];
    
    _bottomLineView = [[UIView alloc]init];
    _bottomLineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_bottomLineView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [_dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@20);
        make.left.mas_equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    
    [_midLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_dateLB.mas_bottom).insets(UIEdgeInsetsMake(10, 0, 0, 0));
        make.left.mas_equalTo(@60);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, 0.5));
    }];
    
    [_photoIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_midLineView.mas_bottom).insets(UIEdgeInsetsMake(5, 0, 0, 0));
        make.left.mas_equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_photoIV.mas_right).insets(UIEdgeInsetsMake(0, 10, 0, 0));
        make.centerY.equalTo(_photoIV);
        make.size.mas_equalTo(CGSizeMake(100, 40));

    }];
    
    [_tipLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@10);
        make.centerY.equalTo(_photoIV);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_midLineView.mas_left);
        make.top.mas_equalTo(_photoIV.mas_bottom).insets(UIEdgeInsetsMake(10, 0, 0, 0));
        make.size.equalTo(_midLineView);
    }];
}

@end
