//
//  SearchErweimaViewController.m
//  ACONApp
//
//  Created by fyf on 14/12/1.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "SearchErweimaViewController.h"
#import "UsermanageCell.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "SearchUserModel.h"
#import "SearchUserData.h"



@interface SearchErweimaViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *Midimage;
    SearchUserModel *info;

    
    NSMutableArray *searchSeccessArray;
    
    UIView *footerView;
    
    NSString *Usernamestr;
    NSString *regPushIdstr;
    NSString *receivePhonestr;
    
    NSString *scanStr;//扫描到的信息
}
@end

@implementation SearchErweimaViewController
@synthesize  mainSearchArray;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
  
    if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 
        mainSearchArray   = [NSMutableArray array];
        searchSeccessArray  =[NSMutableArray array];
    }
    
    return self ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    saomiaostatus = 1;  //测试扫描结果
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
    self.title = @"二维码搜索";
    self.edgesForExtendedLayout = NO;
    
    helper = [[WebServices alloc] initWithDelegate:self];
    
         //[readerView start];
    //[self sysbutbuttonclick];
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    
    
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
    
//------
//    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
//    scanButton.frame = CGRectMake(100, 420, 120, 40);
//    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:scanButton];
    
//    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(15, 40, 290, 50)];
//    labIntroudction.backgroundColor = [UIColor clearColor];
//    labIntroudction.numberOfLines=2;
//    labIntroudction.textColor=[UIColor whiteColor];
//    labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
//    [self.view addSubview:labIntroudction];
    
//    
//    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 300, 300)];
//    imageView.image = [UIImage imageNamed:@"pick_bg"];
//    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(20, _preview.frame.origin.y, KScreenWidth - 40, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];

    
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(20, 40+2*num, KScreenWidth - 40, 2);
        if (2*num == 260) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(20, 40+2*num, KScreenWidth -40, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
        [self setupCamera];
}


- (void)setupCamera
{
        // Device
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        // Input
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        
        // Output
        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // Session
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input])
        {
            [_session addInput:self.input];
        }
        
        if ([_session canAddOutput:self.output])
        {
            [_session addOutput:self.output];
        }
        
        // 条码类型 AVMetadataObjectTypeQRCode
        _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
//        _output.metadataObjectTypes =AVMetadataObjectTypeQRCode;
    
        // Preview
        _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _preview.frame =CGRectMake(20, 40, KScreenWidth - 40,260);
        [self.view.layer insertSublayer:self.preview atIndex:0];
        
        // Start
        [_session startRunning];
    }
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
    {
        
        
        
        NSString *stringValue;
        
        
        

        
        if ([metadataObjects count] >0)
        {
            AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
            stringValue = metadataObject.stringValue;
            scanStr = stringValue;

              [_session stopRunning];//捕捉器停止运行


            [self getAllUser];
            _line.hidden = YES;
                [timer invalidate];
        }
        
        
       
        [self dismissViewControllerAnimated:YES completion:^
         {
             [timer invalidate];
          
             
             NSLog(@"%@",stringValue);
         }];
    }


#pragma mark  -   ArrayCompare  

-(void)CreateErrorFootView{

    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_preview.frame) + 20, KScreenWidth, KScreenHeight - _preview.frame.size.height - 64)];
    UILabel *TITErrorLB = [[UILabel alloc]initWithFrame:CGRectMake(footerView.frame.origin.x+128, 20, 70, 30)];
    TITErrorLB.text=@"扫描失败";
    TITErrorLB.textColor = [UIColor blackColor];
    TITErrorLB.textAlignment=NSTextAlignmentCenter;
    [TITErrorLB sizeToFit];
    
    UILabel *SUbTITLB = [[UILabel alloc]initWithFrame:CGRectMake(TITErrorLB.frame.origin.x-15, TITErrorLB.frame.origin.y+40, 70, 30)];
    SUbTITLB.text=@"未找到此用户";
    SUbTITLB.textColor = [UIColor blackColor];
    SUbTITLB.textAlignment=NSTextAlignmentCenter;
    [SUbTITLB sizeToFit];
    
    
    UIButton *GoOnBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, SUbTITLB.frame.origin.y+35, KScreenWidth-40, 35)];
    [GoOnBtn setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    [GoOnBtn setTitle:@"继续扫描" forState:UIControlStateNormal];
    [GoOnBtn addTarget:self action:@selector(GoOnBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    GoOnBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [GoOnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    GoOnBtn.tag =004;
    GoOnBtn.selected = YES;
    [footerView addSubview:GoOnBtn];

    
    [footerView addSubview:TITErrorLB];
    [footerView addSubview:SUbTITLB];
    
    [self.view addSubview:footerView];

}

-(void)CreateSuccessFootView/*:(NSMutableArray *)TempmainArray*/{
    UILabel *TITSuccessLB = [[UILabel alloc]initWithFrame:CGRectMake(10, Midimage.frame.origin.y+300, 70, 30)];
    TITSuccessLB.text=@"扫描成功";
    TITSuccessLB.font = [UIFont fontWithName:@"Helvetica" size:13];
    TITSuccessLB.textColor = [UIColor blackColor];
    TITSuccessLB.textAlignment=NSTextAlignmentCenter;
    [TITSuccessLB sizeToFit];
    [self.view addSubview:TITSuccessLB];
    
   

    
    
    mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TITSuccessLB.frame.origin.y+40, KScreenWidth, KScreenHeight-TITSuccessLB.frame.origin.y-40) style:UITableViewStyleGrouped];
    mainTableView.rowHeight  = 60;
    mainTableView.dataSource=self;
    mainTableView.delegate=self;
    

    [mainTableView registerClass:[UsermanageCell class] forCellReuseIdentifier:@"cell"];
    
    //设置表视图的背景
    UIImageView *backgroundview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijin"]];
    mainTableView.backgroundView=backgroundview;
    [self.view addSubview:mainTableView];
    
    //获取到当前表视图选中的单元格
    NSIndexPath *indexPath=[mainTableView indexPathForSelectedRow];
    //取消当前表视图的选中状态
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma  mark- TableView Datesource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
} //表视图当中存在section的个数，默认是1个


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
  
    
    return 1;
} //section 中包含row的数量


//indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UsermanageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
//    cell.label1.text = searchUsermodel.loginName;
//    cell.label2.text = searchUsermodel.phone;
//     [ cell.leftimage sd_setImageWithURL:[NSURL URLWithString:searchUsermodel.portraitURL] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    
    cell.label1.text = [info.data[0] loginName];//[searchSeccessArray[0] loginName];
    cell.label2.text = [info.data[0] phone];//[searchSeccessArray[0] phone];
    
    [ cell.leftimage sd_setImageWithURL:[NSURL URLWithString:[info.data[0] portraitURL]]/*[searchSeccessArray [indexPath.row]portraitURL]]*/ placeholderImage:[UIImage imageNamed:@"touxiang"]];

    cell.rightimage.image = [UIImage imageNamed:@"aixin"];
    
    [cell.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.rightBtn.selected = YES;
    cell.rightBtn.tag=indexPath.row+50;

  
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor=[UIColor darkTextColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
} //创建单元格

//点击爱心按钮
-(void)rightBtnAction:(UIButton *)sender{
    
    NSLog(@"点击爱心按钮");
    
    
//    SearchUserData *model = info.data[0][sender.tag-50];
//    Usernamestr =  model.dataIdentifier;
//    regPushIdstr = model.regPushId;
//    receivePhonestr = model.phone;
    
    [self postAddUser];
}



//搜素用户
-(void)getAllUser{
    
    WebServices *helper1 = [[WebServices alloc] initWithDelegate:self];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:scanStr/*@""*/,@"inputStr", nil]];
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:SearchAllowUserInfoMethodName];
    //执行同步并取得结果
    NSString *json = [helper1 syncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:SearchAllowUserInfoMethodName soapMessage:soapMsg];
    
    if(![json isEqualToString:@""])
    {
        //返回的json字符串转换成NSDictionary
        NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
        
        info = [[SearchUserModel alloc] initWithDictionary:resultsDictionary];
        if (info.status == 0) {
            
            
            if (info.data.count>0) {
                
                [self CreateSuccessFootView];
                
            }else{
             
                [self CreateErrorFootView];
            }
            //            for (SearchUserData *model in arr) {
            //
            //                [_mainArray addObject:model.phone];
            //
            //
            //            }
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
    
}



//添加关注用户，发送推送消息
-(void)postAddUser{
    
     [AppHelper showHUD:@"加载中..."];//显示动画
    WebServices *service = [[WebServices alloc] init];
    
    LoginInfoModel *model = [SaveUserInfo loadCustomObjectWithKey];
    LoginInfoData *data = model.data;
    
    NSString *str = @"搜索到了您想关注您";

    NSString *msgstr=[NSString stringWithFormat:@"%@",str];

    NSMutableArray *arr=[NSMutableArray array];

    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:data.dataIdentifier,@"sendUserId", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:data.userName,@"sendUserName", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[info.data[0]dataIdentifier],@"receiveUserId", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[info.data[0]regPushId],@"receivePushId", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[info.data[0]phone],@"receivePhone", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:msgstr,@"msgContent", nil]];

    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:ReceiveUserRequestMethodName];

    [service asyncServiceUrl:GetUserInfoFollowWithWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:ReceiveUserRequestMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
         [AppHelper removeHUD];//移除动画
        
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            UserModel *info11 = [[UserModel alloc] initWithDictionary:resultsDictionary];
            if (info11.status == 0) {
                
                //            _mainArray = [NSMutableArray arrayWithArray:info.data];
                //            [mainTableView reloadData];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:info11.msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
                
                
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:info11.msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
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



// 选择行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSIndexPath *index = [tableView indexPathForSelectedRow];//获取当前选中单元格的IndexPath
    //    //取消选中行
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //
    //    TaskSearchOverController *searcheroverview = [[TaskSearchOverController alloc]init];
    //    self.delegate = searcheroverview;
    //    [self.delegate changevalue:index];
    //
    //    //用模态视图弹出materialdetailview页面
    //    [self presentViewController:searcheroverview animated:YES completion:nil];
    
}



#pragma mark - Navigation backButton Delegate
-(void)backClick:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation SearchButton Delegate
-(void)erweimaBtnClick:(id)sender{
    
    NSLog(@"扫描二维码");
}

#pragma mark - GoOnBtn Delegate
-(void)GoOnBtnAction:(id)sender{
    [footerView removeFromSuperview];
    footerView = nil;
    _line.hidden = NO;
    
    upOrdown = NO;
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];

    
    
    
    [_session startRunning];
    NSLog(@"继续扫描");

}



@end
