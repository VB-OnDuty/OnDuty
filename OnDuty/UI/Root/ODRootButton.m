//
//  ODRootButton.m
//  OnDuty
//
//  Created by Vision on 16/3/19.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

#import "ODRootButton.h"

@interface ODRootButton()

@property (nonatomic, strong) UIView * grayView;

@property (nonatomic, strong) UIImageView *topIV;

@property (nonatomic, strong) UILabel *titleLB;

@end

@implementation ODRootButton

- (instancetype)init{
   self = [super init];
    if (self) {
        
        
        _grayView = [[UIView alloc]init];
        [self addSubview:_grayView];
        _grayView.backgroundColor = [VBColorManager colorWithHomeColor];
        _grayView.layer.masksToBounds = YES;
        _grayView.layer.cornerRadius = 5;
        
        _topIV = [[UIImageView alloc]init];
        [self addSubview:_topIV];
        
        _titleLB = [[UILabel alloc]init];
        [self addSubview:_titleLB];
        _titleLB.userInteractionEnabled = YES;
        _titleLB.font = [UIFont fontWithName:@"MFLiHei_Noncommercial-Regular" size:35];
        _titleLB.textColor = [UIColor whiteColor];
        

    }
    return  self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(35, 0, 0, 0));
    }];
    [_topIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topIV.mas_bottom).insets(UIEdgeInsetsMake(5, 0, 0, 0));
        make.centerX.equalTo(self);
    }];
}
- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    _topIV.image = [UIImage imageNamed:imageName];
}
- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLB.text = title;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_block) {
        _block();
    }
}
@end
