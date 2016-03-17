//
//  ODRootVC.m
//  OnDuty
//
//  Created by Vision on 16/2/25.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

#import "ODRootVC.h"
#import <objc/runtime.h>
#import <objc/objc.h>
#import "ODCountDBManager.h"

@interface ODRootVC ()
//成员数组
@property (nonatomic, strong)NSArray *memberArr;
//权重数组
@property (nonatomic, strong)NSArray *weightArr;
@end

@implementation ODRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 40);
    [button setTitle:@"fuck 一下" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //初始化
    NSMutableArray*nameArr = [NSMutableArray arrayWithObjects:@"金晟意", @"李鸿勋", @"杨洁", @"刘天伟",@"张昊",@"刘照宇", nil];
    [nameArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[ODCountDBManager sharedManager] insertCountInfoWithName:obj];
    }];
    _memberArr = [[ODCountDBManager sharedManager]getAllMemberArray];
    _weightArr = [[ODCountDBManager sharedManager] getDutyCountWith:_memberArr];
    
}
- (void)buttonClicked:(UIButton *)button{
  [ODRandomManager getRandomObjectForArray:_memberArr withWeightArray:_weightArr success:^(NSString *result) {
      NSLog(@"%@",result);
  }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
