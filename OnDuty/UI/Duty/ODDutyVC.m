//
//  ODDutyVC.m
//  OnDuty
//
//  Created by Vision on 16/3/19.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

#import "ODDutyVC.h"
#import "ODDutyCell.h"

static NSString *ODRandomNameArray    = @"ODRandomNameArray";
static NSString *ODLastWeekofYear     = @"ODLastWeekofYear";
@interface ODDutyVC () <
    UITableViewDataSource,
    UITableViewDelegate,
    UIScrollViewDelegate
>


@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSArray *nameArr;

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"值日表";
    
    
    if ([self isOutofDate]) {
        
        [ODRandomManager getRandomArrayForArray:@[@"金晟意",@"张梦佳",@"李鸿勋",@"杨洁",@"刘照宇",@"张昊",@"刘天伟"] success:^(id result) {
            self.nameArr = result;
            [[NSUserDefaults standardUserDefaults] setObject:result forKey:ODRandomNameArray];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:[[self getCurrentDateComponents] weekOfYear]]  forKey:ODLastWeekofYear];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
    }
    [self checkNameArray];

    
    [self initNav];
    [self initTableView];
//    [self initMask];
    
}

- (void)initNav{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
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
    return self.nameArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identity = @"OnDutyVCCell";
    ODDutyCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[ODDutyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    cell.dateLB.text = [self getDataWithRow:indexPath.row];
    cell.photoIV.image = [UIImage imageNamed:@"123.jpg"];
    cell.nameLB.text = self.nameArr[indexPath.row];
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

- (NSString *)getDataWithRow:(NSInteger)row {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setDay:row];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY/MM/dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:newdate];
    return locationString;
}

- (NSDateComponents *)getCurrentDateComponents{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    calendar.firstWeekday = 2;
    NSDate *now;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];

    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSWeekOfYearCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now = [NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
        //（注意，周日是“1”，周一是“2”。。。。）
    return comps;
}



- (BOOL)isOutofDate{
    NSDateComponents * currentDateComponents = [self getCurrentDateComponents];
    NSInteger currentWeekofYear = [currentDateComponents weekOfYear];
    NSInteger lastWeekofYear = [[[NSUserDefaults standardUserDefaults] objectForKey:ODLastWeekofYear] integerValue];
    NSLog(@"%zd  %zd", currentWeekofYear, lastWeekofYear);
    if (currentWeekofYear == lastWeekofYear) {
        return NO;
    }
    return YES;
}

- (void)checkNameArray {
    NSArray *originalArr = [[NSUserDefaults standardUserDefaults] objectForKey:ODRandomNameArray];
    
    NSInteger week = [[self getCurrentDateComponents] weekday];
    
    NSMutableArray *finalArr = [NSMutableArray array];
    
    if (week == 1) {
        self.nameArr = @[[originalArr lastObject]];
    } else {
        for (NSInteger i = week; i <= 8; i++) {
            [finalArr addObject:originalArr[i - 2]];
        }
        self.nameArr = finalArr;
    }
    
}


@end
