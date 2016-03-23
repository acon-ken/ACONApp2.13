//
//  DataListViewController.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/12/8.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "DataListViewController.h"
#import "HomeViewController.h"
#import "DVSwitch.h"
#import "DataCell.h"
#import "LoginInfoModel.h"

#import "DataListInfo.h"
#import "DataListModel.h"

#import "GetGlucoseSetModel.h"
#import "GetGlucoseSetData.h"

#import "SelectDataViewController.h"
#import "DataChangeControllerView.h"

#import <MessageUI/MFMailComposeViewController.h>//邮件
#import "MFMailComposeViewController+EndEditing.h"

#define KBlueColor [UIColor colorWithRed:87/255.0 green:152/255.0 blue:249/255.0 alpha:1.0]
#define KGreenColor [UIColor colorWithRed:61/255.0 green:208/255.0 blue:162/255.0 alpha:1.0]

@interface DataListViewController ()<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
{
    NSString *begindate;
    NSString *enddate;
    
    NSMutableArray *_dataListArr;
    
    NSString *  timerString;
    
    LoginInfoModel *userinfo;
    
    MFMailComposeViewController *picker;
    
    int  pageindex;
    
    NSString *GetmaxStr; //通过接口获取来的最大值
    NSString *GetminStr;  //通过接口获取来的最小值
    
    NSString *HTMLStr;
    
    NSString *secondSwitchStatusstr; //饼状图选择天数控件的状态
    
    NSString * currenttimerstr;// 用来暂时存放自定义时间的字符串
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation DataListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KBackgroundColor;
    self.title = @"数据列表";
    
     helper = [[WebServices alloc] initWithDelegate:self];
    userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    self.navigationController.navigationBarHidden = NO;
    self.edgesForExtendedLayout = NO;
        
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    
    //给导航栏加右侧按钮
    UIButton *exportBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [exportBtn setTitle:@"导出" forState:UIControlStateNormal];
    [exportBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [exportBtn  addTarget:self action:@selector(exportBtn) forControlEvents:UIControlEventTouchUpInside];
    exportBtn.selected = YES;
    
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
    UIBarButtonItem *righButtonitemt  = [[UIBarButtonItem alloc] initWithCustomView:exportBtn];
    self.navigationItem.rightBarButtonItem=righButtonitemt;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    currenttimerstr =[NSString stringWithFormat:@"%@",[defaults objectForKey:@"currenttimerstr"]];
    secondSwitchStatusstr  =[NSString stringWithFormat:@"%@",[defaults objectForKey:@"secondSwitchStatusstr"]];
    timerString =[NSString stringWithFormat:@"%@",[defaults objectForKey:@"timerString"]];
    
    if ([currenttimerstr isEqualToString:@"(null)"]) {
        currenttimerstr =nil;
    }
    if ([secondSwitchStatusstr isEqualToString:@"(null)"]){
        secondSwitchStatusstr = nil;
    }
    if ([timerString isEqualToString:@"(null)"]){
        timerString = nil;
    }
    
    //根据用户Id获取用户设置血糖的最高和最低
    [self  postGetGlucoseSet];
    
    [self createHeaderView];
    [self createTableView];
    
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
    
    /*请求7天得数据*/
    pageindex = 1;
    [self setupRefresh];
    [self getDataList:1];
}

-(void)receiveIdexx:(NSNotification *)not{
    timerString = not.object;
    if ([timerString isEqualToString:@"0"]){
        
        timerString=nil;
    
    }
    if (timerString !=nil) {
        currenttimerstr = timerString;
    }
}



- (void )viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self createHeaderView];
    [self getDataList:1];
 }
- (void)createHeaderView
{
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveIdexx:) name:@"senderData" object:Nil];
   /*****/
    NSArray *dataArr;
    if (timerString == nil) {
        dataArr = @[@"7", @"14", @"30", @"60", @"90",@"自定义"];
    }
    else
    {
        dataArr = @[@"7", @"14", @"30", @"60", @"90",timerString,@"自定义"];
    }
     DVSwitch *secondSwitch ;

    //timerString = @"自定义";
    secondSwitch = [DVSwitch switchWithStringsArray:dataArr];
    secondSwitch.frame = CGRectMake(0, 0, KScreenWidth, 40);
    secondSwitch.backgroundColor = [UIColor whiteColor];
    secondSwitch.sliderColor = KCommonColor;
    secondSwitch.labelTextColorInsideSlider = [UIColor whiteColor];
    secondSwitch.labelTextColorOutsideSlider = KCommonColor;
    secondSwitch.cornerRadius = 0;

    if (currenttimerstr !=nil) {
    
        
               [secondSwitch forceSelectedIndex:5 animated:YES];
    }else{
        
        if (secondSwitchStatusstr==nil) {
            
            [secondSwitch forceSelectedIndex:0 animated:YES];
            
        }else{
            
            [secondSwitch forceSelectedIndex:[secondSwitchStatusstr integerValue] animated:YES];
        }
        
    }

    [secondSwitch setPressedHandler:^(NSUInteger index) {
        
       
        switch (index) {
            case 0:
            {
                secondSwitchStatusstr = @"0";
                currenttimerstr = nil;
                
                NSDate *senddate=[NSDate date];
                
                NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*7];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"yyyy-MM-dd"];
                
                begindate =[dateformatter stringFromDate:begindateCST];
                
                [self getDataList:1];
            }
                break;
            case 1:
            {
                secondSwitchStatusstr = @"1";
                currenttimerstr = nil;
                
                NSDate *senddate=[NSDate date];
                
                NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*14];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"yyyy-MM-dd"];
                
                begindate =[dateformatter stringFromDate:begindateCST];
                
                [self getDataList:1];
            }
                break;
            case 2:
            {
                secondSwitchStatusstr = @"2";
                currenttimerstr = nil;
                
                NSDate *senddate=[NSDate date];
                
                NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*30];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"yyyy-MM-dd"];
                
                begindate =[dateformatter stringFromDate:begindateCST];
                
                [self getDataList:1];
            }
                break;
            case 3:
            {
                secondSwitchStatusstr = @"3";
                currenttimerstr = nil;

                
                
                NSDate *senddate=[NSDate date];
                
                NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*60];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"yyyy-MM-dd"];
                
                begindate =[dateformatter stringFromDate:begindateCST];
                
                [self getDataList:1];
            }
                break;
                
            case 4:
            {
                secondSwitchStatusstr = @"4";
                currenttimerstr = nil;
                
                NSDate *senddate=[NSDate date];
                
                NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*90];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"yyyy-MM-dd"];
                
                begindate =[dateformatter stringFromDate:begindateCST];
                
                [self getDataList:1];
            }
                break;
            case 5:
            {
                
                if (timerString ==nil) {
                    
                    SelectDataViewController *vc = [[SelectDataViewController alloc] init];
                    [self.navigationController pushViewController: vc animated:YES];
                }else{
                   
                    currenttimerstr =[NSString stringWithFormat:@"%@",timerString];
                    int times = [timerString integerValue];
                    NSDate *senddate=[NSDate date];
                    NSDate *begindateCST = [senddate dateByAddingTimeInterval:-60*60*24*times];
                    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                    
                    [dateformatter setDateFormat:@"yyyy-MM-dd"];
                    
                    begindate =[dateformatter stringFromDate:begindateCST];
                    
                    [self getDataList:1];
                }
               
            }
                break;
            case 6:
            {
                
                
                SelectDataViewController *vc = [[SelectDataViewController alloc] init];
                [self.navigationController pushViewController: vc animated:YES];
                
            }
            default:
                break;
        }
        /******************* 将currenttimerstr、secondSwitchStatusstr、timerString保存到本地************************/
        NSUserDefaults *defaults11 = [NSUserDefaults standardUserDefaults];
        [defaults11 setObject:currenttimerstr forKey:@"currenttimerstr"];
        [defaults11 synchronize];
        
        NSUserDefaults *defaults22= [NSUserDefaults standardUserDefaults];
        [defaults22 setObject:secondSwitchStatusstr forKey:@"secondSwitchStatusstr"];
        [defaults22 synchronize];
        
        NSUserDefaults *defaults33= [NSUserDefaults standardUserDefaults];
        [defaults33 setObject:timerString forKey:@"timerString"];
        [defaults33 synchronize];


    }];
    [self.view addSubview:secondSwitch];
    
}
   /*****/

//创建tableview
- (void)createTableView
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(0,40, KScreenWidth, KScreenHeight - 64 - 30);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor lightTextColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
}


#pragma mark TableView

//显示多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//显示多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataListArr.count;
}

//每行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    DataCell *dataCell = [tableView dequeueReusableCellWithIdentifier:[DataCell ID]];
    if (dataCell == nil) {
        dataCell = [DataCell createDataCell];
    }
    
    if (IS_IPHONE_6) {
        dataCell.DateLB.font = [UIFont systemFontOfSize:11];
        dataCell.TimeLB.font = [UIFont systemFontOfSize:13];
        dataCell.UnitLB.font = [UIFont systemFontOfSize:13];
        dataCell.StateLB.font = [UIFont systemFontOfSize:13];
        dataCell.markLB.font = [UIFont systemFontOfSize:13];
    }
    
    /**
     *  真实数据赋值
     */
    DataListModel *model = _dataListArr[indexPath.row];
    
    dataCell.DateLB.text = model.measureTimeFormat;
    dataCell.TimeLB.text = model.measureTimeT;
    dataCell.ValueLB.text = [NSString stringWithFormat:@"%.1f",model.measureValue];
/*
    NSOrderedAscending = -1,    // < 升序
    NSOrderedSame,              // = 等于
    NSOrderedDescending   // > 降序
 
 */
    
    //当GetminStr<血糖值<GetmaxStr时给它赋绿色
    if ([dataCell.ValueLB.text compare:GetminStr options:NSNumericSearch] == NSOrderedDescending && [dataCell.ValueLB.text compare:GetmaxStr options:NSNumericSearch] == NSOrderedAscending)
    {
        dataCell.ValueLB.textColor = KGreenColor;//[UIColor greenColor];
    }
    //当血糖值<GetminStr时给它赋蓝色
    else if ([dataCell.ValueLB.text compare:GetminStr options:NSNumericSearch] == NSOrderedAscending )
    {
        dataCell.ValueLB.textColor = KBlueColor;//[UIColor blueColor];
    }
    //当血糖值>GetmaxStr时给它赋红色
    else if ([dataCell.ValueLB.text compare:GetmaxStr options:NSNumericSearch] == NSOrderedDescending)
    {
        dataCell.ValueLB.textColor = [UIColor redColor];
    }
    //当血糖值=GetminStr或者血糖值=GetmaxStr时给它赋绿色
    else if ([dataCell.ValueLB.text compare:GetminStr options:NSNumericSearch]==NSOrderedSame || [dataCell.ValueLB.text compare:GetmaxStr options:NSNumericSearch]==NSOrderedSame)
    {
        dataCell.ValueLB.textColor = KGreenColor;//[UIColor greenColor];
    }
    
    dataCell.UnitLB.text = model.unit;
    int state =  [model.periodType integerValue];
    
    switch (state) {
        case 1:
            dataCell.StateLB.text = @"餐  前";
            break;
        case 2:
            dataCell.StateLB.text = @"餐  后";
            break;
        case 3:
            dataCell.StateLB.text = @"空  腹";
            break;
        case 4:
            dataCell.StateLB.text = @"随  机";
            break;
        default:
            break;
    }
    
    //如果inputType＝1,则为手工输入；如果inputType=2,则为蓝牙录入
    if ([model.inputType isEqualToString:@"1"]) {
         dataCell.markLB.text = @"手工输入";
    }else if ([model.inputType isEqualToString:@"2"]){
         dataCell.markLB.text = @"蓝牙输入";
    }
    
    cell = dataCell;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 20)];
    headerView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
    
    NSMutableArray * itemArr =[NSMutableArray arrayWithObjects:@"日期",@"时间 ",@"血糖值",@"单位",@"时间段" ,@"标示",nil];
    for (int i=0; i < 6; i++)
    {
        UILabel *item= [[UILabel alloc] init];
        item.frame=CGRectMake(KScreenWidth/6 * i, 0, KScreenWidth/6, 30);
        item.text = itemArr[i];
        item.textColor = [UIColor lightGrayColor];
        item.font = [UIFont systemFontOfSize:14];
        item.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:item];
    }
    
    return headerView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataListModel *model = _dataListArr[indexPath.row];
    
    DataChangeControllerView *datachangeVC = [[DataChangeControllerView alloc] init];
    datachangeVC.dataModel = model;
   
    if ([model.inputType integerValue]==1) {
        [self.navigationController  pushViewController:datachangeVC animated:YES];
    }
    
    
    
}

- (void)backClick
{
    ZWLog(@"返回");
    [self.navigationController popViewControllerAnimated:YES];
    

}

- (void)exportBtn
{
    [self appendingHtml];
    ZWLog(@"导出");
//    //截图
//    UIImage *image = [self screenshot:UIDeviceOrientationPortrait
//                             isOpaque:YES
//                 usePresentationLayer:YES];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"sms.png"]];   // 保存文件的名称
//    if ([UIImagePNGRepresentation(image)writeToFile: filePath    atomically:YES]) {
//        
//        ZWLog(@"保存成功！");
//    }else{
//        
//        ZWLog(@"保存失败！");
//    }
    
    
    [self postEmail];
//    ZWLog(@"%@",image);
    
}

/*截取屏幕*/
- (UIImage *)screenshot:(UIDeviceOrientation)orientation isOpaque:(BOOL)isOpaque usePresentationLayer:(BOOL)usePresentationLayer
{
    CGSize size;
    
    if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
        size = CGSizeMake(self.tableView.frame.size.width, self.tableView.frame.size.height);
    } else {
        size = CGSizeMake(self.tableView.frame.size.width, self.tableView.frame.size.height);
    }
    
    UIGraphicsBeginImageContextWithOptions(size, isOpaque, 0.0);
    
    if (usePresentationLayer) {
        [self.view.layer.presentationLayer renderInContext:UIGraphicsGetCurrentContext()];
    } else {
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}



#pragma mark 根据用户Id获取用户设置血糖的最高和最低请求
//根据用户Id获取用户设置血糖的最高和最低请求
-(void)postGetGlucoseSet{
    WebServices *service = [[WebServices alloc] init];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:userinfo.data.dataIdentifier,@"u_Id", nil]];
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetGlucoseSetMethodName];
    [service asyncServiceUrl:GetGlucoseWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetGlucoseSetMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            GetGlucoseSetModel *info = [[GetGlucoseSetModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
                GetmaxStr = [NSString stringWithFormat:@"%.1f",info.data.max];
                GetminStr = [NSString stringWithFormat:@"%.1f",info.data.min];
                [_tableView reloadData];
                
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

//state 0.上拉加载更多 1.下拉刷新
- (void)getDataList:(int)state{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    WebServices *service = [[WebServices alloc] init];
   
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:userinfo.data.dataIdentifier,@"u_Id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:begindate,@"beginDate", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:enddate,@"endDate", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",pageindex],@"pageIndex", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"100000",@"pageSize", nil]];
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetGlucoseMethodName];

    [service asyncServiceUrl:GetGlucoseWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetGlucoseMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            DataListInfo *info=[[DataListInfo alloc]initWithDictionary:resultsDictionary];
            if (info.status==0)
            {
                NSMutableArray *_arr = [NSMutableArray array];
                _arr = [NSMutableArray arrayWithArray:info.data];
                if(state == 0)
                {
                    //上拉加载更多数据
                    // a.加载更多
                    for (int i=0; i<_arr.count; i++) {
                        
                        DataListModel *model = _arr[i];
                        [_dataListArr addObject:model];
                    }
                    //b.直接分页
                    //                    _dataListArr = [NSMutableArray arrayWithArray:_arr];
                }
                else
                {
                    //下拉刷新
                    _dataListArr = [NSMutableArray arrayWithArray:_arr];
                }
                
                [self.tableView reloadData];
                
            }
            else
            {
                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:info.msg delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
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

/**********发邮件************/
- (void)postEmail
{
    // You must check that the current device can send email messages before you
    // attempt to create an instance of MFMailComposeViewController.  If the
    // device can not send email messages,
    // [[MFMailComposeViewController alloc] init] will return nil.  Your app
    // will crash when it calls -presentViewController:animated:completion: with
    // a nil view controller.
    if ([MFMailComposeViewController canSendMail])
        // The device can send email.
    {
        [self displayMailComposerSheet];
    }
    else
        // The device can not send email.
    {
        //        self.feedbackMsg.hidden = NO;
        //        self.feedbackMsg.text = @"此设备为配置邮件功能！";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"此设备未配置邮件功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark - Compose Mail/SMS

// -------------------------------------------------------------------------------
//	displayMailComposerSheet
//  Displays an email composition interface inside the application.
//  Populates all the Mail fields.
// -------------------------------------------------------------------------------
- (void)displayMailComposerSheet
{
    picker = [[MFMailComposeViewController alloc] init];
    picker.navigationBarHidden = YES;
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"艾检"];
    
    // Set up recipients
//    NSArray *toRecipients = [NSArray arrayWithObject:@"765508285@qq.com"];
    //    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    //    NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    
//    [picker setToRecipients:toRecipients];
    //    [picker setCcRecipients:ccRecipients];
    //    [picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
    
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
//    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"sms.png"]];   // 保存文件的名称
    
//    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    
//    [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"rainy.png"];
    
    // Fill out the email body text
    NSString *sexstr;
    if (userinfo.data.sex == 0) {
        sexstr = @"女";
    }
    else
    {
        sexstr = @"男";
    }
    
    NSString *emailBody = [NSString stringWithFormat:@"<h3 align = 'center'>用户信息</h3><p>姓名:  %@<br />性别:  %@<br />出生日期:  %@<br />%@<p/>",userinfo.data.userName,sexstr,userinfo.data.birthday,HTMLStr] ;
    [picker setMessageBody:emailBody isHTML:YES];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)appendingHtml
{
    NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];

    NSDateFormatter *formatter1  = [[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    
    //创建了两个日期对象
    NSDate *date1=[formatter dateFromString:begindate];
    NSDate *date2=[formatter1 dateFromString:enddate];
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    int days=((int)time)/(3600*24);
    //   int hours=((int)time)%(3600*24)/3600;
    NSString *dateContent=[[NSString alloc] initWithFormat:@"%i",days];
    
    HTMLStr =[NSString stringWithFormat:@"<table width=\"600\" border=\"0\" align=\"center\" cellpadding=\"4\" cellspacing=\"1\" bgcolor=\"#FF0000\"><caption>%@天的数据(%@ — %@)</caption><tr><th bgcolor=\"#FFFFFF\"><div align=\"center\">日期</div></th><th bgcolor=\"#FFFFFF\"><div align=\"center\">时间</div></th><th bgcolor=\"#FFFFFF\"><div align=\"center\">血糖值</div></th><th bgcolor=\"#FFFFFF\"><div align=\"center\">单位</div></th><th bgcolor=\"#FFFFFF\"><div align=\"center\">时间段</div></th><th bgcolor=\"#FFFFFF\"><div align=\"center\">标示</div></th></tr>",dateContent,begindate,enddate];
    
    NSString *bodystr = [NSString string];
    NSString *strColor = [NSString string];
    NSString *typeStr = [NSString string];
    for (int i = 0; i < _dataListArr.count; i ++) {
        DataListModel *model = _dataListArr[i];
        
        NSString *value = [NSString stringWithFormat:@"%.1f",model.measureValue];
        //当GetminStr<血糖值<GetmaxStr时给它赋绿色
        if ([value compare:GetminStr options:NSNumericSearch] == NSOrderedDescending && [value compare:GetmaxStr options:NSNumericSearch] == NSOrderedAscending)
        {
            strColor = @"green";//[UIColor greenColor];
        }
        //当血糖值<GetminStr时给它赋蓝色
        else if ([value compare:GetminStr options:NSNumericSearch] == NSOrderedAscending )
        {
            strColor = @"blue";//[UIColor blueColor];
        }
        //当血糖值>GetmaxStr时给它赋红色
        else if ([value compare:GetmaxStr options:NSNumericSearch] == NSOrderedDescending)
        {
            strColor = @"red";
        }
        //当血糖值=GetminStr或者血糖值=GetmaxStr时给它赋绿色
        else if ([value compare:GetminStr options:NSNumericSearch]==NSOrderedSame || [value compare:GetmaxStr options:NSNumericSearch]==NSOrderedSame)
        {
            strColor = @"green";//[UIColor greenColor];
        }
        
        
        //如果inputType＝1,则为手工输入；如果inputType=2,则为蓝牙录入
        if ([model.inputType isEqualToString:@"1"]) {
            typeStr = @"手工输入";
        }else if ([model.inputType isEqualToString:@"2"]){
            typeStr = @"蓝牙输入";
        }

        int state =  [model.periodType integerValue];
        NSString *stateStr;
        switch (state) {
            case 1:
                stateStr = @"餐前";
                break;
            case 2:
                stateStr = @"餐后";
                break;
            case 3:
                stateStr = @"空腹";
                break;
            case 4:
                stateStr = @"随机";
                break;
            default:
                break;
        }
        
        bodystr = [bodystr stringByAppendingFormat:@"<tr><td bgcolor=\"#FFFFFF\"><div align=\"center\">%@</div></td><td bgcolor=\"#FFFFFF\"><div align=\"center\">%@</div></td><td bgcolor=\"#FFFFFF\"><font color=\"%@\"><div align=\"center\">%.1f</div></td><td bgcolor=\"#FFFFFF\"><div align=\"center\">mmol/L</div></td><td bgcolor=\"#FFFFFF\"><div align=\"center\">%@</div></td><td bgcolor=\"#FFFFFF\"><div align=\"center\">%@</div></td></tr>",model.measureTimeFormat,model.measureTimeT,strColor,model.measureValue,stateStr,typeStr];
    }
    
    HTMLStr = [HTMLStr stringByAppendingFormat:@"%@</table>",bodystr];
    
//    ZWLog(@"%@",HTMLStr);
}


- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //    self.feedbackMsg.hidden = NO;
    
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //            self.feedbackMsg.text = @"Result: 邮件发送取消";
            break;
        case MFMailComposeResultSaved:
            //            self.feedbackMsg.text = @"Result: 邮件保存";
            break;
        case MFMailComposeResultSent:{
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"邮件发送成功!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            
            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"sms.png"]];   // 保存文件的名称
            //删除归档文件
            NSFileManager *defaultManager = [NSFileManager defaultManager];
            
            if ([defaultManager isDeletableFileAtPath:filePath]) {
                
                [defaultManager removeItemAtPath:filePath error:nil];
            }
            
        }
            //            self.feedbackMsg.text = @"Result: 邮件发送";
            break;
        case MFMailComposeResultFailed:
            //            self.feedbackMsg.text = @"Result: 邮件发送失败";
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"邮件发送失败!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
            break;
        default:
            //            self.feedbackMsg.text = @"Result: 邮件未发送";
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
/**********发邮件************/

- (void)dealloc
{
   
   [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
    pageindex = 1;
    [self getDataList:1];
}

- (void)footerRereshing
{

    if(pageindex<100000){
        ++pageindex;
        [self getDataList:0];
    }
}

@end
