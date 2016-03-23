//
//  PieChartViewController.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/12/14.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "PieChartViewController.h"
#import "DVSwitch.h"
#import "SelectDataViewController.h"
#import "BaseDataCell.h"
#import "PieChartInfo.h"
#import "PieChartModel.h"
#import "BrokenLineViewController.h"
/******/
#import "Example2PieView.h"
#import "MyPieElement.h"
#import "PieLayer.h"
/******/

#import "CycleScrollView.h"
#import "BMPopView.h"
#import "LoginInfoModel.h"
#import "LoginInfoData.h"

#define Kpading 60
@interface PieChartViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,WebServiceDelegate,BMPopViewDelegate,UITextViewDelegate>
{
   
   
    
//    UIScrollView *_scrollView;
    CycleScrollView *_scrollView;

    
    
    NSMutableArray *imgArr;//对应的图片
    
    

   
    
    //切换饼状图按钮
    UIButton *leftBtn;
    UIButton *rightBtn;
    
//    int _index;
    
    DVSwitch *secondSwitch;
    
    UILabel *redLb;
    UILabel *greenLB;
    UILabel *blueLB;
    UIView *midView;
    
    int shareStatus; //分享平台类型
    UITextView *inputTV;//分享视图的输入筐
    UILabel *subTitleLb; //分享界面的副标题
    UILabel *contentLb; //分享界面的内容label
    
    LoginInfoModel *userinfo;
    
    
        
}
@property (nonatomic,copy) NSString *begindate;
@property (nonatomic,copy) NSString *enddate;
@property (nonatomic,retain) NSMutableArray *dataArr;//存放请求返回的数据数组
@property (nonatomic,retain) NSMutableArray *titltArr;//随机、空腹、餐前、餐后、所有
@property (nonatomic,retain) UILabel *titltLB;
@property (nonatomic,assign) int index;
@property (nonatomic,retain) NSMutableArray *viewsArr;//存放5个饼状图
@property (nonatomic,strong) UITableView *tableView;



@property (nonatomic,strong) Example2PieView *pieView1;

@end

@implementation PieChartViewController

- (void )viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self createHeaderView];
    
    
}

//-(void)viewDidAppear:(BOOL)animated{
//   
//     [super viewDidAppear:animated];
//    self.secondSwitchStatusstr  = self.Statusstr;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    _viewsArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:229/255.0 blue:228/255.0 alpha:1.0];
    
    self.navigationController.navigationBarHidden = NO;
    self.edgesForExtendedLayout = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.currenttimerstr =[NSString stringWithFormat:@"%@",[defaults objectForKey:@"Piecurrenttimerstr"]];
    self.secondSwitchStatusstr  =[NSString stringWithFormat:@"%@",[defaults objectForKey:@"PiesecondSwitchStatusstr"]];
    self.timerString =[NSString stringWithFormat:@"%@",[defaults objectForKey:@"PietimerString"]];

    
    if ( [self.currenttimerstr isEqualToString:@"(null)"] ) {
        self.currenttimerstr =nil;
    }
    if ([self.secondSwitchStatusstr isEqualToString:@"(null)"]){
        self.secondSwitchStatusstr = nil;
    }
    if ([self.timerString isEqualToString:@"(null)"]){
        self.timerString = nil;
    }

    
    
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
    if (self.isme==YES) {
        UIBarButtonItem *righButtonitemt  = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
        self.navigationItem.rightBarButtonItem=righButtonitemt;
    }
   
    //切换饼图的按钮
    leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, (KScreenWidth- 60)*0.5 +20, 15,20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"zuojiantou"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(previousClick) forControlEvents:UIControlEventTouchUpInside];
//    leftBtn.enabled = NO;
    [self.view addSubview:leftBtn];
    
    rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 20, (KScreenWidth- 60)*0.5 +20, 15, 20)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"youjiantou"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
    /******请求数据******/

    /*系统当前日期*/
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    _enddate =[dateformatter stringFromDate:senddate];
    
    /*7天前日期*/
    NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*7];
    
    NSDateFormatter  *dateformatter1=[[NSDateFormatter alloc] init];
    
    [dateformatter1 setDateFormat:@"yyyy-MM-dd"];
    
    _begindate =[dateformatter1 stringFromDate:begindateCST];
    
    _titltLB = [[UILabel alloc ] initWithFrame:CGRectMake(0, 35, KScreenWidth, 30)];
    _titltLB.text = @"随机";
    _titltLB.textAlignment = NSTextAlignmentCenter;
    _titltLB.font = [UIFont systemFontOfSize:14];
    _titltLB.textColor = [UIColor lightGrayColor];
    [self.view addSubview:_titltLB];

    _titltArr = [NSMutableArray arrayWithObjects:@"所有",@"空腹",@"餐前",@"餐后",@"随机", nil];
    imgArr = [NSMutableArray arrayWithObjects:@"suoyou",@"tomato",@"pizza",@"bear",@"ball", nil];
    /*请求7天得数据*/
    [self getPieChartData];
    
    
    /*饼图*/
    [self createScrollView];
    
    [self createMainTableView];
    
}

/**
 *  饼状图
 */
#pragma mark 饼状图
- (void)createScrollView
{
    
    _scrollView = [[CycleScrollView alloc]initWithFrame:CGRectMake(30 , 20+10, KScreenWidth-60, KScreenWidth - 60)];
    [self.view addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor clearColor];
    
    __weak PieChartViewController *wSelf = self;
    _scrollView.totalPagesCount = ^NSInteger(void){
        return wSelf.viewsArr.count;
    };
    
    _scrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return wSelf.viewsArr[pageIndex];
    };
    
    //    self.rollingSV.TapActionBlock = ^(NSInteger pageIndex){
    //        NSLog(@"点击了第%ld个",(long)pageIndex);
    //    };
    _scrollView.currentPageBlock = ^(NSInteger currentPage){
        wSelf.index = currentPage;
        wSelf.titltLB.text = wSelf.titltArr[wSelf.index];
        
        
        NSArray *arr = wSelf.dataArr[wSelf.index];
        if (arr.count == 1) {
            [wSelf createMidView:@"0.00%" greenStr:@"0.00%" blueStr:@"0.00%"];
        }
        else
        {
            [wSelf createMidView:arr[0] greenStr:arr[2] blueStr:arr[1]];
        }

        [wSelf.tableView reloadData];

    };

    _scrollView.tag = 321;
    
    /*
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(30 , 20, KScreenWidth-60, KScreenWidth - 60)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentOffset = CGPointMake(0, KScreenWidth -60);
    _scrollView.contentSize =CGSizeMake((KScreenWidth - 60)*5, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.tag = 321;
    [self.view addSubview:_scrollView];
     */
}

- (void)createPieChartView
{
    /***********/
    UIColor *pieRedColor = [UIColor colorWithRed:251/255.0 green:64/255.0 blue:69/255.0 alpha:1.0];
    UIColor *pieGreenColor = [UIColor colorWithRed:23/255.0 green:144/255.0 blue:110/255.0 alpha:1.0];
    UIColor *pieBlueColor = [UIColor colorWithRed:105/255.0 green:168/255.0 blue:249/255.0 alpha:1.0];
    
    NSMutableArray *pieColorArr = [NSMutableArray arrayWithObjects:pieRedColor,pieBlueColor,pieGreenColor, nil];
    
    [_viewsArr removeAllObjects];;
    
    for (int i = 0; i < _dataArr.count; i++) {
        
        _pieView1 = [[Example2PieView alloc] initWithFrame:CGRectMake(0/*i * (KScreenWidth-60)*/, 20, KScreenWidth-60, KScreenWidth-60)];
        _pieView1.clearsContextBeforeDrawing = YES;
        _pieView1.backgroundColor = [UIColor clearColor];
        
        _pieView1.layer.transformTitleBlock = ^(PieElement* elem){
            return [(MyPieElement*)elem title];
        };
//        _pieView1.layer.showTitles = ShowTitlesAlways;//一直有标题
        
        _pieView1.layer.showTitles = ShowTitlesNever;

        for (int j = 0; j<[_dataArr[i] count]; j++) {
            MyPieElement* elem;
            if ([_dataArr[i] count] == 1) {
                
                elem = [MyPieElement pieElementWithValue:[_dataArr[i][j] integerValue]color:pieGreenColor];
                [_pieView1.layer addValues:@[elem] animated:NO];

                for (int k = 0; k < 2; k++) {
                    elem = [MyPieElement pieElementWithValue:0 color:pieColorArr[j]];
                    [_pieView1.layer addValues:@[elem] animated:NO];

                }
                
            }else{
                elem = [MyPieElement pieElementWithValue:[_dataArr[i][j] integerValue]color:pieColorArr[j]];
                elem.title = [NSString stringWithFormat:@"(%@)",_dataArr[i][j]];
                
                [_pieView1.layer addValues:@[elem] animated:NO];
            }
            
        }
        
        [_viewsArr addObject:_pieView1];
        
    }
    [_scrollView setTheTotalPageCount:_viewsArr.count];
    /************/
}

/***随机色***/ //没用到
- (UIColor*)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

#pragma mark 通知带回来得数据
/***自定义按钮界面带回来的数据***/
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
        dataArr = @[@"7", @"14", @"30", @"60", @"90",@"自定义",@"折线图"];
    }
    else
    {
        dataArr = @[@"7", @"14", @"30", @"60", @"90",self.timerString,@"自定义",@"折线图"];
    }

    if (secondSwitch) {
        [secondSwitch removeFromSuperview];
    }
    secondSwitch = [DVSwitch switchWithStringsArray:dataArr];
    secondSwitch.frame = CGRectMake(0, 0, KScreenWidth, 40);
    secondSwitch.backgroundColor = [UIColor whiteColor];
    secondSwitch.sliderColor = KCommonColor;
    secondSwitch.labelTextColorInsideSlider = [UIColor whiteColor];
    secondSwitch.labelTextColorOutsideSlider = KCommonColor;
    secondSwitch.cornerRadius = 0;
    [secondSwitch setFont:[UIFont systemFontOfSize:13]];//设置选择控件的字体大小
  
    if (self.currenttimerstr != nil) {
        [secondSwitch forceSelectedIndex:5 animated:YES];
    }else{
            if (self.secondSwitchStatusstr==nil) {
             
                [secondSwitch forceSelectedIndex:0 animated:YES];
        
            }else{
           
                [secondSwitch forceSelectedIndex:[self.secondSwitchStatusstr integerValue] animated:YES];
        }
    }
    __weak PieChartViewController *wSelf = self;

    [secondSwitch setPressedHandler:^(NSUInteger index) {
      //
//        secondSwitchStatusstr = [NSString stringWithFormat:@"%lu",(unsigned long)index];
      //  NSString *status = [NSString stringWithFormat:@"%ld",(long)[secondSwitchStatusstr integerValue]];
        NSLog(@"选择: %lu", (unsigned long)index);
        switch (index) {
            case 0:
            {
                wSelf.secondSwitchStatusstr = @"0";
                wSelf.currenttimerstr = nil;
                
                NSDate *senddate=[NSDate date];
                
                NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*7];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"yyyy-MM-dd"];
                
                wSelf.begindate =[dateformatter stringFromDate:begindateCST];
                [wSelf getPieChartData];
                for (_pieView1 in _viewsArr) {
                    [_pieView1 removeFromSuperview];
                    _pieView1 = nil;
                }
                
                
                [self createPieChartView];
                [_viewsArr removeAllObjects];
//                _scrollView.contentOffset = CGPointMake(0, 0);
                _index = 0;
//                leftBtn.enabled = NO;
                _titltLB.text = _titltArr[_index];

            }
                break;
            case 1:
            {
                wSelf.secondSwitchStatusstr = @"1";
                wSelf.currenttimerstr = nil;
                
                NSDate *senddate=[NSDate date];
                
                NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*14];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"yyyy-MM-dd"];
                
                _begindate =[dateformatter stringFromDate:begindateCST];

                [self getPieChartData];
                for (_pieView1 in _viewsArr) {
                    [_pieView1 removeFromSuperview];
                    _pieView1 = nil;
                }
                
                
                [self createPieChartView];
                [_viewsArr removeAllObjects];
                //                _scrollView.contentOffset = CGPointMake(0, 0);
                _index = 0;
                //                leftBtn.enabled = NO;
                _titltLB.text = _titltArr[_index];

            }
                break;
            case 2:
            {
                wSelf.secondSwitchStatusstr = @"2";
                wSelf.currenttimerstr = nil;
                
                NSDate *senddate=[NSDate date];
                
                NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*30];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"yyyy-MM-dd"];
                
                _begindate =[dateformatter stringFromDate:begindateCST];
                
                
                [self getPieChartData];
                for (_pieView1 in _viewsArr) {
                    [_pieView1 removeFromSuperview];
                    _pieView1 = nil;
                }
                
                
                [self createPieChartView];
                [_viewsArr removeAllObjects];
                //                _scrollView.contentOffset = CGPointMake(0, 0);
                _index = 0;
                //                leftBtn.enabled = NO;
                _titltLB.text = _titltArr[_index];

            }
                break;
            case 3:
            {
                wSelf.secondSwitchStatusstr = @"3";
                wSelf.currenttimerstr = nil;
                
                NSDate *senddate=[NSDate date];
                
                NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*60];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"yyyy-MM-dd"];
                
                _begindate =[dateformatter stringFromDate:begindateCST];
                
                [self getPieChartData];
                for (_pieView1 in _viewsArr) {
                    [_pieView1 removeFromSuperview];
                    _pieView1 = nil;
                }
                
                
                [self createPieChartView];
                [_viewsArr removeAllObjects];
                //                _scrollView.contentOffset = CGPointMake(0, 0);
                _index = 0;
                //                leftBtn.enabled = NO;
                _titltLB.text = _titltArr[_index];

            }
                break;
                
            case 4:
            {
                wSelf.secondSwitchStatusstr = @"4";
                wSelf.currenttimerstr = nil;
                
                NSDate *senddate=[NSDate date];
                
                NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*90];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"yyyy-MM-dd"];
                
                _begindate =[dateformatter stringFromDate:begindateCST];
                
                [self getPieChartData];
                for (_pieView1 in _viewsArr) {
                    [_pieView1 removeFromSuperview];
                    _pieView1 = nil;
                }
                
                
                [self createPieChartView];
                [_viewsArr removeAllObjects];
                //                _scrollView.contentOffset = CGPointMake(0, 0);
                _index = 0;
                //                leftBtn.enabled = NO;
                _titltLB.text = _titltArr[_index];

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
                    
                    _begindate =[dateformatter stringFromDate:begindateCST];
                    
                    [self getPieChartData];
                    for (_pieView1 in _viewsArr) {
                        
                        [_pieView1 removeFromSuperview];
                        _pieView1 = nil;
                    }
                    
                    
                    [self createPieChartView];
                    [_viewsArr removeAllObjects];
                    //                _scrollView.contentOffset = CGPointMake(0, 0);
                    _index = 0;
                    //                leftBtn.enabled = NO;
                    _titltLB.text = _titltArr[_index];


                }
                
            }
                break;
            case 6:
            {
                
                
                if (self.timerString ==nil) {
                  
                    BrokenLineViewController *pic = [[BrokenLineViewController alloc]init];
                    if (self.isme==YES) {
                        pic.isme = YES;
                    }
                    else
                    {
                        pic.isme = NO;
                    }
                    pic.secondSwitchStatus = self.secondSwitchStatusstr;
                    [self.navigationController pushViewController: pic animated:YES];
        
                }
                else
                {
                    //self.secondSwitchStatusstr = nil;
                    SelectDataViewController *vc = [[SelectDataViewController alloc] init];
                    [self.navigationController pushViewController: vc animated:YES];
                }
                
            }
                break;
            case 7:
            {
                ZWLog(@"折线图啦啦啦啦");
                BrokenLineViewController *pic = [[BrokenLineViewController alloc]init];
                if (_isme) {
                    pic.isme = YES;
                }
                else
                {
                    pic.isme = NO;
                }
                pic.timerString = self.timerString;
                pic.currenttimerstr = self.currenttimerstr;
                pic.secondSwitchStatus = self.secondSwitchStatusstr;
                [self.navigationController pushViewController: pic animated:YES];
                
            }
            default:
                break;
        }

        NSUserDefaults *defaults11 = [NSUserDefaults standardUserDefaults];
        [defaults11 setObject:self.currenttimerstr forKey:@"Piecurrenttimerstr"];
        [defaults11 synchronize];
        
        NSUserDefaults *defaults22= [NSUserDefaults standardUserDefaults];
        [defaults22 setObject:self.secondSwitchStatusstr forKey:@"PiesecondSwitchStatusstr"];
        [defaults22 synchronize];
        
        NSUserDefaults *defaults33= [NSUserDefaults standardUserDefaults];
        [defaults33 setObject:self.timerString forKey:@"PietimerString"];
        [defaults33 synchronize];

    }];
    

    [self.view addSubview:secondSwitch];
    
}

- (void)createMidView:(NSString *)redStr greenStr:(NSString *)greenStr blueStr:(NSString *)blueStr
{
    
    CGFloat midY = CGRectGetMaxY(_pieView1.frame)+5;
    if (!midView) {
         midView = [[UIView alloc] initWithFrame:CGRectMake(0, midY + 3 ,KScreenWidth, 20)];
        [self.view addSubview:midView];
    }

    UIImageView *redImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0 ,12, 12)];
    redImg.image = [UIImage imageNamed:@"juxing_zw"];
    [midView addSubview:redImg];
    
    if (!redLb) {
        redLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(redImg.frame), -3, 100, 20)];
        redLb.font = [UIFont systemFontOfSize:10];
        redLb.text = [NSString stringWithFormat:@"代表偏高(%@)",redStr];
        [midView addSubview:redLb];
    }
    else
    {
         redLb.text = [NSString stringWithFormat:@"代表偏高(%@)",redStr];
    }

    UIImageView *greenImg = [[UIImageView alloc] initWithFrame:CGRectMake(120, 0 ,12, 12)];
    greenImg.image = [UIImage imageNamed:@"lvse"];
    [midView addSubview:greenImg];
    
    if (!greenLB) {
        greenLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(greenImg.frame), -3, 100, 20)];
        greenLB.font = [UIFont systemFontOfSize:10];
        greenLB.text = [NSString stringWithFormat:@"代表正常(%@)",greenStr];
        [midView addSubview:greenLB];
    }
    else
    {
        greenLB.text = [NSString stringWithFormat:@"代表正常(%@)",greenStr];
    }
   
    
    UIImageView *blueImg = [[UIImageView alloc] initWithFrame:CGRectMake(220, 0 ,12, 12)];
//    blueImg.image = [UIImage imageNamed:@"lanse"];
    blueImg.backgroundColor = [UIColor colorWithRed:105/255.0 green:168/255.0 blue:249/255.0 alpha:1.0];
    [midView addSubview:blueImg];
    if (!blueLB) {
        blueLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(blueImg.frame), -3, 100, 20)];
        blueLB.font = [UIFont systemFontOfSize:10];
        blueLB.text = [NSString stringWithFormat:@"代表偏低(%@)",blueStr];
        [midView addSubview:blueLB];
    }
    else
    {
        blueLB.text = [NSString stringWithFormat:@"代表偏低(%@)",blueStr];
    }

}

/**
 *  表视图
 *
 *  @return 表视图
 */
#pragma mark TableView
- (void)createMainTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KScreenWidth-40+30, KScreenWidth, KScreenHeight - (KScreenWidth-40) - 64 -30)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    
    UIView *tableLine = [[UIView alloc] initWithFrame:CGRectMake(10, 0, KScreenWidth - 20, 1)];
    tableLine.backgroundColor = [UIColor lightGrayColor];
    [self.tableView addSubview:tableLine];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.去缓存池中取出cell
    static NSString *ID = @"BaseDataCell";
    BaseDataCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    // 2.缓存池没有cell，重新创建cell
    if (cell == nil) {
        cell = [[BaseDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    if (_index == indexPath.row) {
        
        cell.backgroundColor = [UIColor colorWithRed:170/255.0 green:244/255.0 blue:254/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.firstLB.text = _titltArr[indexPath.row];
    cell.firstImg.image = [UIImage imageNamed:imgArr[indexPath.row]];
    if ([_dataArr[indexPath.row] count] > 1) {
        
        cell.secondLB.text = _dataArr[indexPath.row][2];
        cell.thirdLB.text = _dataArr[indexPath.row][1];
        cell.fourLB.text = _dataArr[indexPath.row][0];
    }
    else
    {
        cell.secondLB.text = @"0.00%";
        cell.thirdLB.text = @"0.00%";
        cell.fourLB.text = @"0.00%";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_scrollView setcurPages:indexPath.row];
//    [_scrollView setcurPages:indexPath.row+1];
//    _scrollView.contentOffset = CGPointMake(indexPath.row * (KScreenWidth -60), 0);
    
    NSArray *arr = _dataArr[indexPath.row];
    if (arr.count == 1) {
        [self createMidView:@"0.00%" greenStr:@"0.00%" blueStr:@"0.00%"];
    }
    else
    {
        [self createMidView:arr[0] greenStr:arr[2] blueStr:arr[1]];
    }
    
}

/**
 *  请求饼状图数据
 */
- (void)getPieChartData
{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    WebServices *service = [[WebServices alloc] init];
    LoginInfoModel *userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    NSMutableArray *arr=[NSMutableArray array];
    
    if (_otheridstr==nil) {
        [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:userinfo.data.dataIdentifier,@"u_Id", nil]];
    }else{
        [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:_otheridstr,@"u_Id", nil]];
    }
    
    //[arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:userinfo.data.dataIdentifier,@"u_Id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:_begindate,@"beginTime", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:_enddate,@"endTime", nil]];
    
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetUserGlocuseListPieMethodName];
    __weak PieChartViewController *wself = self;
    [service asyncServiceUrl:GetGlucoseWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetUserGlocuseListPieMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:wself.view animated:YES];
        
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            PieChartInfo *info = [[PieChartInfo alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                //所有
                NSMutableArray *dataAllArr;
                if ([info.data.hightValAll integerValue]==0 && [info.data.lowerValAll integerValue]==0 && [info.data.regularValAll integerValue]==0) {
                    dataAllArr = [NSMutableArray arrayWithObject:@"1"];
                }else{
                    dataAllArr = [NSMutableArray arrayWithObjects:info.data.hightValAll,info.data.lowerValAll,info.data.regularValAll, nil];
                }
                
                //随机
                NSMutableArray *dataRandomArr;
                if ([info.data.hightVal4 integerValue] ==0&& [info.data.lowerVal4 integerValue]==0 && [info.data.regularVal4 integerValue]==0) {
                    dataRandomArr = [NSMutableArray arrayWithObject:@"1"];
                }else{
                    dataRandomArr = [NSMutableArray arrayWithObjects:info.data.hightVal4,info.data.lowerVal4,info.data.regularVal4, nil];
                }
                
                //空腹
                NSMutableArray *dataLimosisArr;
                if ([info.data.hightVal3 integerValue]==0 && [info.data.lowerVal3 integerValue]==0 && [info.data.regularVal3 integerValue]==0) {
                    dataLimosisArr = [NSMutableArray arrayWithObject:@"1"];
                }else{
                    dataLimosisArr = [NSMutableArray arrayWithObjects:info.data.hightVal3,info.data.lowerVal3,info.data.regularVal3, nil];
                }
                //餐前
                NSMutableArray *dataBeforeArr;
                if ([info.data.hightVal1 integerValue]==0 && [info.data.lowerVal1 integerValue]==0 && [info.data.regularVal1 integerValue]==0) {
                    dataBeforeArr = [NSMutableArray arrayWithObject:@"1"];
                }else{
                    dataBeforeArr = [NSMutableArray arrayWithObjects:info.data.hightVal1,info.data.lowerVal1,info.data.regularVal1, nil];
                }
                //餐后
                NSMutableArray *dataAfterArr;
                if ([info.data.hightVal2 integerValue]==0 && [info.data.lowerVal2 integerValue] ==0&& [info.data.regularVal2 integerValue] ==0) {
                    
                    dataAfterArr = [NSMutableArray arrayWithObject:@"1"];
                }else{
                    dataAfterArr = [NSMutableArray arrayWithObjects:info.data.hightVal2,info.data.lowerVal2,info.data.regularVal2, nil];
                }
                
                _dataArr = [NSMutableArray arrayWithObjects:dataAllArr,dataLimosisArr,dataBeforeArr,dataAfterArr,dataRandomArr, nil];
                //所有、空腹，餐前，餐后，随机
                [wself.tableView reloadData];
                
                [self createPieChartView];
                
                NSArray *arr = _dataArr[_index];
                if (arr.count == 1) {
                    [self createMidView:@"0.00%" greenStr:@"0.00%" blueStr:@"0.00%"];
                }
                else
                {
                    [self createMidView:_dataArr[0][0] greenStr:_dataArr[0][2] blueStr:_dataArr[0][1]];
                }
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

-(void)clickshareBtn{
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
    sinaBtn.tag = 771;
    
    UILabel *sinaLb = [[UILabel alloc] initWithFrame:CGRectMake(sinaBtn.frame.origin.x, CGRectGetMaxY(sinaBtn.frame), sinaBtn.frame.size.width, 20)];
    sinaLb.text = @"新浪微博";
    sinaLb.font = [UIFont systemFontOfSize:14];
    sinaLb.textAlignment = NSTextAlignmentCenter;
    
    
    //微信好友按钮
    UIButton *weixinFriendsBtn = [[UIButton alloc] initWithFrame:CGRectMake(30 + CGRectGetMaxX(sinaBtn.frame), sinaBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height)];
    [weixinFriendsBtn setBackgroundImage:[UIImage imageNamed:@"wx"] forState:UIControlStateNormal];
    [weixinFriendsBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    weixinFriendsBtn.tag = 772;
    
    UILabel *weixinFriendsLb = [[UILabel alloc] initWithFrame:CGRectMake(weixinFriendsBtn.frame.origin.x, CGRectGetMaxY(weixinFriendsBtn.frame), weixinFriendsBtn.frame.size.width, sinaLb.frame.size.height)];
    weixinFriendsLb.text = @"微信好友";
    weixinFriendsLb.font = [UIFont systemFontOfSize:14];
    weixinFriendsLb.textAlignment = NSTextAlignmentCenter;
    
    
    //微信朋友圈按钮
    UIButton *weixinPeopleBtn = [[UIButton alloc] initWithFrame:CGRectMake(30 + CGRectGetMaxX(weixinFriendsBtn.frame), sinaBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height)];
    [weixinPeopleBtn setBackgroundImage:[UIImage imageNamed:@"pyq"] forState:UIControlStateNormal];
    [weixinPeopleBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    weixinPeopleBtn.tag = 773;
    
    UILabel *weixinPeopleLb = [[UILabel alloc] initWithFrame:CGRectMake(weixinPeopleBtn.frame.origin.x-4, CGRectGetMaxY(weixinPeopleBtn.frame), sinaBtn.frame.size.width+10, sinaLb.frame.size.height)];
    weixinPeopleLb.text = @"微信朋友圈";
    weixinPeopleLb.font = [UIFont systemFontOfSize:14];
    weixinPeopleLb.textAlignment = NSTextAlignmentCenter;
    
    
    //QQ空间按钮
    UIButton *qqSpaceBtn = [[UIButton alloc] initWithFrame:CGRectMake(sinaBtn.frame.origin.x, CGRectGetMaxY(sinaBtn.frame)+40, sinaBtn.frame.size.width, sinaBtn.frame.size.height)];
    [qqSpaceBtn setBackgroundImage:[UIImage imageNamed:@"kongjian"] forState:UIControlStateNormal];
    [qqSpaceBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    qqSpaceBtn.tag = 774;
    
    UILabel *qqSpaceLb = [[UILabel alloc] initWithFrame:CGRectMake(qqSpaceBtn.frame.origin.x, CGRectGetMaxY(qqSpaceBtn.frame), sinaBtn.frame.size.width, sinaLb.frame.size.height)];
    qqSpaceLb.text = @"QQ空间";
    qqSpaceLb.font = [UIFont systemFontOfSize:14];
    qqSpaceLb.textAlignment = NSTextAlignmentCenter;
    
    
    //QQ好友按钮
    UIButton *qqFriendsBtn = [[UIButton alloc] initWithFrame:CGRectMake(weixinFriendsBtn.frame.origin.x , qqSpaceBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height)];
    [qqFriendsBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [qqFriendsBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    qqFriendsBtn.tag = 775;
    
    UILabel *qqFriendsLb = [[UILabel alloc] initWithFrame:CGRectMake(qqFriendsBtn.frame.origin.x, CGRectGetMaxY(qqFriendsBtn.frame), sinaBtn.frame.size.width, sinaLb.frame.size.height)];
    qqFriendsLb.text = @"QQ好友";
    qqFriendsLb.font = [UIFont systemFontOfSize:14];
    qqFriendsLb.textAlignment = NSTextAlignmentCenter;
    
    
    //腾讯微博按钮
    UIButton *tencentWeiboBtn = [[UIButton alloc] initWithFrame:CGRectMake(weixinPeopleBtn.frame.origin.x, qqSpaceBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height)];
    [tencentWeiboBtn setBackgroundImage:[UIImage imageNamed:@"wb"] forState:UIControlStateNormal];
    [tencentWeiboBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    tencentWeiboBtn.tag = 776;
    
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
    
    
    if (sender.tag == 771) {
        
        sharePostBtn.tag = sender.tag;
        NSLog(@"%ld",(long)sharePostBtn.tag);
        shareStatus = 1; //新浪微博
        
        [[BMPopView shareInstance] showWithContentView:postView delegate:self];
        
    }else if (sender.tag == 772){
        
        sharePostBtn.tag = sender.tag;
        NSLog(@"%ld",(long)sharePostBtn.tag);
        shareStatus = 22; //微信好友
        [self PostshareContent:sender];
        
    }else if (sender.tag == 773){
        
        sharePostBtn.tag = sender.tag;
        NSLog(@"%ld",(long)sharePostBtn.tag);
        shareStatus = 23; //微信朋友圈
        [self PostshareContent:sender];
        
    }else if (sender.tag == 774){
        
        sharePostBtn.tag = sender.tag;
        NSLog(@"%ld",(long)sharePostBtn.tag);
        shareStatus = 6; //QQ空间
        [self PostshareContent:sender];
        
    }else if (sender.tag == 775){
        
        sharePostBtn.tag = sender.tag;
        NSLog(@"%ld",(long)sharePostBtn.tag);
        shareStatus = 24; //QQ好友
        [self PostshareContent:sender];
        
    }else if (sender.tag == 776){
        
        sharePostBtn.tag = sender.tag;
        NSLog(@"%ld",(long)sharePostBtn.tag);
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
    
    NSLog(@"%d",sender.tag);
   
    LoginInfoModel *userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    //要分享的图片Logo
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon_zw" ofType:@"png"];
    NSString *shareContentstr = [NSString stringWithFormat:@"%@\n%@\n%@",subTitleLb.text,contentLb.text,inputTV.text];
    
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:shareContentstr                                      defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:(23 == shareStatus)?shareContentstr:@"        艾检"
                                                  url:@"http://www.aconlabs.com.cn/"//userinfo.data.portraitURL
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
                            
                            
                                NSLog( @"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"分享失败，请查看您是否安装客户端" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                [alertView show];
    
                           
                        }
                        
                    }];
   
}



- (void)previousClick
{
        _index --;
        if (_index<0) {
            _index = 4;
        }
        [_scrollView lastPage];
        _titltLB.text = _titltArr[_index];
    
    [_tableView reloadData];
}

- (void)nextClick
{
    _index ++;
    if (_index>=5) {
        _index = 0;
    }

    [_scrollView nestPage];
    _titltLB.text = _titltArr[_index];
    
    [_tableView reloadData];
    
}



#pragma mark 当scrollView正在滚动的时候调用
//- (void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView didSelectImageView:(int)index;
- (void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView didScrollImageView:(int)index
{
        _index = index;
        _titltLB.text = _titltArr[_index];
        
        
        NSArray *arr = _dataArr[_index];
        if (arr.count == 1) {
            [self createMidView:@"0.00%" greenStr:@"0.00%" blueStr:@"0.00%"];
        }
        else
        {
            [self createMidView:arr[0] greenStr:arr[2] blueStr:arr[1]];
        }
        /*
        if (_index == 0) {
            leftBtn.enabled = NO;
            rightBtn.enabled = YES;
            
        }
        else if(_index ==4)
        {
            rightBtn.enabled = NO;
            leftBtn.enabled = YES;
            
        }
        else
        {
            leftBtn.enabled = YES;
            rightBtn.enabled = YES;
        }*/
        [_tableView reloadData];
    
    
}


/****************************************************************************/
@end
