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


@interface ODRootVC ()
//成员数组
@property (nonatomic, strong)NSMutableArray *memberArr;
//权重数组
@property (nonatomic, strong)NSMutableArray *weightArr;
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
    _memberArr = nameArr;
    _weightArr = [NSMutableArray arrayWithObjects:@1, @1, @1, @1, @1, @1, nil];
    
}
- (void)buttonClicked:(UIButton *)button{
    NSString *fuckBoy = [ODRandomManager getRandomObjectForArray:_memberArr withWeightArray:_weightArr];
        NSLog(@"%@", fuckBoy);
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
