//
//  ODDutyVC.m
//  OnDuty
//
//  Created by Vision on 16/3/19.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

#import "ODDutyVC.h"
#import "ODDutyCell.h"

@interface ODDutyVC () <
    UITableViewDataSource,
    UITableViewDelegate,
    UIScrollViewDelegate
>

@property (nonatomic, strong)UITableView *tableView;



@end

@implementation ODDutyVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.modalPresentationCapturesStatusBarAppearance = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.title = @"值日表";
    [self initNav];
    [self initTableView];
    [self initMask];
    
}

- (void)initNav{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.backgroundColor = [VBColorManager colorWithHomeColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"MFLiHei_Noncommercial-Regular" size:17],NSFontAttributeName ,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 60, 44);
    [backButton setBackgroundColor:[UIColor clearColor]];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    backButton.titleLabel.font = [UIFont fontWithName:@"MFLiHei_Noncommercial-Regular" size:13];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitle:@"拜克" forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"BackItem"] forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(backBtnItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBtnItem;
}
- (void)initTableView{
    _tableView = [[VBTableView alloc]initWithFrame:CGRectMake(0 , NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, VIEW_WITHOUTNAV_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}
- (void)initMask{
    //遮罩
    UIImage *imageForMask = [UIImage imageNamed:@"Mask.png"];
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT);
    maskLayer.contents = (__bridge id _Nullable)([imageForMask CGImage]);
    [self.view.layer addSublayer: maskLayer];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identity = @"OnDutyVCCell";
    ODDutyCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[ODDutyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    
    cell.dateLB.text = @"2016/03/22";
    cell.photoIV.image = [UIImage imageNamed:@"123.jpg"];
    cell.nameLB.text = @"张日天";
    [cell isOnDutyToday:NO];
    if (indexPath.row == 0) {
        cell.tipLB.text = @"就在今天";
        [cell isOnDutyToday:YES];
    }
    if (indexPath.row == 1) {
        cell.tipLB.text = @"即将到来";
    }
    if (indexPath.row > 1) {
        cell.tipLB.text = @"做好准备";
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

-(NSArray *)cellsForTableView:(UITableView *)tableView
{
    NSInteger sections = tableView.numberOfSections;
    NSMutableArray *cells = [[NSMutableArray alloc]  init];
    for (int section = 0; section < sections; section++) {
        NSInteger rows =  [tableView numberOfRowsInSection:section];
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [cells addObject:[tableView cellForRowAtIndexPath:indexPath]];
        }
    }
    return cells;
}
@end
