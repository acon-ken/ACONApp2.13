//
//  BloodGlucoseManageController.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/12/9.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "BloodGlucoseManageController.h"
#import "BloodGlucoseCell.h"
//#import "RemindCell.h"
#import "BloodGlucoseManageInfo.h"
#import "BloodGlucoseManageModel.h"
#import "GetGlucoseSetModel.h"
#import "GetGlucoseSetData.h"

#import "LKAlarmMamager.h"

#import "DateAndTime.h"
#import "RemindSeetingCell.h"
#import "DAOverlayView.h"


#define KCTaskSearchNavigationColor [UIColor colorWithRed:62/255.0 green:206/255.0 blue:232/255.0 alpha:1.0]

@interface myPicker10 ()
@end

@interface myPicker11 ()
@end

@implementation myPicker10
@end

@implementation myPicker11
@end

@interface BloodGlucoseManageController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,LKAlarmMamagerDelegate,/*ReminfInformationCellDelegate,*/RemindSeetingCellDelegate,DAOverlayViewDelegate>
{
    myPicker10 *pickerView1;
    myPicker11 *pickerView2;
    
    UISegmentedControl *_sc;
    NSMutableArray *valueArr;
    NSMutableArray *reverseValueArr;
    UIButton *pick1Btn;
    UIButton *pick2Btn;
    UIView *settingView;
    UILabel *tipsLB;
    UIButton *remindBtn;
    
    NSMutableArray *_dataArr;//请求返回的数据
    NSMutableString *beginReg;
    NSMutableString *endReg;
    
    DateAndTime *dateAndTime;//时钟
    UIView *footerView;
    
    NSMutableArray *_remindArr;
    NSMutableSet *_set;//保存所有通知
    
    BOOL selectRemindBtn;//YES 可编辑
    
    NSString *pickerTime;//选取的时间
    CGFloat usedTime;//加入通知的时间
    NSString *noticationTitle;
    NSString *noticationRemark;
    
    UIImageView *popImg;
    
    
    NSString *GetmaxStr; //通过接口获取来的最大值
    NSString *GetminStr;  //通过接口获取来的最小值
    
    UITextField *cellTextFiled;
    BOOL isEdit;//编辑状态
    BOOL isIntoEdit;//判断cell进入编辑状态
    UIView *menbanview; //蒙板
    int indexRow;
    
    NSDictionary *oneDict;
    NSDictionary *backDict;
    BOOL isAdd;
    
    NSString *joinRemindID;//加入通知中的的ID
    
    NSTimer *timer;//定时器
    
    NSInteger pickerviewselectrow1;//pickerview1默认选中行
    NSInteger pickerviewselectrow2;//pickerview2默认选中行
}
@property (nonatomic,strong ) UITableView  *tableView;
//@property (strong, nonatomic) UIPickerView *pickerView1;
//@property (strong, nonatomic) UIPickerView *pickerView2;

/*****/
@property (strong, nonatomic) RemindSeetingCell *cellDisplayingMenuOptions;
@property (strong, nonatomic) DAOverlayView *overlayView;
@property (assign, nonatomic) BOOL customEditing;
@property (assign, nonatomic) BOOL customEditingAnimationInProgress;
@property (strong, nonatomic) UIBarButtonItem *editBarButtonItem;
@property (strong, nonatomic) UIBarButtonItem *doneBarButtonItem;
/*****/

@end

@implementation BloodGlucoseManageController

- (void)viewDidLoad {
    [super viewDidLoad];

 
    self.title = @"血糖管理";
    
    self.customEditing = self.customEditingAnimationInProgress = NO;
    
    self.view.backgroundColor = KBackgroundColor;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBarHidden = NO;
   
    valueArr = [NSMutableArray array];
    _dataArr = [NSMutableArray array];
    
    GetmaxStr = [NSString string];
    GetminStr = [NSString string];
    
    /**
     *  本地通知添加用户ID用于区分
     */
    _remindArr = [NSMutableArray array];
    _set = [NSMutableSet setWithSet:[ArchiveAccessFile UnarchivedSuccessFileName:@"remind.plist"]];

//    NSMutableArray *array = [NSMutableArray arrayWithArray:[ArchiveAccessFile UnarchivedSuccessFileName:@"remind.plist"]];
    NSString *userID = [[[SaveUserInfo loadCustomObjectWithKey]data] dataIdentifier];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSDictionary *dict in _set) {
        if ([[dict objectForKey:DEF_ACONUserID] isEqualToString:userID])
        {
            [_remindArr addObject:dict];
            [tempArr addObject:dict];
        }
    }
    
    while (tempArr.count>0) {
        [_set removeObject:tempArr[0]];
        [tempArr removeObjectAtIndex:0];

    }

//    _remindArr = [NSMutableArray arrayWithArray:[ArchiveAccessFile UnarchivedSuccessFileName:@"remind.plist"]];
    
    
    if (_remindArr.count>0) {
        
    }
    else
    {
        _remindArr = [NSMutableArray array];
    }
    
    for (int i = 6; i< 334; i ++) {
        NSString *value = [NSString stringWithFormat:@"%.1f%@",i *0.1,@"mmol/L"];
        
        [valueArr addObject:value];
    }

    
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
    
    //根据用户Id获取用户设置血糖的最高和最低
    [self  postGetGlucoseSet];
    
    [self selectButttonView];
    
    [self createTableView];
    
    if (_selectBtn == NO) {
        [self createSettingView];
    }else {
        dateAndTime = [DateAndTime createDateAndTimeCell];
        [dateAndTime initView];
        dateAndTime.frame = CGRectMake(0, CGRectGetMaxY(_sc.frame) + 10, KScreenWidth, 130);
        
        [self.view addSubview:dateAndTime];
         self.tableView.frame = CGRectMake(0,100 + 100, KScreenWidth, KScreenHeight- 64-100 - 200);
        
        //给导航栏加右侧按钮
        remindBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [remindBtn setImage:[UIImage imageNamed:@"zhong.png"] forState:UIControlStateNormal];
        [remindBtn setImage:[UIImage imageNamed:@"zhongbai.png"] forState:UIControlStateSelected];
        [remindBtn  addTarget:self action:@selector(remindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        remindBtn.selected = YES;
        
        UIBarButtonItem *righButtonitemt  = [[UIBarButtonItem alloc] initWithCustomView:remindBtn];
        self.navigationItem.rightBarButtonItem=righButtonitemt;
    }

    [self setupRefresh];
    
    [self addKeyboardNote];
    
    
   
}

-(void)viewWillAppear:(BOOL)animated{


    [super viewWillAppear:animated];
    
   
    
}

-(void)selectButttonView{
    
    NSArray *items=@[@"血糖控制",@"提醒设置"];
    
    _sc = [[UISegmentedControl alloc]initWithItems:items];
    if (_selectBtn == NO) {
        _sc.selectedSegmentIndex = 0;
    }
    else
    {
        _sc.selectedSegmentIndex = 1;
    }
    
    _sc.frame=CGRectMake(5, 10, KScreenWidth-10, 35);
    [_sc addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    
    _sc.tintColor=KCommonColor;
    
    [self.view addSubview:_sc];
    
}


#pragma mark 切换视图按钮
//_selectBtn = NO是血糖控制 _selectBtn =YES 是提醒设置
-(void)segmentAction:(id)sender{
    
    NSInteger i = [_sc selectedSegmentIndex];
    if (i == 0) {
        [self createSettingView];
        CATransition *transaction = [CATransition animation];
        //设置专场动画类型
        [transaction setType:kCATransitionFromRight];
        [transaction setDuration:1.0f];
        [transaction  setSubtype:kCATransitionFromRight];
        _selectBtn = NO;
        settingView.alpha = 1;
        dateAndTime.alpha = 0;
        remindBtn.alpha = 0;
        footerView.alpha = 0;
        
        self.tableView.frame = CGRectMake(0,100, KScreenWidth, KScreenHeight- 64-100);
        
        [self.tableView reloadData];
        
        [self postGetGlucoseSet];
    }
    if (i == 1) {
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *myEncodedObject = [defaults objectForKey:@"111"];
        
        if (myEncodedObject==nil)
        {
            if (!myEncodedObject) {
                popImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
                popImg.image=[UIImage imageNamed:@"zhezhao"];
                //    [self.view addSubview:popImg];
                
                
                UIImageView *ziImg=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/2-80, KScreenHeight/2-20, 160, 40)];
                ziImg.image=[UIImage imageNamed:@"zi"];
                [popImg addSubview:ziImg];

            }
            
            popImg.userInteractionEnabled = YES;
            
            [[UIApplication sharedApplication].keyWindow addSubview:popImg];
            
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popView)];
            [popImg addGestureRecognizer:singleTap];
        }else
        {
            
        }
        
        
        CATransition *transaction = [CATransition animation];
        //设置专场动画类型
        [transaction setType:kCATransitionFromRight];
        [transaction setDuration:1.0f];
        _selectBtn = YES;
        settingView.alpha = 0;
        self.tableView.frame = CGRectMake(0,100 + 100, KScreenWidth, KScreenHeight- 64-100 - 200);//KScreenHeight- 64-100 - 100);
        if (remindBtn) {
            remindBtn.alpha = 1;
        }else
        {
        //给导航栏加右侧按钮
         remindBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [remindBtn setImage:[UIImage imageNamed:@"zhong.png"] forState:UIControlStateNormal];
        [remindBtn setImage:[UIImage imageNamed:@"zhongbai.png"] forState:UIControlStateSelected];
        [remindBtn  addTarget:self action:@selector(remindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        remindBtn.selected = YES;
        
        UIBarButtonItem *righButtonitemt  = [[UIBarButtonItem alloc] initWithCustomView:remindBtn];
        self.navigationItem.rightBarButtonItem=righButtonitemt;
        }
        
        
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zhong.png"] style:UIBarButtonItemStyleDone target:self action:@selector(remindBtnClick:)];
/*******************************加载xib创建时钟***************************************************************************************************/
        if (dateAndTime) {
            dateAndTime.alpha = 1;
            [dateAndTime initTime];
            
        }
        else
        {
            dateAndTime = [DateAndTime createDateAndTimeCell];
            [dateAndTime initView];
            dateAndTime.frame = CGRectMake(0, CGRectGetMaxY(_sc.frame) + 10, KScreenWidth, 130);
            
            timer =  [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(reloadTime) userInfo:nil repeats:YES];
            [self.view addSubview:dateAndTime];
        }
        
        footerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), KScreenWidth, 50)];
        UILabel *footerlab = [[UILabel alloc] init];
        footerlab.text = @"请点击右上角的";
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:footerlab.font,NSFontAttributeName, nil];
        
        CGRect rect = [footerlab.text boundingRectWithSize:CGSizeMake(MAXFLOAT, footerView.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        
        footerlab.frame = CGRectMake(40, 0,rect.size.width, footerView.frame.size.height);
        

        footerlab.textAlignment = NSTextAlignmentCenter;
        footerlab.textColor = [UIColor grayColor];
        [footerView addSubview:footerlab];
        
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(footerlab.frame), 10, 25, 25)];
        imgView.image = [UIImage imageNamed:@"zhong.png"];
        [footerView addSubview:imgView];
        
        
        UILabel *footerLab2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame), 0, 120, footerView.frame.size.height)];
        footerLab2.text = @"添加吃药提醒";
        footerLab2.textColor = [UIColor grayColor];
        [footerView addSubview:footerLab2];
        
        [self.view addSubview:footerView];
        
        [self.tableView reloadData];

    }
    

    
    
    
    
}

#pragma mark - User Interaction
- (void)tapped:(UITapGestureRecognizer *)tap {
    CGPoint point;
     BOOL found = NO;
    if([pickerView1 superview])
    {
        point = [tap locationInView:pickerView1];
       
        if(!found && CGRectContainsPoint(pickerView1.bounds, point)) {
            found = YES;
        }
        
    }else if ([pickerView2 superview])
    {
        point = [tap locationInView:pickerView2];
        if(!found && CGRectContainsPoint(pickerView2.bounds, point)) {
            found = YES;
        }

    }
    
    
    if(!found) {
        [menbanview removeFromSuperview];
    }
    
}


- (void)createSettingView
{
    if (settingView) {
        NSString *currentgetminstr = [NSString stringWithFormat:@"%@/L",GetminStr];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:currentgetminstr];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [pick1Btn setAttributedTitle:str forState:UIControlStateNormal];
        
        NSString *currentgetmaxstr = [NSString stringWithFormat:@"%@/L",GetmaxStr];
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:currentgetmaxstr];
        NSRange strRange1 = {0,[str1 length]};
        [str1 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange1];
        [pick2Btn setAttributedTitle:str1 forState:UIControlStateNormal];
    }
    else
    {
        
        settingView = [[UIView alloc] initWithFrame:CGRectMake(0, 35, KScreenWidth, 50)];
        [self.view addSubview:settingView];

        
        UILabel *textLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 120, 50)];
        textLB.text = @"血糖正常值设定";
        textLB.textAlignment = NSTextAlignmentCenter;
        textLB.font = [UIFont systemFontOfSize:14];
        [settingView addSubview:textLB];
        
        UILabel *subtextLB = [[UILabel alloc] initWithFrame:CGRectMake(0,25, KScreenWidth, 50)];
        subtextLB.text = @"(下拉刷新:保存正常值以及获取数据)";
        subtextLB.textAlignment = NSTextAlignmentCenter;
        subtextLB.font = [UIFont systemFontOfSize:12];
        subtextLB.textColor = [UIColor redColor];
        [settingView addSubview:subtextLB];
        
        pick1Btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(textLB.frame) - 5, 13, 80, 35)];
        pick1Btn.tag = 321;
        NSString *currentgetminstr = [NSString stringWithFormat:@"%@/L",GetminStr];
        [pick1Btn setTitle:currentgetminstr forState:UIControlStateNormal];
        
        [pick1Btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [pick1Btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [pick1Btn addTarget:self action:@selector(clickPickerBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:GetminStr];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [pick1Btn setAttributedTitle:str forState:UIControlStateNormal];
        
        [settingView addSubview:pick1Btn];
        
        UILabel *textLB1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pick1Btn.frame), 0, 20, 60)];
        textLB1.textAlignment = NSTextAlignmentCenter;
        textLB1.font = [UIFont systemFontOfSize:14];
        textLB1.text = @"到";
        [settingView addSubview:textLB1];
        
        
        pick2Btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(textLB1.frame), 13, 80, 35)];
        pick2Btn.tag = 123;
        NSString *currentgetmaxstr = [NSString stringWithFormat:@"%@/L",GetmaxStr];
        [pick2Btn setTitle:currentgetmaxstr forState:UIControlStateNormal];
        [pick2Btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [pick2Btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [pick2Btn addTarget:self action:@selector(clickPickerBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:GetmaxStr];
        NSRange strRange1 = {0,[str1 length]};
        [str1 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange1];
        [pick2Btn setAttributedTitle:str1 forState:UIControlStateNormal];
        
        [settingView addSubview:pick2Btn];

    }
    
}


- (void)clickPickerBtn:(UIButton *)sender
{
    if (sender.tag == 321) {

        
        [pickerView2 removeFromSuperview];
        [self createPickerView1];
    }
    else
    {
        [pickerView1 removeFromSuperview];
        [self createPickerView2];
    }
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,100, KScreenWidth, KScreenHeight- 64-100) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor lightTextColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_selectBtn == NO) {
        return 3;
    }
    else
    {
        return _remindArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (_selectBtn == NO) {
        BloodGlucoseCell *bloodCell = [tableView dequeueReusableCellWithIdentifier:[BloodGlucoseCell ID]];
        if (bloodCell == nil) {
            bloodCell = [BloodGlucoseCell createBloodGlucoseCell];
        }
        switch (indexPath.row) {
            case 0:
                bloodCell.dateLB.text = @"最近一周";
                break;
            case 1:
                bloodCell.dateLB.text = @"最近一个月";
                break;
            case 2:
                bloodCell.dateLB.text = @"最近三个月";
                break;
            default:
                break;
        }
        
        if (_dataArr.count>0) {
            BloodGlucoseManageModel *model = _dataArr[0];
            bloodCell.bloodModel = model;
            [bloodCell initView];
        }
        
        cell = bloodCell;
    }
    else//提醒设置
    {
        RemindSeetingCell *remindCell = [tableView dequeueReusableCellWithIdentifier:[RemindSeetingCell ID]];
        if (remindCell == nil) {
            remindCell = [RemindSeetingCell createRemindSeetingCell];
        }
        
        NSDictionary *dict = _remindArr[indexPath.row];
        
        if (indexPath.row == (_remindArr.count-1)) {

            [remindCell RemindInformationWithDict:dict editionBool:isIntoEdit];
            if (isIntoEdit) {
                [remindCell.titleTF becomeFirstResponder];
                isIntoEdit = NO;
            }
        }
        
        else
        {
            
            [remindCell RemindInformationWithDict:dict editionBool:NO];
            
        }
        
         if (isEdit) {
            if (indexPath.row == indexRow)
            {
                [_set removeObject:oneDict];
                [remindCell RemindInformationWithDict:oneDict editionBool:isEdit];
                remindCell.titleTF.enabled = YES;
                remindCell.timeTF.enabled = YES;
                remindCell.remarkTF.enabled =YES;
                [remindCell.titleTF becomeFirstResponder];
            }
        }
        
        remindCell.delegate = self;
        
        [remindCell updateFrame];
        
        cell = remindCell;
    }
    
    return cell;
}


#pragma mark * DAContextMenuCell delegate

#pragma mark 删除
- (void)contextMenuCellDidSelectDeleteOption:(RemindSeetingCell *)cell
{
    [cell.superview sendSubviewToBack:cell];
    self.customEditing = NO;
    
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    indexRow = index.row;
    
    NSDictionary *deleteDict =  _remindArr[indexRow];
    
    selectRemindBtn = YES;
    [_remindArr removeObject:deleteDict];
    [self ttt:[deleteDict[@"ID"] integerValue]];
#warning message
    
    [_set addObjectsFromArray:_remindArr];
    [_set removeObject:deleteDict];
    [ArchiveAccessFile ArchiveSuccessData:_set fileName:@"remind.plist"];

//    [ArchiveAccessFile ArchiveSuccessData:_remindArr fileName:@"remind.plist"];
    if (_remindArr.count > 0) {
        
    }
    else
    {
        selectRemindBtn = NO;
    }

    [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
#pragma mark 编辑
- (void)contextMenuCellDidSelectMoreOption:(RemindSeetingCell *)cell
{
    
    remindBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [remindBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [remindBtn setTitle:@"完成" forState:UIControlStateNormal];
    [remindBtn  addTarget:self action:@selector(remindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    remindBtn.selected = YES;
    
    UIBarButtonItem *righButtonitemt  = [[UIBarButtonItem alloc] initWithCustomView:remindBtn];
    self.navigationItem.rightBarButtonItem=righButtonitemt;
    
    isEdit = YES;
    
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    indexRow = index.row;
    
    oneDict =  _remindArr[indexRow];
    
    selectRemindBtn = YES;
    [self.tableView reloadData];
     joinRemindID = oneDict[@"ID"];
    [self ttt:[oneDict[@"ID"] integerValue]];
    
//    for (NSDictionary *dict in _remindArr) {
//        if ([cell.remindID isEqualToString:dict[@"ID"]]) {
//            indexRow = [_remindArr indexOfObject:dict];
//            [self ttt:[dict[@"ID"] integerValue]];
//            selectRemindBtn = YES;
//            [self.tableView reloadData];
//            [self.tableView setEditing:NO];
//        }
//    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
    headerView.backgroundColor= [UIColor colorWithRed:215/255.0 green:227/255.0 blue:254/255.0 alpha:1.0];
    UILabel *headerLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 30)];
    
    UILabel *labe1 = [[UILabel alloc ] initWithFrame:CGRectMake(10, 0, (KScreenWidth-20)/3, 50)];
    labe1.text = @"提醒事件";
    labe1.textAlignment = NSTextAlignmentCenter;
    labe1.layer.borderWidth = 0.5;
    labe1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    UILabel *labe2 = [[UILabel alloc ] initWithFrame:CGRectMake((KScreenWidth-20)/3 + 10, 0, (KScreenWidth-20)/3, 50)];
    labe2.text = @"时间";
    labe2.textAlignment = NSTextAlignmentCenter;
    labe2.layer.borderWidth = 0.5;
    labe2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    UILabel *labe3 = [[UILabel alloc ] initWithFrame:CGRectMake((KScreenWidth-20)/3 *2+10, 0, (KScreenWidth-20)/3, 50)];
    labe3.text = @"备注";
    labe3.textAlignment = NSTextAlignmentCenter;
    labe3.layer.borderWidth = 0.5;
    labe3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    if (_selectBtn == NO) {
        [labe1 removeFromSuperview];
        [labe2 removeFromSuperview];
        [labe3 removeFromSuperview];
        headerLB.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:headerLB];
        
        if (_dataArr.count>0) {
            BloodGlucoseManageModel *model = _dataArr[0];
            if ([model.regRate1 isEqualToString:@"100.00%"]) {
                headerLB.text = @"血糖控制的很好哦！";
            }
            else
            {
                headerLB.text = @"继续努力哦！";
            }
        }
        else
        {
            headerLB.text = @"继续努力哦！";
        }
    }
    else{
        headerView.backgroundColor = [UIColor clearColor];
        [headerLB removeFromSuperview];
        [headerView addSubview:labe1];
        [headerView addSubview:labe2];
        [headerView addSubview:labe3];
        
    }
    return headerView;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_selectBtn == NO) {
        return 30;
    }
    else
    {
        return 50;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectBtn == NO) {
        return 180;
    }
    else
    {
        return 50;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (_selectBtn) {
//
//        NSDictionary *dict = _remindArr[indexPath.row];
//
//        if (indexPath.row == 0) {
//            return UITableViewCellEditingStyleNone;
//        }
//        else if ([dict[@"time"] isEqualToString:@""])
//        {
//            return UITableViewCellEditingStyleNone;
//        }
//        else
//        {
//            //    返回表格编辑编辑样式。不实现默认都是删除
//            return  UITableViewCellEditingStyleDelete;
//        }
//
//    }
//    else
//    {
//        return UITableViewCellEditingStyleNone;
//    }
//}
//#pragma mark Cell滑动
//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewRowAction *moreAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
//        
//        isEdit = YES;
//        NSDictionary *dict = _remindArr[indexPath.row];
//        [self ttt:[dict[@"ID"] integerValue]];
//        
//        selectRemindBtn = YES;
//        [self.tableView reloadData];
//        [self.tableView setEditing:NO];
//    }];
//    
//    moreAction.backgroundColor = [UIColor lightGrayColor];
//    
//    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
//        NSLog(@"%ld",(long)indexPath.row);
//
//        
//        NSDictionary *dict = _remindArr[indexPath.row];
//        [_remindArr removeObjectAtIndex:indexPath.row];
//        
//        [self ttt:[dict[@"ID"] integerValue]];
//        
//        [ArchiveAccessFile ArchiveSuccessData:_remindArr fileName:@"remind.plist"];
//
//        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//    }];
//    
//    return @[deleteAction, moreAction];
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 如果不是删除操作，直接返回
//    if (editingStyle != UITableViewCellEditingStyleDelete) return;
//
//     NSDictionary *dict = _remindArr[indexPath.row];
////    // 1.删除模型数据
//    [_remindArr removeObjectAtIndex:indexPath.row];
//    [self ttt:[dict[@"ID"] integerValue]];
//    
//     [ArchiveAccessFile ArchiveSuccessData:_remindArr fileName:@"remind.plist"];
////    
////    // 2.刷新表格
////    //    [tableView reloadData];
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//}


- (void)createPickerView1
{
    pickerView1  = [[myPicker10 alloc]init];
    //pickerView1 = [[UIPickerView alloc] init];
    pickerView1.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    pickerView1.frame = CGRectMake(pick1Btn.frame.origin.x ,0, 78,30);
    pickerView1.tag = 111;
    pickerView1.delegate = self;
    pickerView1.dataSource = self;
    //设置pickerView默认选中行
    if (pickerviewselectrow1 != 144 && pickerviewselectrow1 !=0) {
        [pickerView1 selectRow:pickerviewselectrow1 inComponent:0 animated:NO];
    }
    else{
    [pickerView1 selectRow:0 inComponent:0 animated:NO];
    }
    
    pickerView1.showsSelectionIndicator = YES;
    pickerView1.backgroundColor = [UIColor whiteColor];
    [pickerView1 reloadAllComponents];
//    [self.view addSubview:self.pickerView1];
    
    menbanview = [[UIView alloc]initWithFrame:self.view.bounds];
    menbanview.backgroundColor = [UIColor clearColor];/////////////
    UITapGestureRecognizer *recogniz = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    [menbanview addGestureRecognizer:recogniz];
    
    
     [menbanview addSubview:pickerView1];
    [self.view addSubview:menbanview];
}

- (void)createPickerView2
{
    pickerView2  = [[myPicker11 alloc]init];
    pickerView2.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    pickerView2.frame = CGRectMake(pick2Btn.frame.origin.x ,0, 78,30);
    pickerView2.tag = 222;
    pickerView2.delegate = self;
    pickerView2.dataSource = self;
    //设置pickerView默认选中行
    if (pickerviewselectrow2 != 183 && pickerviewselectrow2 !=0) {
        [pickerView2 selectRow:pickerviewselectrow2 inComponent:0 animated:NO];
    }
    else{
        [pickerView2 selectRow:0 inComponent:0 animated:NO];
    }
    pickerView2.showsSelectionIndicator = YES;
    pickerView2.backgroundColor = [UIColor whiteColor];
    [pickerView2 reloadAllComponents];
//    [self.view addSubview:self.pickerView2];
    
    menbanview = [[UIView alloc]initWithFrame:self.view.bounds];
    menbanview.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *recogniz = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    [menbanview addGestureRecognizer:recogniz];
    
    
    [menbanview addSubview:pickerView2];
    [self.view addSubview:menbanview];

}


#pragma mark - 数据源
#pragma mark 有多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

#pragma mark 第component列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return valueArr.count;
}

#pragma mark 每行显示什么内容、第component列第row行显示什么文字
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView.tag == 111) {

        
        return valueArr[row];
        //获取选中的列中的所在的行
    
    }
    else
    {
        reverseValueArr = (NSMutableArray *)[[valueArr reverseObjectEnumerator] allObjects];
       
        return reverseValueArr[row];
    }
    
}

#pragma mark - 代理
#pragma mark 选中了第component列第row行就会调用
// 只有手动选中了某一行才会通知代理
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pick1Btn setTitle:@"" forState:UIControlStateNormal];
    [pick2Btn setTitle:@"" forState:UIControlStateNormal];
    // 1.取出选中那行的文字
    NSMutableString *text;
    if (pickerView.tag ==111) {
        if (pickerviewselectrow1 !=row) {
            pickerviewselectrow1 = row;
        }
        
        text = [NSMutableString stringWithString:valueArr[row]];
        
        NSRange range = [text rangeOfString:@"mmol"];
        
        beginReg =  [NSMutableString stringWithString:[text substringToIndex:range.location]];
    }
    else
    {
        
        if (pickerviewselectrow2 !=row) {
            pickerviewselectrow2 = row;
        }
        
        text = [NSMutableString stringWithString:reverseValueArr[row]];
        
        NSRange range1 = [text rangeOfString:@"mmol"];
        
        endReg =  [NSMutableString stringWithString:[text substringToIndex:range1.location]];
    }
    
    
    // 2.显示到对应的label上面
    NSString *currenttext = [NSString stringWithFormat:@"%@",text];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:currenttext];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    if (pickerView.tag == 111) {
        
        [pick1Btn setAttributedTitle:str forState:UIControlStateNormal];
    }
    else
    {
        [pick2Btn setAttributedTitle:str forState:UIControlStateNormal];
        
    }
}


//字体大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentLeft];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [pickerView1 removeFromSuperview];
    [pickerView2 removeFromSuperview];
    [self.view endEditing:YES];

}


- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark 请求数据
//根据用户Id获取用户设置血糖的最高和最低请求
-(void)postGetGlucoseSet{
//    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    WebServices *service = [[WebServices alloc] init];
    LoginInfoModel *userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:userinfo.data.dataIdentifier,@"u_Id", nil]];
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetGlucoseSetMethodName];
    __weak BloodGlucoseManageController *wself = self;
    [service asyncServiceUrl:GetGlucoseWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetGlucoseSetMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
//        [MBProgressHUD hideHUDForView:wself.view animated:YES];
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            GetGlucoseSetModel *info = [[GetGlucoseSetModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
                GetmaxStr = [NSString stringWithFormat:@"%.1fmmol",info.data.max];
                GetminStr = [NSString stringWithFormat:@"%.1fmmol",info.data.min];
                if (GetminStr&&GetmaxStr == nil) {
                    beginReg = [NSMutableString stringWithString:@"15.0mmol"];
                    endReg = [NSMutableString stringWithString:@"15.0mmol"];
                }
                else
                {
                    beginReg = [NSMutableString stringWithString:GetminStr];
                    endReg  = [NSMutableString stringWithString:GetmaxStr];
                    
                    for (int index =0; index <valueArr.count; index++)
                    {
                        NSString *valueString   = valueArr[index];
                        
                        if ([valueString  isEqualToString: [NSString stringWithFormat:@"%@/L",GetminStr]])
                        {
                            pickerviewselectrow1 = index;
                           
                           // return;
                        }
                    }
                    
                    
                    reverseValueArr = (NSMutableArray *)[[valueArr reverseObjectEnumerator] allObjects];

                    
                    for (int index =0; index <reverseValueArr.count; index++)
                    {
                        NSString *valueString   = reverseValueArr[index];
                        
                        if ([valueString  isEqualToString: [NSString stringWithFormat:@"%@/L",GetmaxStr]])
                        {
                            pickerviewselectrow2 = index;
                          
                           // return;
                        }
                    }

                }
                if (_selectBtn == NO) {
                    [wself createSettingView];
                }
                [wself getGlucoseManagerData];
                
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

//获取血糖管理数据
- (void)getGlucoseManagerData{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    WebServices *service = [[WebServices alloc] init];
    LoginInfoModel *userinfo = [SaveUserInfo loadCustomObjectWithKey];

  
    NSRange range = [beginReg rangeOfString:@"mmol"];
    if (range.length == 4) {
         [beginReg replaceCharactersInRange:range withString:@""];
    }
    
    NSRange range1 = [endReg rangeOfString:@"mmol"];
    if (range1.length == 4) {
        [endReg replaceCharactersInRange:range1 withString:@""];
    }
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:userinfo.data.dataIdentifier,@"u_Id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:beginReg,@"beginReg", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:endReg,@"endReg", nil]];

    __weak BloodGlucoseManageController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GlucoseManagerMethodName];
    [service asyncServiceUrl:GetGlucoseWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GlucoseManagerMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:wself.view animated:YES];
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            BloodGlucoseManageInfo *info = [[BloodGlucoseManageInfo alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
                [_dataArr removeAllObjects];
                
                [_dataArr addObject:info.data];
                
                [wself.tableView reloadData];
                
            }
            
        }
        else if ([json isEqualToString:@""])
        {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"当前您没有数据" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
            [alertView show];
        }
        else
        {
            NSLog(@"网络异常！");
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
            [alertView show];
        }
    }];

}

//上传用户血糖最低值和最高值请求
-(void)postUpdateGlucoseSet{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    WebServices *service = [[WebServices alloc] init];
    LoginInfoModel *userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
       NSRange range = [beginReg rangeOfString:@"mmol"];
    if (range.length == 4) {
        [beginReg replaceCharactersInRange:range withString:@""];
    }
    
    NSRange range1 = [endReg rangeOfString:@"mmol"];
    if (range1.length == 4) {
        [endReg replaceCharactersInRange:range1 withString:@""];
    }
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:userinfo.data.dataIdentifier,@"u_Id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:beginReg,@"min", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:endReg,@"max", nil]];
    
    __weak BloodGlucoseManageController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:UpdateGlucoseSetMethodName];
    [service asyncServiceUrl:GetGlucoseWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:UpdateGlucoseSetMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [MBProgressHUD hideHUDForView:wself.view animated:YES];
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            BloodGlucoseManageInfo *info = [[BloodGlucoseManageInfo alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
                ZWLog(@"上传成功！");
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
 *  刷新控件
 *
 */
#pragma mark---刷新数据
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
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
    [pickerView1 removeFromSuperview];
    [pickerView2 removeFromSuperview];
    
    if (beginReg==nil) {
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
        [alertView show];
    }else {
    
    [self getGlucoseManagerData];//重新加载数据
    
    //上传用户血糖最低值和最高值
    [self postUpdateGlucoseSet];
    }
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView headerEndRefreshing];
    
}

#pragma mark 提醒设置
/*********************/
//添加一条提醒事件
- (void)remindBtnClick:(UIButton *)btn
{
    [self.view endEditing:YES];
    
    if (selectRemindBtn == NO) {
        selectRemindBtn = YES;
        
        isIntoEdit = YES;
        isAdd = YES;
        
        remindBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [remindBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [remindBtn setTitle:@"完成" forState:UIControlStateNormal];
        [remindBtn  addTarget:self action:@selector(remindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        remindBtn.selected = YES;
        
        UIBarButtonItem *righButtonitemt  = [[UIBarButtonItem alloc] initWithCustomView:remindBtn];
        self.navigationItem.rightBarButtonItem=righButtonitemt;
        
        NSString *remindID;
        if (_remindArr.count>0) {
            NSDictionary *lastdict = [_remindArr lastObject];
            remindID = [NSString stringWithFormat:@"%ld",[lastdict[@"ID"] integerValue] + 1];
            joinRemindID = remindID;
        }
        else
        {
            remindID = @"0";
            joinRemindID = remindID;
        }
        NSDictionary *dict = @{@"ID":remindID,@"title":@"",@"time":@"",@"remark":@"",DEF_ACONUserID:[[[SaveUserInfo loadCustomObjectWithKey]data]dataIdentifier]};
        [_remindArr addObject:dict];
        [self.tableView reloadData];
    }
    else
    {
        if (isAdd) {
            
            [_set removeObject:[_remindArr lastObject]];//修改 从所有的通知中移除修改的??
            [_remindArr removeLastObject];
            [_remindArr addObject:backDict];
#warning message
            
            [_set addObjectsFromArray:_remindArr];
            [ArchiveAccessFile ArchiveSuccessData:_set fileName:@"remind.plist"];

//            [ArchiveAccessFile ArchiveSuccessData:_remindArr fileName:@"remind.plist"];
            isAdd = NO;
        }else//修改过来的
        {
            [_set addObjectsFromArray:_remindArr];
            [ArchiveAccessFile ArchiveSuccessData:_set fileName:@"remind.plist"];
        }
        isEdit = NO;
        isIntoEdit = NO;
        
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd "];
        NSString *currentTime = [formatter stringFromDate:[NSDate date]];
        
        NSString *selectTime = [NSString stringWithFormat:@"%@%@",currentTime,pickerTime];
        
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat : @"yyyy-MM-dd HH:mm"];
        NSDate *dateTime = [formatter1 dateFromString:selectTime];//选取的时间
        
        NSTimeInterval  timeInterval = [dateTime timeIntervalSinceNow];
        
        NSString *used = [NSString stringWithFormat:@"%.0f",timeInterval];
        usedTime = [used integerValue];
        
//        NSString *nicknameRegex = @"^[\u4e00-\u9fa5]$";
//        NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
        
        if (noticationTitle == nil||[noticationTitle isEqualToString:@""]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请填写提醒事件" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
//        else if (![passWordPredicate evaluateWithObject:noticationTitle])
//        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请填写提醒事件" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alertView show];
//        }
        else if(pickerTime == nil||[pickerTime isEqualToString:@""])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请填写提醒时间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }else
        {
            
            remindBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
            [remindBtn setImage:[UIImage imageNamed:@"zhong.png"] forState:UIControlStateNormal];
            [remindBtn setImage:[UIImage imageNamed:@"zhongbai.png"] forState:UIControlStateSelected];
            [remindBtn  addTarget:self action:@selector(remindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            remindBtn.selected = YES;
            
            UIBarButtonItem *righButtonitemt  = [[UIBarButtonItem alloc] initWithCustomView:remindBtn];
            self.navigationItem.rightBarButtonItem=righButtonitemt;

            
            selectRemindBtn = NO;
            [self.tableView reloadData];

            [self joinLocationNotication];//点击后就会加入本地通知
            
        }
        
    }
}

-(void)RemindInformationWithEditionDict:(NSDictionary *)dict
{
    backDict = [NSDictionary dictionaryWithDictionary:dict];
    
    if (_remindArr.count>0) {
        
        if (isEdit) {
            
            [_remindArr replaceObjectAtIndex:indexRow withObject:dict];
        }
        else
        {
//            [_remindArr removeLastObject];
//            [_remindArr addObject:dict];
        }
        
        pickerTime = dict[@"time"];
        noticationTitle = dict[@"title"];
        noticationRemark = dict[@"remark"];
        
        if (pickerTime==nil||noticationTitle == nil||[pickerTime isEqualToString:@""]||[noticationTitle isEqualToString:@""]) {
            
        }
        else
        {
#warning message
            /**
             *  编辑时不保存
             */
            /*
            [_set removeObject:oneDict];
            [_set addObjectsFromArray:_remindArr];
            [ArchiveAccessFile ArchiveSuccessData:_set fileName:@"remind.plist"];
//            [ArchiveAccessFile ArchiveSuccessData:_remindArr fileName:@"remind.plist"];
            */
        }
    }
    
}

- (void)RemindInformationWithBeginEdit:(UITextField *)textfiled
{
    cellTextFiled = textfiled;
}


/**
 *  删除本地通知
 *
 *  @param notificationtag 通知标示
 */
- (void)ttt:(int)notificationtag
{
    NSArray *noArr = [[UIApplication sharedApplication] scheduledLocalNotifications];
    ZWLog(@"%@",noArr);
    for (UILocalNotification *noti in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        NSString *notiID = [NSString stringWithFormat:@"%@",noti.userInfo[@"nfkey"]];
        NSString *receiveNotiID = [NSString stringWithFormat:@"%d",notificationtag];
        if ([notiID isEqualToString:receiveNotiID]) {
            [[UIApplication sharedApplication] cancelLocalNotification:noti];
            return;
        }
}
    
//    NSArray *narry=[[UIApplication sharedApplication] scheduledLocalNotifications];
//    NSUInteger acount=[narry count];
//    if (acount>0)
//    {
//        // 遍历找到对应nfkey和notificationtag的通知
//        for (int i=0; i<acount; i++)
//        {
//            UILocalNotification *myUILocalNotification = [narry objectAtIndex:i];
//            NSDictionary *userInfo = myUILocalNotification.userInfo;
//            NSNumber *obj = [userInfo objectForKey:@"nfkey"];
//            int mytag=[obj intValue];
//            if (mytag==notificationtag)
//            {
//                // 删除本地通知
//                [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
//                break;
//            }
//        }
//    }
}


- (void)joinLocationNotication
{
    // 添加本地通知
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil)
    {
        // 设置重复间隔
        notification.repeatInterval = kCFCalendarUnitDay;
        // 设置提醒时间，倒计时以秒为单位。以下是从现在开始55秒以后通知
        notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:usedTime];
        // 设置时区，使用本地时区
        notification.timeZone=[NSTimeZone defaultTimeZone];
        // 设置提示的文字
        notification.alertBody=noticationTitle;
        // 设置提示音，使用默认的
//        notification.soundName= UILocalNotificationDefaultSoundName;
        notification.soundName = @"clock.caf";//[[NSBundle mainBundle] pathForResource:@"clock" ofType:@"caf"];

        // 锁屏后提示文字，一般来说，都会设置与alertBody一样
        notification.alertAction = NSLocalizedString(noticationRemark, nil);
        
        notification.hasAction = YES; //是否显示额外的按钮，为no时alertAction消失
        
        
        // 这个通知到时间时，你的应用程序右上角显示的数字. 获取当前的数字+1
        notification.applicationIconBadgeNumber = [[[UIApplication sharedApplication] scheduledLocalNotifications] count]+1;
        //给这个通知增加key 便于半路取消。nfkey这个key是自己随便写的，还有notificationtag也是自己定义的ID。假如你的通知不会在还没到时间的时候手动取消，那下面的两行代码你可以不用写了。取消通知的时候判断key和ID相同的就是同一个通知了。
         NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[joinRemindID integerValue]],@"nfkey",[[ [SaveUserInfo loadCustomObjectWithKey]data] dataIdentifier],DEF_ACONUserID,nil];
        [notification setUserInfo:dict];
        // 启用这个通知
        [[UIApplication sharedApplication]  scheduleLocalNotification:notification];
        // 创建了就要学会释放。如果不加这一句，通知到时间了，发现顶部通知栏提示的地方有了，然后你通过通知栏进去，然后你发现通知栏里边还有这个提示，除非你手动清除
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"提醒设置成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark 接受到通知
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"接受到通知");
    
    // 取消某个特定的本地通知
//    for (UILocalNotification *noti in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
//        
//        }
    }
/**
 *  本地通知
 */
- (void)joinLocationNotication1
{
    ZWLog(@"提醒设置");
    ///注册下回调
    [[LKAlarmMamager shareManager] registDelegateWithObject:self];
    
    ///本地提醒
    LKAlarmEvent* notifyEvent = [LKAlarmEvent new];
    notifyEvent.title = [NSString stringWithFormat:@"%@",noticationTitle];//实际提醒文字是提醒事件中的文字
    ///强制加入到本地提醒中
    notifyEvent.isNeedJoinLocalNotify = YES;
    ///20秒后提醒我
    notifyEvent.startDate = [NSDate dateWithTimeIntervalSinceNow:usedTime];
    
    notifyEvent.repeatType = NSCalendarUnitDay;//每天重复
   // NSLog(@"++++_______%ld",(long)notifyEvent.eventId);
    
    [[LKAlarmMamager shareManager] addAlarmEvent:notifyEvent];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"提醒设置成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];

}

-(void)lk_receiveAlarmEvent:(LKAlarmEvent *)event
{
//    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:noticationTitle message:event.title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alertView show];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    [[LKAlarmMamager shareManager] handleOpenURL:url];
    
    return YES;
}
//-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
//{
////    [[LKAlarmMamager shareManager] didReceiveLocalNotification:notification];
//}
/*********************/

#pragma mark - 键盘处理

#pragma mark 监听系统发出的键盘通知

- (void)addKeyboardNote

{
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    // 1.显示键盘
    
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
    
    // 2.隐藏键盘
    
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark 显示一个新的键盘就会调用

- (void)keyboardWillShow:(NSNotification *)note

{
    
    // 1.取得当前聚焦文本框最下面的Y值
    
//    CGFloat fieldMaxY = CGRectGetMaxY(cellTextFiled.frame);
    
    
    CGRect fieldRect = [cellTextFiled.superview convertRect:cellTextFiled.frame toView:self.view];

    CGFloat fieldMaxY = CGRectGetMaxY(fieldRect);

    // 2.计算键盘的Y值
    
    // 2.1.取出键盘的高度
    
    CGFloat keyboardH = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    
    // 2.2.控制器view的高度 - 键盘的高度
    
    CGFloat keyboardY = self.view.frame.size.height - keyboardH;

    
    // 3.比较 文本框最大Y 跟 键盘Y
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (duration <= 0.0) {
        
        duration = 0.25;
        
    }
    
    
    [UIView animateWithDuration:duration animations:^{
        
        if (fieldMaxY > keyboardY) { // 键盘挡住了文本框
            
            self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - fieldMaxY - 10);
            
        } else { // 没有挡住文本框
            
            self.view.transform = CGAffineTransformIdentity;
            
        }
        
    }];
    
}

#pragma mark 隐藏键盘就会调用

- (void)keyboardWillHide:(NSNotification *)note

{
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.view.transform = CGAffineTransformIdentity;
        
    }];
    
}

- (void)dealloc

{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

////////////////////////////
#pragma mark - Private

- (void)hideMenuOptionsAnimated:(BOOL)animated
{
    __block BloodGlucoseManageController *weakSelf = self;
    [self.cellDisplayingMenuOptions setMenuOptionsViewHidden:YES animated:animated completionHandler:^{
        weakSelf.customEditing = NO;
    }];
}

- (void)setCustomEditing:(BOOL)customEditing
{
    if (_customEditing != customEditing) {
        _customEditing = customEditing;
        self.tableView.scrollEnabled = !customEditing;
        if (customEditing) {
            if (!_overlayView) {
                _overlayView = [[DAOverlayView alloc] initWithFrame:self.view.bounds];
                _overlayView.backgroundColor = [UIColor clearColor];
                _overlayView.delegate = self;
            }
            self.overlayView.frame = self.view.bounds;
            [self.view addSubview:_overlayView];
            if (self.shouldDisableUserInteractionWhileEditing) {
                for (UIView *view in self.tableView.subviews) {
                    if ((view.gestureRecognizers.count == 0) && view != self.cellDisplayingMenuOptions && view != self.overlayView) {
                        view.userInteractionEnabled = NO;
                    }
                }
            }
        } else {
            self.cellDisplayingMenuOptions = nil;
            [self.overlayView removeFromSuperview];
            for (UIView *view in self.tableView.subviews) {
                if ((view.gestureRecognizers.count == 0) && view != self.cellDisplayingMenuOptions && view != self.overlayView) {
                    view.userInteractionEnabled = YES;
                }
            }
        }
    }
}

#pragma mark * DAContextMenuCell delegate

- (void)contextMenuDidHideInCell:(RemindSeetingCell *)cell
{
    self.customEditing = NO;
    self.customEditingAnimationInProgress = NO;
}

- (void)contextMenuDidShowInCell:(RemindSeetingCell *)cell
{
    self.cellDisplayingMenuOptions = cell;
    self.customEditing = YES;
    self.customEditingAnimationInProgress = NO;
}

- (void)contextMenuWillHideInCell:(RemindSeetingCell *)cell
{
    self.customEditingAnimationInProgress = YES;
}

- (void)contextMenuWillShowInCell:(RemindSeetingCell *)cell
{
    self.customEditingAnimationInProgress = YES;
}

- (BOOL)shouldShowMenuOptionsViewInCell:(RemindSeetingCell *)cell
{
    return self.customEditing && !self.customEditingAnimationInProgress;
}

#pragma mark * DAOverlayView delegate

- (UIView *)overlayView:(DAOverlayView *)view didHitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL shouldIterceptTouches = YES;
    CGPoint location = [self.view convertPoint:point fromView:view];
    CGRect rect = [self.view convertRect:self.cellDisplayingMenuOptions.frame toView:self.view];
    shouldIterceptTouches = CGRectContainsPoint(rect, location);
    if (!shouldIterceptTouches) {
        [self hideMenuOptionsAnimated:YES];
    }
//    return (shouldIterceptTouches) ? [self.cellDisplayingMenuOptions hitTest:point withEvent:event] : view;
    return [self.cellDisplayingMenuOptions hitTest:point withEvent:event];
}

#pragma mark * UITableView delegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView cellForRowAtIndexPath:indexPath] == self.cellDisplayingMenuOptions) {
        [self hideMenuOptionsAnimated:YES];
        return NO;
    }
    return YES;
}

#pragma mark 刷新时间

- (void)reloadTime
{
    if (dateAndTime) {
        [dateAndTime initTime];
    }
}
-(void)popView
{
    [popImg removeFromSuperview];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"111" forKey:@"111"];
    [defaults synchronize];
    
    
}

#pragma mark - 通知数组排序 有无需求？
- (NSMutableArray *)rankNotificationArray:(NSMutableArray *)arr
{
    if (arr.count <=0) {
        return [NSMutableArray array];
    }
    
    NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
    
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[arr sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor1, nil]]];
    return array;
}

@end
