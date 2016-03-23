//
//  SysteminformationViewController.m
//  ACONApp
//
//  Created by fyf on 14/12/5.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "SysteminformationViewController.h"
#import "SysteminformationCell.h"

#import "LoginInfoModel.h"
#import "LoginInfoData.h"

#import "SysteminformationModel.h"
#import "SysteminformationData.h"


@interface SysteminformationViewController ()
{
   
    
    NSString *f_idstr; //发送人的Id
    NSString *msgid;//信息Id
   
    UILabel *TiTlabel; //视图底部有数据时提示语
    UILabel *AlertTiTlabel; //视图底部没有数据时提示语
    
    SysteminformationData *iiifo;
    
    
}
@end

@implementation SysteminformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.edgesForExtendedLayout = NO;
    self.title = @"系统消息";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
   
    helper = [[WebServices alloc] initWithDelegate:self];
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;

    [self CreateTableView];
    [self CreateFootView];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [self postSysteminformation];
   
}

-(void)CreateTableView{

    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-120) style:UITableViewStylePlain];
    _tableview.rowHeight  = 90;
    _tableview.dataSource=self;
    _tableview.delegate=self;
    
    [_tableview registerClass:[SysteminformationCell class] forCellReuseIdentifier:@"cell"];
    
    //设置表视图的背景
    UIImageView *backgroundview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijing"]];
    _tableview.backgroundView=backgroundview;
    [self.view addSubview:_tableview];
    
    //获取到当前表视图选中的单元格
    NSIndexPath *indexPath=[_tableview indexPathForSelectedRow];
    //取消当前表视图的选中状态
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
}


//系统消息列表请求
-(void)postSysteminformation{
    
   [MBProgressHUD showMessage:@"加载中..." toView:self.view];//显示动画
    WebServices *helper1 = [[WebServices alloc] init];
    
    LoginInfoModel *model = [SaveUserInfo loadCustomObjectWithKey];
    LoginInfoData *data = model.data;
    
    NSMutableArray *arr=[NSMutableArray array];
    
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:data.dataIdentifier,@"receiveUserId", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"pageIndex", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"5",@"pageSite", nil]];
    
    __weak SysteminformationViewController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:MessageListMethodName];
    //执行异步并取得结果
    [helper1 asyncServiceUrl:GetUserInfoFollowWithWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:MessageListMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [MBProgressHUD hideHUDForView:wself.view animated:YES];//移除动画

        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            SysteminformationModel *info = [[SysteminformationModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
                _mainArray = [NSMutableArray arrayWithArray:info.data];
                
                if (_mainArray.count>0) {
                    TiTlabel.hidden = NO;
                }else{
                    TiTlabel.hidden = YES;
                    AlertTiTlabel.hidden = NO;
                }
                
                [_tableview reloadData];
                
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


//系统消息，接受用户请求，建立用户关系
-(void)postAccept{
    
  WebServices *helper2 = [[WebServices alloc] init];
    
    LoginInfoModel *model = [SaveUserInfo loadCustomObjectWithKey];
    LoginInfoData *data = model.data;
    
    NSMutableArray *arr=[NSMutableArray array];

    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:data.dataIdentifier,@"f_Id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:f_idstr,@"u_Id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:msgid,@"msgId", nil]];
    
   
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:InsertFollowedMethodName];
    //执行同步并取得结果
    [helper2 asyncServiceUrl:GetUserInfoFollowWithWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:InsertFollowedMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            UserModel *info = [[UserModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
              
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




//系统消息，拒绝用户请求
-(void)postRefuse{
    
   WebServices *helper3 = [[WebServices alloc] init];
    
    NSMutableArray *arr=[NSMutableArray array];
   
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:msgid,@"mesId", nil]];
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:RejectRequestMethodName];
    //执行同步并取得结果
    [helper3 asyncServiceUrl:GetUserInfoFollowWithWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:RejectRequestMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            UserModel *info = [[UserModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
                
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


-(void)CreateFootView{

    
    //添加分割线3
    UIImageView *Lineimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, KScreenHeight-120, KScreenWidth, 1)];
    Lineimage.highlighted = YES;// flag
    Lineimage.image = [UIImage imageNamed:@"xian"];
    
   TiTlabel = [[UILabel alloc]initWithFrame:CGRectMake(0,Lineimage.frame.origin.y+10, KScreenWidth, 30)];
    TiTlabel.backgroundColor = [UIColor clearColor];
    TiTlabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    TiTlabel.textColor = [UIColor darkGrayColor];
    TiTlabel.text = @"接受后在用户管理可以互相查看对方的血糖信息啦";
    TiTlabel.textAlignment = NSTextAlignmentCenter;
    
    AlertTiTlabel = [[UILabel alloc]initWithFrame:CGRectMake(0,Lineimage.frame.origin.y+10, KScreenWidth, 30)];
    AlertTiTlabel.backgroundColor = [UIColor clearColor];
    AlertTiTlabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    AlertTiTlabel.textColor = [UIColor darkGrayColor];
    AlertTiTlabel.text = @"当前您没有系统消息";
    AlertTiTlabel.textAlignment = NSTextAlignmentCenter;
    AlertTiTlabel.hidden = YES;


    [self.view addSubview:Lineimage];
    [self.view addSubview:TiTlabel];
    [self.view addSubview:AlertTiTlabel];
    

}

#pragma  mark- TableView Datesource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
} //表视图当中存在section的个数，默认是1个


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

//-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
//{
//    
//    return 5;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // NSArray *data= [_dataDic objectForKey:[_keyArray objectAtIndex:section]];
    return [_mainArray count];
} //section 中包含row的数量


//indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SysteminformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    SysteminformationData *model = _mainArray[indexPath.row];
    
    
    f_idstr = model.userIdSend;
    msgid = model.dataIdentifier;
    
    //截取Model里的时间字符串转化格式为yyyy-MM-dd
    NSMutableString* string =[NSMutableString stringWithString:model.requestDate];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate* inputDate = [inputFormatter dateFromString:string];
    [inputFormatter setDateFormat:@"yyyy/MM/dd"];
    [inputFormatter stringFromDate:inputDate];

    
    
    cell.label1.text = model.msgContent;
    cell.label2.text =[inputFormatter stringFromDate:inputDate];
    NSString *msgstatus = [NSString stringWithFormat:@"%.0f",model.msgStatus];
   
    [cell.AcceptBtn addTarget:self action:@selector(AcceptBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.AcceptBtn.selected = YES;
    cell.AcceptBtn.tag=indexPath.row+100;
    
    [cell.RefuseBtn addTarget:self action:@selector(RefuseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.RefuseBtn.selected = YES;
    cell.RefuseBtn.tag=indexPath.row+200;
    
    [cell.CancelauthorizationBtn addTarget:self action:@selector(CancelauthorizationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.CancelauthorizationBtn.selected = YES;
    cell.CancelauthorizationBtn.tag=indexPath.row+300;
    
    [cell.hasrefusedBtn addTarget:self action:@selector(hasrefusedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.hasrefusedBtn.selected = YES;
    cell.hasrefusedBtn.tag=indexPath.row+400;
    
    
    
    if (_mainArray.count>0) {
        if ([msgstatus isEqualToString:@"1"]) {
            cell.AcceptBtn.hidden = NO;
            cell.RefuseBtn.hidden = NO;
        }else if([msgstatus isEqualToString:@"2"])//点击拒绝后
        {
            cell.AcceptBtn.hidden = YES;
            cell.RefuseBtn.hidden = YES;
            cell.CancelauthorizationBtn.hidden = YES;
            cell.hasrefusedBtn.hidden = NO;
        }else//点击接受后
        {
            cell.AcceptBtn.hidden = YES;
            cell.RefuseBtn.hidden = YES;
            cell.CancelauthorizationBtn.hidden = NO;
            cell.hasrefusedBtn.hidden = YES;
        }
    }

    
    cell.backgroundColor=[UIColor clearColor];
    return cell;
} //创建单元格



//接受按钮Delegate
-(void)AcceptBtnAction:(UIButton *)sender{
    NSLog(@"----%d",sender.tag-100);
    
    UIButton *Refusebtn=(UIButton *)[self.view viewWithTag:sender.tag+100];
    UIButton *Cancelauthorizationbtn=(UIButton *)[self.view viewWithTag:sender.tag+200];
    
    
    sender.hidden=YES;
    Refusebtn.hidden=YES;
    Cancelauthorizationbtn.hidden=NO;
    [self postAccept];

}

//拒绝按钮Delegate
-(void)RefuseBtnAction:(UIButton *)sender{
    NSLog(@"----%d",sender.tag-200);
    
    UIButton *Acceptbtn=(UIButton *)[self.view viewWithTag:sender.tag-100];
    UIButton *hasrefusebtn=(UIButton *)[self.view viewWithTag:sender.tag+200];
    
    sender.hidden=YES;
    Acceptbtn.hidden = YES;
    hasrefusebtn.hidden = NO;
    
    [self postRefuse];
}




//已拒绝按钮Delegate
-(void)hasrefusedBtnAction:(UIButton *)sender{
    NSLog(@"----%d",sender.tag-300);
    
}

//取消拒绝按钮Delegate
-(void)CancelauthorizationBtnAction:(UIButton *)sender{
    NSLog(@"----%d",sender.tag-400);
    
    
}








#pragma  TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //
    //    SelectDataViewController *selectdata = [[SelectDataViewController alloc]init];
    //    [self.navigationController pushViewController:selectdata animated:YES];
    //    /////测试＋＋＋＋＋＋＋＋＋＋＋＋
}



#pragma mark - Navigation backButton Delegate
-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
