//
//  ODRootVC.m
//  OnDuty
//
//  Created by Vision on 16/2/25.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

#import "ODRootVC.h"
#import "ODRootButton.h"

#import "ODDutyVC.h"
//#import

@interface ODRootVC ()

@end

@implementation ODRootVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //初始化
    NSMutableArray*nameArr = [NSMutableArray arrayWithObjects:@"金晟意", @"李鸿勋", @"杨洁", @"刘天伟",@"张昊",@"刘照宇", nil];
    
    [self initMainView];
    
    
}
- (void)initMainView{
    //背景
    UIImageView *backGroundIV = ({
        UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.png"]];
        [self.view addSubview:imageV];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        imageV;
    });
    //icon
    UIImageView *iconIV = ({
        UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"duty.png"]];
        [self.view addSubview:imageV];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(158 / 2, 158 / 2));
            make.top.equalTo(@100);
            make.centerX.equalTo(self.view.mas_centerX);
        }];
        
        imageV;
    
    });
    //标语
    UILabel *sloganLB = ({
        UILabel *lable = [[UILabel alloc]init];
        [self.view addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(iconIV);
            make.top.equalTo(iconIV.mas_bottom).insets(UIEdgeInsetsMake(20, 0, 0, 0));
            
        }];
        
        lable.textColor = [UIColor blackColor];
        lable.font = [UIFont fontWithName:@"MFLiHei_Noncommercial-Regular" size:17];
        lable.text = @"/加强纪律性,革命无不胜/";
        lable;
    });
    //谁去值日按钮
    ODRootButton * dutyBT = ({
        ODRootButton *button = [[ODRootButton alloc]init];
        [self.view addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.rightMargin.equalTo(@33);
            make.height.equalTo(@125);
            make.centerX.equalTo(sloganLB);
            make.top.equalTo(sloganLB.mas_bottom).insets(UIEdgeInsetsMake(50, 0, 0, 0));
        }];
        button.imageName = @"clean.png";
        button.title = @"今天谁值日";
        
        button.block = ^(){
            [self.navigationController pushViewController:[ODDutyVC new] animated:YES];
        };
        
        button;
        
    });
    //谁去买东西按钮
    ODRootButton * buyBT = ({
        ODRootButton *button = [[ODRootButton alloc]init];
        [self.view addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.rightMargin.equalTo(@33);
            make.height.equalTo(@125);
            make.centerX.equalTo(dutyBT);
            make.top.equalTo(dutyBT.mas_bottom).insets(UIEdgeInsetsMake(30, 0, 0, 0));
        }];
        button.imageName = @"run.png";
        button.title = @"谁去买东西";
        
        button.block = ^(){
            NSLog(@"zou");
        };
        
        button;
        
    });
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
