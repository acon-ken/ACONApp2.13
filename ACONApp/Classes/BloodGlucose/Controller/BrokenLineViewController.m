//
//  BrokenLineViewController.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/12/14.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "BrokenLineViewController.h"
#import "SelectDataViewController.h"
#import "DVSwitch.h"
#import "LineChartCiewCell.h"
#import "PieChartViewController.h"

#import "LineChartInfo.h"
#import "LineChartModel.h"

#import "HHLineChart.h"// 绘图
#import "HHLineChartContentView.h"//  容器
#import "HHLineChartTool.h"

#import "GetGlucoseSetModel.h"
#import "GetGlucoseSetData.h"
#import "BMPopView.h"

#import "LoginInfoModel.h"
#import "LoginInfoData.h"
@interface BrokenLineViewController ()<UITableViewDataSource,UITableViewDelegate,BMPopViewDelegate,UITextViewDelegate>
{
    
    
    NSString *begindate;
    NSString *enddate;
    
    /*****/
    
    NSMutableArray *_dataArr;
    
    /**
     *  数据多少
     */
    int _pageSize;
    int _totleData;
    /* 从现在 距离 过去 天数 （12月12 过去3天 12月9 － 12月12） */
    NSInteger kTimeInterval;
    /*****/
    
    int shareStatus; //分享平台类型
    UITextView *inputTV;//分享视图的输入筐
    UILabel *subTitleLb; //分享界面的副标题
    UILabel *contentLb; //分享界面的内容label
    
    LoginInfoModel *userinfo;
  
}
@property (nonatomic,retain)HHLineChartContentView *lineChartContentView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *dataSourceArray;


@end

@implementation BrokenLineViewController


- (void )viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self createHeaderView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    self.view.backgroundColor = KBackgroundColor;
    
    self.navigationController.navigationBarHidden = NO;
    self.edgesForExtendedLayout = NO;
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    
    
    //给导航栏加右侧按钮
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 10)];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [shareBtn  addTarget:self action:@selector(clickshareBtn) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.selected = YES;
    
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
    if (self.isme == YES) {
        UIBarButtonItem *righButtonitemt  = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
        self.navigationItem.rightBarButtonItem=righButtonitemt;
    }
    _pageSize = 1000;
    _totleData = 1000;
    /******请求数据******/
    
    /*系统当前日期*/
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    enddate =[dateformatter stringFromDate:senddate];
    
    /*7天前日期*/
    NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*7];
    
    NSDateFormatter  *dateformatter1=[[NSDateFormatter alloc] init];
    
    [dateformatter1 setDateFormat:@"yyyy-MM-dd"];
    
    begindate =[dateformatter1 stringFromDate:begindateCST];
    
    kTimeInterval = 7;//默认进入页面显示7天
    
    [self createHeaderView];
    [self createLineChartView];// 折线图
    [self createMainTableView];// 表
    [self setupRefresh];
    [self getLineChartData];
    [self postGetGlucoseSet];//创建视图后 发送请求返回血糖值范围

}

- (void)createLineChartView
{
    UILabel *lineChartTitleLB = [[UILabel alloc]init];
    lineChartTitleLB.frame = CGRectMake(60, 30, 180, 40);
    lineChartTitleLB.text = @"血糖趋势图 (mmol/L)";
    lineChartTitleLB.font = [UIFont systemFontOfSize:16.f];
    [self.view addSubview:lineChartTitleLB];
    
    UILabel *lineChartTitle2LB = [[UILabel alloc]init];
    lineChartTitle2LB.frame = CGRectMake(180+60, 30, 80, 40);
    lineChartTitle2LB.text = @"15.0 ~ 30.0";
    lineChartTitle2LB.font = [UIFont systemFontOfSize:10.f];
    [self.view addSubview:lineChartTitle2LB];
    
    if (!_lineChartContentView) {
        self.lineChartContentView = [[HHLineChartContentView alloc]initWithFrame:CGRectMake(0, 30 + 30, KScreenWidth, 300)];
    }
    self.lineChartContentView.maxY = 35;
    self.lineChartContentView.minY = 10;
    self.lineChartContentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.lineChartContentView];
    
    [self createMidView];
}
- (void)createMidView
{
    CGFloat midY = CGRectGetMaxY(_lineChartContentView.frame) - 10;
    UIImageView *redImg = [[UIImageView alloc] initWithFrame:CGRectMake(50, midY + 3 ,12, 12)];
    redImg.image = [UIImage imageNamed:@"juxing_zw"];
    [self.view addSubview:redImg];
    
    UILabel *redLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(redImg.frame), midY, 50, 20)];
    redLb.text =@"代表偏高";
    redLb.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:redLb];
    
    UIImageView *greenImg = [[UIImageView alloc] initWithFrame:CGRectMake(140, midY + 3 ,12, 12)];
    greenImg.image = [UIImage imageNamed:@"lvse"];
    [self.view addSubview:greenImg];
    UILabel *greenLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(greenImg.frame), midY, 50, 20)];
    greenLB.text =@"代表正常";
    greenLB.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:greenLB];
    
    UIImageView *blueImg = [[UIImageView alloc] initWithFrame:CGRectMake(230, midY + 3 ,12, 12)];
    blueImg.image = [UIImage imageNamed:@"lanse"];
    [self.view addSubview:blueImg];
    UILabel *blueLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(blueImg.frame), midY, 50, 20)];
    blueLB.text =@"代表偏低";
    blueLB.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:blueLB];
    
}

- (UIColor*)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

-(void)receiveIdexx:(NSNotification *)not{
    self.timerString = not.object;
    if ([self.timerString isEqualToString:@"0"]){
        self.timerString=nil;
    }
    
    if (self.timerString !=nil) {
        self.currenttimerstr =self.timerString;
    }
}
/**
 *  顶部时间段
 */
#pragma mark 时间段选择
- (void)createHeaderView
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveIdexx:) name:@"senderData" object:Nil];
    /*****/
    NSArray *dataArr;
    if (self.timerString == nil) {
        dataArr = @[@"7", @"14", @"30", @"60", @"90",@"自定义",@"饼图"];
    }
    else
    {
        dataArr = @[@"7", @"14", @"30", @"60", @"90",self.timerString,@"自定义",@"饼图"];
    }
    DVSwitch *secondSwitch ;
    
    //timerString = @"自定义";
    secondSwitch = [DVSwitch switchWithStringsArray:dataArr];
    secondSwitch.frame = CGRectMake(0, 0, KScreenWidth, 40);
    secondSwitch.backgroundColor = [UIColor whiteColor];
    secondSwitch.sliderColor = KCommonColor;
    secondSwitch.labelTextColorInsideSlider = [UIColor whiteColor];
    secondSwitch.labelTextColorOutsideSlider = KCommonColor;
    [secondSwitch setFont:[UIFont systemFontOfSize:13]];//设置选择控件的字体大小
    secondSwitch.cornerRadius = 0;
   
    if (self.currenttimerstr !=nil) {
       
        [secondSwitch forceSelectedIndex:5 animated:YES];
        
    }else
    {
        if (self.secondSwitchStatus == nil) {
             [secondSwitch forceSelectedIndex:0 animated:YES];
        }else{
         [secondSwitch forceSelectedIndex:[self.secondSwitchStatus integerValue] animated:YES];
        }
        
    }
    [secondSwitch setPressedHandler:^(NSUInteger index) {
        
       
        switch (index) {
            case 0:
            {
                self.secondSwitchStatus = @"0";
                self.currenttimerstr = nil;
                
                NSDate *senddate=[NSDate date];
                
                NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*7];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"yyyy-MM-dd"];
                
                begindate =[dateformatter stringFromDate:begindateCST];
                kTimeInterval = 7;
                [self getLineChartData];
                
            }
                break;
            case 1:
            {
                self.secondSwitchStatus = @"1";
                self.currenttimerstr = nil;
                
                NSDate *senddate=[NSDate date];
                
                NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*14];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"yyyy-MM-dd"];
                
                begindate =[dateformatter stringFromDate:begindateCST];
                kTimeInterval = 14;
                [self getLineChartData];
    
            }
                break;
            case 2:
            {
                self.secondSwitchStatus = @"2";
                self.currenttimerstr = nil;
                
                NSDate *senddate=[NSDate date];
                
                NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*30];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"yyyy-MM-dd"];
                
                begindate =[dateformatter stringFromDate:begindateCST];
                kTimeInterval = 30;
                [self getLineChartData];

                
            }
                break;
            case 3:
            {
                
                self.secondSwitchStatus = @"3";
                self.currenttimerstr = nil;
                
                NSDate *senddate=[NSDate date];
                
                NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*60];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"yyyy-MM-dd"];
                
                begindate =[dateformatter stringFromDate:begindateCST];
                kTimeInterval = 60;
                [self getLineChartData];
                
            }
                break;
                
            case 4:
            {
                self.secondSwitchStatus = @"4";
                self.currenttimerstr = nil;
                
                NSDate *senddate=[NSDate date];
                
                NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*90];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"yyyy-MM-dd"];
                
                begindate =[dateformatter stringFromDate:begindateCST];
                kTimeInterval = 90;
                [self getLineChartData];
                
            }
                break;
            case 5:
            {
                
                if (self.timerString ==nil) {
                    SelectDataViewController *vc = [[SelectDataViewController alloc] init];
                    [self.navigationController pushViewController: vc animated:YES];
                }else{
                    
                    self.currenttimerstr =[NSString stringWithFormat:@"%@",self.timerString];
                    int times = [self.timerString integerValue];
                    NSDate *senddate=[NSDate date];
                    NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*times];
                    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                    
                    [dateformatter setDateFormat:@"yyyy-MM-dd"];
                    
                    begindate =[dateformatter stringFromDate:begindateCST];
                    kTimeInterval = [_timerString intValue];
                    [self getLineChartData];
                    
                }
                
            }
                break;
            case 6:
            {
                if (self.timerString ==nil) {
                    ZWLog(@"折线图啦啦啦啦");
//                   PieChartViewController *pic = [[PieChartViewController alloc]init];
//                    pic.Statusstr = self.secondSwitchStatus;
////                    [self.navigationController pushViewController: pic animated:YES];
                    PieChartViewController *pic = (PieChartViewController *)[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-1-1];
                     [self.navigationController popViewControllerAnimated:YES];
                    pic.secondSwitchStatusstr = self.secondSwitchStatus;
                

                }
                else
                {
                    //self.secondSwitchStatus = nil;
                    SelectDataViewController *vc = [[SelectDataViewController alloc] init];
                    [self.navigationController pushViewController: vc animated:YES];
                }
                
            }
            break;
            case 7:
            {
                ZWLog(@"折线图啦啦啦啦");
                PieChartViewController *pic = (PieChartViewController *)[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-1-1];
                 pic.timerString = self.timerString;
                pic.currenttimerstr =self.currenttimerstr;
                 pic.secondSwitchStatusstr = self.secondSwitchStatus;
                [self.navigationController popViewControllerAnimated:YES];
//                PieChartViewController *pic = [[PieChartViewController alloc]init];
//                [self.navigationController pushViewController: pic animated:YES];
            }
            default:
                break;
        }
        
    }];
    
    
    [self.view addSubview:secondSwitch];
    
}

/**
 *  表视图
 *
 *  @return 表视图
 */
#pragma mark TableView
- (void)createMainTableView
{
    self.dataSourceArray = [[NSMutableArray alloc]init];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_lineChartContentView.frame) + 10, KScreenWidth,KScreenHeight - CGRectGetMaxY(_lineChartContentView.frame) - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor redColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.去缓存池中取出cell
    static NSString *ID = @"BaseDataCell";
    LineChartCiewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    // 2.缓存池没有cell，重新创建cell
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LineChartCiewCell" owner:nil options:nil] lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.grayLine.alpha = 1;
    cell.grayLineBottom.alpha = 1;
    LineChartInfo *info = [self.dataSourceArray objectAtIndex:indexPath.row];
    // 状态判断
    if ([info.measureValueNote isEqualToString:@"偏高"]) {
        cell.valueLB.textColor = DEF_P_COLOR_MAX;
        cell.statueImageView.image = [UIImage imageNamed:k_Statue_ku_image];
        cell.rightImageView.image = [UIImage imageNamed:k_Statue_high_image];
        
    }else if ([info.measureValueNote isEqualToString:@"正常"])
    {
        cell.valueLB.textColor = DEF_P_COLOR_NOMAL;
        cell.statueImageView.image = [UIImage imageNamed:k_Statue_lv_image];
        cell.rightImageView.image = [UIImage imageNamed:k_Statue_nomal_image];
        
    }else if ([info.measureValueNote isEqualToString:@"偏低"])
    {
        cell.valueLB.textColor = DEF_P_COLOR_MIN;
        cell.statueImageView.image = [UIImage imageNamed:k_Statue_qi_image];
        cell.rightImageView.image = [UIImage imageNamed:k_Statue_low_image];
    }
    else
    {
        cell.statueImageView.image = nil;
        cell.rightImageView.image = nil;
    }
    
//    cell.statueImageView.image = [UIImage imageNamed:k_Statue_ku_image];
//    cell.rightImageView.image = [UIImage imageNamed:k_Statue_high_image];
    
    NSString *statuesStr ;
    switch ([info.periodType intValue]) {
        case 1://1 餐前
        {
            statuesStr = @"餐前";
        }
            break;
        case 2://2餐后
        {
            statuesStr = @"餐后";
        }
            break;
        case 3://3空腹
        {
            statuesStr = @"空腹";
        }
            break;
        case 4://4 随机
        {
            statuesStr = @"随机";
        }
            break;
        default:
        {
            statuesStr = @"随机";
        }
            break;
    }
    cell.statuesLB.text = statuesStr;
    //PeriodType	时间段	String	是	1 餐前 2餐后 3空腹  4 随机
    
    
    
    cell.valueLB.text = [NSString stringWithFormat:@"%@",info.measureValueFormat];
    cell.dateLB.text = [NSString stringWithFormat:@"%@ %@",info.measureTimeFormat,info.measureTimeT];
    [cell.valueLB needsUpdateConstraints];
    if (0 == indexPath.row) {
        cell.grayLine.alpha = 0;
    }
    if ((self.dataSourceArray.count-1) == indexPath.row) {
        cell.grayLineBottom.alpha = 0;
    }
    return cell;
}
#pragma mark -
#pragma mark 数据请求
/**
 *  请求折线图数据
 */
- (void)getLineChartData
{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    WebServices *service = [[WebServices alloc] init];
    /*系统当前日期*/
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    enddate =[dateformatter stringFromDate:senddate];
   [self.lineChartContentView setKCurrentDate:[dateformatter dateFromString:enddate]];// 纪录请求数据的时间
    [self.lineChartContentView setTimeInterval:kTimeInterval];
    

    LoginInfoModel *userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:userinfo.data.dataIdentifier,@"u_Id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:begindate,@"beginTime", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:enddate,@"endTime", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"1"],@"pageIndex", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",_pageSize],@"pageSize", nil]];
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetUserGlocuseListLineMethodName];

    __weak BrokenLineViewController *wself = self;
    [service asyncServiceUrl:GetGlucoseWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetUserGlocuseListLineMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            LineChartModel *info = [[LineChartModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
                [wself.dataSourceArray removeAllObjects];
                [wself.dataSourceArray addObjectsFromArray:info.data];
                wself.lineChartContentView.dataSourceArray = self.dataSourceArray;
                _totleData = wself.dataSourceArray.count;
                [wself.tableView reloadData];
            }
            
        }
        else
        {
            NSLog(@"网络异常！");
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
            [alertView show];
        }

    }];

}

//根据用户Id获取用户设置血糖的最高和最低请求
-(void)postGetGlucoseSet{
    WebServices *service = [[WebServices alloc] init];
    LoginInfoModel *userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:userinfo.data.dataIdentifier,@"u_Id", nil]];
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetGlucoseSetMethodName];

    __weak BrokenLineViewController *wself = self;
    [service asyncServiceUrl:GetGlucoseWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetGlucoseSetMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            GetGlucoseSetModel *info = [[GetGlucoseSetModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                //
                //            GetmaxStr = [NSString stringWithFormat:@"%.1fmmol",info.data.max];
                //            GetminStr = [NSString stringWithFormat:@"%.1fmmol",info.data.min];
                if (wself.lineChartContentView)
                {
                    wself.lineChartContentView.maxY = info.data.max;
                    wself.lineChartContentView.minY = info.data.min;
                    wself.lineChartContentView.normalY = (info.data.max + info.data.min)/2;
                    wself.lineChartContentView.normalValueRange = CGSizeMake(info.data.min, info.data.max);
                }
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:info.msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }
            
        }
        else
        {
            NSLog(@"网络异常！");
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
            [alertView show];
        }
    }];
}



/**
 *  按钮点击事件
 */
#pragma mark 按钮点击事件
/****************************************************************************/
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark 分享按钮点击事件
-(void)clickshareBtn
{
    UIView *shareview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth - 20, 250)];
    shareview.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    shareview.layer.cornerRadius = 5;
    shareview.layer.masksToBounds = YES;
    [BMPopView shareInstance].customFrame = NO ;
    
    //添加分割线
    UIImageView *headLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, KScreenWidth,1 )];
    headLine.highlighted = YES;// flag
    headLine.image = [UIImage imageNamed:@"xian"];
    
    
    UILabel *headshareLb = [[UILabel alloc]initWithFrame:CGRectMake(0,0, shareview.frame.size.width, 30)];
    headshareLb.text=@"分享到";
    headshareLb.textColor = [UIColor blackColor];
    headshareLb.font = [UIFont fontWithName:@"Helvetica" size:18];
    headshareLb.textAlignment=NSTextAlignmentCenter;
    
    
    //新浪微博按钮
    UIButton *sinaBtn = [[UIButton alloc] initWithFrame:CGRectMake((shareview.frame.size.width-20)/3-65, CGRectGetMaxY(headLine.frame)+15, 60, 60)];
    [sinaBtn setBackgroundImage:[UIImage imageNamed:@"xl"] forState:UIControlStateNormal];
    [sinaBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    sinaBtn.tag = 881;
    
    UILabel *sinaLb = [[UILabel alloc] initWithFrame:CGRectMake(sinaBtn.frame.origin.x, CGRectGetMaxY(sinaBtn.frame), sinaBtn.frame.size.width, 20)];
    sinaLb.text = @"新浪微博";
    sinaLb.font = [UIFont systemFontOfSize:14];
    sinaLb.textAlignment = NSTextAlignmentCenter;
    
    
    //微信好友按钮
    UIButton *weixinFriendsBtn = [[UIButton alloc] initWithFrame:CGRectMake(30 + CGRectGetMaxX(sinaBtn.frame), sinaBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height)];
    [weixinFriendsBtn setBackgroundImage:[UIImage imageNamed:@"wx"] forState:UIControlStateNormal];
    [weixinFriendsBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    weixinFriendsBtn.tag = 882;
    
    UILabel *weixinFriendsLb = [[UILabel alloc] initWithFrame:CGRectMake(weixinFriendsBtn.frame.origin.x, CGRectGetMaxY(weixinFriendsBtn.frame), weixinFriendsBtn.frame.size.width, sinaLb.frame.size.height)];
    weixinFriendsLb.text = @"微信好友";
    weixinFriendsLb.font = [UIFont systemFontOfSize:14];
    weixinFriendsLb.textAlignment = NSTextAlignmentCenter;
    
    
    //微信朋友圈按钮
    UIButton *weixinPeopleBtn = [[UIButton alloc] initWithFrame:CGRectMake(30 + CGRectGetMaxX(weixinFriendsBtn.frame), sinaBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height)];
    [weixinPeopleBtn setBackgroundImage:[UIImage imageNamed:@"pyq"] forState:UIControlStateNormal];
    [weixinPeopleBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    weixinPeopleBtn.tag = 883;
    
    UILabel *weixinPeopleLb = [[UILabel alloc] initWithFrame:CGRectMake(weixinPeopleBtn.frame.origin.x-4, CGRectGetMaxY(weixinPeopleBtn.frame), sinaBtn.frame.size.width+10, sinaLb.frame.size.height)];
    weixinPeopleLb.text = @"微信朋友圈";
    weixinPeopleLb.font = [UIFont systemFontOfSize:14];
    weixinPeopleLb.textAlignment = NSTextAlignmentCenter;
    
    
    //QQ空间按钮
    UIButton *qqSpaceBtn = [[UIButton alloc] initWithFrame:CGRectMake(sinaBtn.frame.origin.x, CGRectGetMaxY(sinaBtn.frame)+40, sinaBtn.frame.size.width, sinaBtn.frame.size.height)];
    [qqSpaceBtn setBackgroundImage:[UIImage imageNamed:@"kongjian"] forState:UIControlStateNormal];
    [qqSpaceBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    qqSpaceBtn.tag = 884;
    
    UILabel *qqSpaceLb = [[UILabel alloc] initWithFrame:CGRectMake(qqSpaceBtn.frame.origin.x, CGRectGetMaxY(qqSpaceBtn.frame), sinaBtn.frame.size.width, sinaLb.frame.size.height)];
    qqSpaceLb.text = @"QQ空间";
    qqSpaceLb.font = [UIFont systemFontOfSize:14];
    qqSpaceLb.textAlignment = NSTextAlignmentCenter;
    
    
    //QQ好友按钮
    UIButton *qqFriendsBtn = [[UIButton alloc] initWithFrame:CGRectMake(weixinFriendsBtn.frame.origin.x , qqSpaceBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height)];
    [qqFriendsBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [qqFriendsBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    qqFriendsBtn.tag = 885;
    
    UILabel *qqFriendsLb = [[UILabel alloc] initWithFrame:CGRectMake(qqFriendsBtn.frame.origin.x, CGRectGetMaxY(qqFriendsBtn.frame), sinaBtn.frame.size.width, sinaLb.frame.size.height)];
    qqFriendsLb.text = @"QQ好友";
    qqFriendsLb.font = [UIFont systemFontOfSize:14];
    qqFriendsLb.textAlignment = NSTextAlignmentCenter;
    
    
    //腾讯微博按钮
    UIButton *tencentWeiboBtn = [[UIButton alloc] initWithFrame:CGRectMake(weixinPeopleBtn.frame.origin.x, qqSpaceBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height)];
    [tencentWeiboBtn setBackgroundImage:[UIImage imageNamed:@"wb"] forState:UIControlStateNormal];
    [tencentWeiboBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    tencentWeiboBtn.tag = 886;
    
    UILabel *tencentWeiboLb = [[UILabel alloc] initWithFrame:CGRectMake(tencentWeiboBtn.frame.origin.x, CGRectGetMaxY(tencentWeiboBtn.frame), sinaBtn.frame.size.width, sinaLb.frame.size.height)];
    tencentWeiboLb.text = @"腾讯微博";
    tencentWeiboLb.font = [UIFont systemFontOfSize:14];
    tencentWeiboLb.textAlignment = NSTextAlignmentCenter;
    
    
    [shareview addSubview:headshareLb];
    [shareview addSubview:headLine];
    
    if ([userinfo.data.userInfoIp isEqualToString:@"test"])
    {
        userinfo.data.userInfoIp = @"";
    }

    
    if(![userinfo.data.userInfoIp isEqualToString:@""]){
        
        tencentWeiboBtn.frame = CGRectMake(30 + CGRectGetMaxX(sinaBtn.frame), sinaBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height);
        tencentWeiboLb.frame  = CGRectMake(tencentWeiboBtn.frame.origin.x, CGRectGetMaxY(tencentWeiboBtn.frame), tencentWeiboBtn.frame.size.width, sinaLb.frame.size.height);
        
        [shareview addSubview:sinaBtn];
        [shareview addSubview:sinaLb];
        [shareview addSubview:tencentWeiboBtn];
        [shareview addSubview:tencentWeiboLb];
        
        
    }else{
        tencentWeiboBtn.frame = CGRectMake(weixinPeopleBtn.frame.origin.x, qqSpaceBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height);
        tencentWeiboLb.frame = CGRectMake(tencentWeiboBtn.frame.origin.x, CGRectGetMaxY(tencentWeiboBtn.frame), sinaBtn.frame.size.width, sinaLb.frame.size.height);
        
        [shareview addSubview:sinaBtn];
        [shareview addSubview:sinaLb];
        [shareview addSubview:tencentWeiboBtn];
        [shareview addSubview:tencentWeiboLb];
        [shareview addSubview:weixinFriendsBtn];
        [shareview addSubview:weixinFriendsLb];
        [shareview addSubview:weixinPeopleBtn];
        [shareview addSubview:weixinPeopleLb];
        [shareview addSubview:qqSpaceBtn];
        [shareview addSubview:qqSpaceLb];
        [shareview addSubview:qqFriendsBtn];
        [shareview addSubview:qqFriendsLb];
        
        
    }
    [[BMPopView shareInstance] showWithContentView:shareview delegate:self];

}

-(void)shareListBtnClick:(UIButton *)sender{
    
    [[BMPopView shareInstance] dismiss];
    
    UIView *postView = [[UIView alloc]initWithFrame:CGRectMake(10, 64+10, KScreenWidth - 20, 250)];
    postView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    postView.layer.cornerRadius = 5;
    postView.layer.masksToBounds = YES;
    [BMPopView shareInstance].customFrame = YES ;
    
    
    //UIButton *cancerBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 60,30)];
    //    [cancerBtn setTitle:@"取消" forState:UIControlStateNormal];
    //    [cancerBtn addTarget:self action:@selector(cancerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *cancerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancerBtn.frame=CGRectMake(5, 5, 60,30);
    [cancerBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancerBtn addTarget:self action:@selector(cancerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    UIButton *sharePostBtn = [[UIButton alloc] initWithFrame:CGRectMake(postView.frame.size.width-70, cancerBtn.frame.origin.y, cancerBtn.frame.size.width,cancerBtn.frame.size.height)];
    //     [sharePostBtn setTitle:@"发布" forState:UIControlStateNormal];
    //    [sharePostBtn addTarget:self action:@selector(PostshareContent:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *sharePostBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sharePostBtn.frame=CGRectMake(postView.frame.size.width-70, cancerBtn.frame.origin.y, cancerBtn.frame.size.width,cancerBtn.frame.size.height);
    [sharePostBtn setTitle:@"发布" forState:UIControlStateNormal];
    sharePostBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sharePostBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sharePostBtn addTarget:self action:@selector(PostshareContent:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *TitleLb = [[UILabel alloc]initWithFrame:CGRectMake(0,5, postView.frame.size.width, 30)];
    TitleLb.text=@"分享内容";
    TitleLb.textColor = [UIColor blackColor];
    TitleLb.font = [UIFont fontWithName:@"Helvetica" size:18];
    TitleLb.textAlignment=NSTextAlignmentCenter;
    
    //添加分割线
    UIImageView *headLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, KScreenWidth,1 )];
    headLine.highlighted = YES;// flag
    headLine.image = [UIImage imageNamed:@"xian"];
    
    UILabel *SoftnameLb = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(headLine.frame)+10, postView.frame.size.width/3, 30)];
    SoftnameLb.text=@"艾检";
    SoftnameLb.textColor = [UIColor blackColor];
    SoftnameLb.font = [UIFont fontWithName:@"Helvetica" size:18];
    SoftnameLb.textAlignment=NSTextAlignmentCenter;
    
    
    UIImageView *softimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(SoftnameLb.frame), 70,70)];
    softimage.highlighted = YES;// flag
    softimage.image = [UIImage imageNamed:@"icon_zw"];
    
    subTitleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(SoftnameLb.frame),SoftnameLb.frame.origin.y, postView.frame.size.width-SoftnameLb.frame.size.width+10, 20)];
    subTitleLb.text=@"您身边的糖尿病护理专家！";
    subTitleLb.textColor = [UIColor blackColor];
    subTitleLb.font = [UIFont fontWithName:@"Helvetica" size:17];
    subTitleLb.textAlignment=NSTextAlignmentLeft;
    
    
    contentLb = [[UILabel alloc]initWithFrame:CGRectMake(subTitleLb.frame.origin.x,CGRectGetMaxY(subTitleLb.frame), subTitleLb.frame.size.width-30, 140)];
    contentLb.text=@"仅需简单一步即可实现血糖数据的无线传输;\n您可以喝家人一起管理您的血糖;\n还可以得到专业医师的远程医疗建议;\n除此之外,您还可以得到更多惊喜!";
    contentLb.textColor = [UIColor darkGrayColor];
    contentLb.font = [UIFont boldSystemFontOfSize:14.0f];
    contentLb.numberOfLines = 0;
    contentLb.lineBreakMode = 0;
    contentLb.textAlignment=NSTextAlignmentLeft;
    
    
    //拜访内容文本框
    inputTV = [[UITextView alloc]init];
    inputTV.frame = CGRectMake(10, CGRectGetMaxY(contentLb.frame),postView.frame.size.width-20,30);
    inputTV.layer.cornerRadius = 4.0f;
    inputTV.layer.masksToBounds = YES;
    inputTV.textColor = [UIColor darkGrayColor];
    inputTV.delegate=self;
    inputTV.layer.cornerRadius = 3.f;
    inputTV.layer.borderColor = [IWColor(228, 228, 228) CGColor];
    inputTV.layer.borderWidth = 1;
    
    
    
    
    
    [postView addSubview:cancerBtn];
    [postView addSubview:sharePostBtn];
    [postView addSubview:TitleLb];
    [postView addSubview:headLine];
    [postView addSubview:SoftnameLb];
    [postView addSubview:softimage];
    [postView addSubview:subTitleLb];
    [postView addSubview:contentLb];
    [postView addSubview:inputTV];
    
    
    if (sender.tag == 881) {
        
        sharePostBtn.tag = sender.tag;
        shareStatus = 1; //新浪微博
        
        [[BMPopView shareInstance] showWithContentView:postView delegate:self];
        
    }else if (sender.tag == 882){
        
        sharePostBtn.tag = sender.tag;
        shareStatus = 22; //微信好友
        [self PostshareContent:sender];
        
    }else if (sender.tag == 883){
        
        sharePostBtn.tag = sender.tag;
        shareStatus = 23; //微信朋友圈
        [self PostshareContent:sender];
        
    }else if (sender.tag == 884){
        
        sharePostBtn.tag = sender.tag;
        shareStatus = 6; //QQ空间
        [self PostshareContent:sender];
        
    }else if (sender.tag == 885){
        
        sharePostBtn.tag = sender.tag;
        shareStatus = 24; //QQ好友
        [self PostshareContent:sender];
        
    }else if (sender.tag == 886){
        
        sharePostBtn.tag = sender.tag;
        shareStatus = 2;  //腾讯微博
        
        [[BMPopView shareInstance] showWithContentView:postView delegate:self];
    }
    
}

-(void)cancerBtnClick{
    [[BMPopView shareInstance] dismiss];
}

//分享内容事件
-(void)PostshareContent:(UIButton *)sender{
    [[BMPopView shareInstance] dismiss];
    
    
    LoginInfoModel *userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    //要分享的图片Logo
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon_zw" ofType:@"png"];
    NSString *shareContentstr = [NSString stringWithFormat:@"%@\n%@\n%@",subTitleLb.text,contentLb.text,inputTV.text];
    
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:shareContentstr                                      defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:(23 == shareStatus)?shareContentstr:@"        艾检"
                                                  url:@"http://www.aconlabs.com.cn/"
                                          description:shareContentstr
                                            mediaType:SSPublishContentMediaTypeNews];
    
    
    [ShareSDK shareContent:publishContent
                      type:shareStatus
               authOptions:nil
              shareOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSPublishContentStateSuccess)
                        {
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"分享成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                            [alertView show];
                            
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"分享失败，请查看您是否安装客户端" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                            [alertView show];
                        }
                        
                    }];
    
}

/**
 *  刷新控件
 *
 */
#pragma mark---刷新数据
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = downPullToRefreshText;
    self.tableView.headerReleaseToRefreshText = ReleaseToRefreshText;
    self.tableView.headerRefreshingText = RefreshingText;
    
    self.tableView.footerPullToRefreshText = upPullToRefreshText;
    self.tableView.footerReleaseToRefreshText = ReleaseToRefreshText;
    self.tableView.footerRefreshingText = RefreshingText;
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    _pageSize = 1000;
    _totleData = _pageSize;
    [self getLineChartData];

}

- (void)footerRereshing
{
    
    if (_pageSize >= _totleData) {
        _pageSize += 1000 ;
    }
    [self getLineChartData];

    
}

@end
