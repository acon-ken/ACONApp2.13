//
//  UserManageController.m
//  ACONApp
//
//  Created by fyf on 14/12/1.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "UserManageController.h"
#import "UsermanageCell.h"
#import "SearchUserController.h"
#import "LoginInfoModel.h"
#import "LoginInfoData.h"
#import "UserManageModel.h"
#import "UserManageData.h"

#import "HasAboutinfomationData.h"
#import "HasAboutinfomationModel.h"

#import "BrokenLineViewController.h"
#import "PieChartViewController.h"

@interface UserManageController ()
{
    
    NSString *namestr;
    NSString *phonestr;
    NSString *portimaegstr;
    
    LoginInfoModel *userinfo;
    NSString *f_id;
    NSString *msg_id;
}

@end

@implementation UserManageController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    self.view.backgroundColor = KBackgroundColor;
    self.title = @"用户管理";
    self.navigationController.navigationBarHidden = NO;
    self.edgesForExtendedLayout = NO;
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    
    //给导航栏加右侧按钮
    UIButton *SearchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [SearchBtn setImage:[UIImage imageNamed:@"fangdajing"] forState:UIControlStateNormal];
    [SearchBtn setImage:[UIImage imageNamed:@"fangdajing"] forState:UIControlStateSelected];
    [SearchBtn  addTarget:self action:@selector(SearchClick:) forControlEvents:UIControlEventTouchUpInside];
    SearchBtn.selected = YES;
    
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
    UIBarButtonItem *righButtonitemt  = [[UIBarButtonItem alloc] initWithCustomView:SearchBtn];
    self.navigationItem.rightBarButtonItem=righButtonitemt;
     [self postUserManage]; //获取已关注的用户信息
    [self CreatHeadView];
    [self CreateTableView];
    
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];
   
   
    
}


-(void)CreatHeadView{
    
    
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 90)];
    headview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"baise"]];
    
    UIButton *HeadBtn = [[UIButton alloc] init];
    HeadBtn.frame = headview.frame;
    [HeadBtn  addTarget:self action:@selector(HeadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    HeadBtn.selected = YES;
    
    UIImageView *leftimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 60,60)];
    leftimage.highlighted = YES;// flag
    [leftimage sd_setImageWithURL:[NSURL URLWithString:userinfo.data.portraitURL] placeholderImage:[UIImage imageNamed:@"touxiang"]];

    
    UILabel *nameLB = [[UILabel alloc]initWithFrame:CGRectMake(leftimage.frame.origin.x+80, leftimage.frame.origin.y+10, 70, 30)];
    nameLB.text=userinfo.data.loginName;
    nameLB.textColor = [UIColor blackColor];
    nameLB.font = [UIFont fontWithName:@"Helvetica" size:18];
    nameLB.textAlignment=NSTextAlignmentCenter;
    [nameLB sizeToFit];
    nameLB.textColor = [UIColor blackColor];
    nameLB.font = [UIFont fontWithName:@"Helvetica" size:18];
    nameLB.textAlignment=NSTextAlignmentCenter;
    [nameLB sizeToFit];

    UILabel *PhoneLB = [[UILabel alloc]initWithFrame:CGRectMake(nameLB.frame.origin.x, leftimage.frame.origin.y+40, 70, 30)];
    PhoneLB.text=userinfo.data.phone;
    PhoneLB.textColor = [UIColor darkGrayColor];
    PhoneLB.font = [UIFont fontWithName:@"Helvetica" size:14];
    PhoneLB.textAlignment=NSTextAlignmentCenter;
    [PhoneLB sizeToFit];


    
   UIImageView *rightimage = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-23, 40, 8,11)];
    rightimage.highlighted = YES;// flag
    rightimage.image = [UIImage imageNamed:@"xiangyou"];
    
    [headview addSubview:leftimage];
    [headview addSubview:HeadBtn];
    [headview addSubview:nameLB];
    [headview addSubview:PhoneLB];
    [headview addSubview:rightimage];
    [self.view addSubview:headview];


}

-(void)CreateTableView{
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 90, KScreenWidth, KScreenHeight-90) style:UITableViewStyleGrouped];
    _tableview.rowHeight = 65;
    _tableview.dataSource=self;
    _tableview.delegate=self;
    
     [_tableview registerClass:[UsermanageCell class] forCellReuseIdentifier:@"cell"];
    
    //设置表视图的背景
    UIImageView *backgroundview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijin"]];
    _tableview.backgroundView=backgroundview;
    [self.view addSubview:_tableview];
    
    //获取到当前表视图选中的单元格
    NSIndexPath *indexPath=[_tableview indexPathForSelectedRow];
    //取消当前表视图的选中状态
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
}


//获取已经关注的用户信息
-(void)postUserManage{
    
    [AppHelper showHUD:@"加载中"];//显示动画
    WebServices *service = [[WebServices alloc] init];
    LoginInfoModel *model = [SaveUserInfo loadCustomObjectWithKey];
    LoginInfoData *data = model.data;
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:data.dataIdentifier,@"u_id", nil]];

    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetUserInfoFollowWithMethodName];
    
    __weak UserManageController *wself = self;
    [service asyncServiceUrl:GetUserInfoFollowWithWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetUserInfoFollowWithMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [AppHelper removeHUD];//移除动画
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            HasAboutinfomationModel *info = [[HasAboutinfomationModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
                _mainArray = [NSMutableArray arrayWithArray:info.data];
                [_tableview reloadData];
                
             //   [wself CreateTableView];
                
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


//删除已经关注的用户信息
-(void)postDelete{
    
     [AppHelper showHUD:@"加载中..."];//显示动画
    WebServices *service = [[WebServices alloc] init];
    LoginInfoModel *model = [SaveUserInfo loadCustomObjectWithKey];
    LoginInfoData *data = model.data;
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:data.dataIdentifier,@"u_Id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:f_id,@"f_Id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:msg_id,@"msgId", nil]];
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:DeleteFollowMethodName];
    
    [service asyncServiceUrl:GetUserInfoFollowWithWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:DeleteFollowMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [AppHelper removeHUD];//移除动画
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            HasAboutinfomationModel *info = [[HasAboutinfomationModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
//                _mainArray = [NSMutableArray arrayWithArray:info.data];
//                [_tableview reloadData];
                
                [self postUserManage];
                
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

#pragma  mark- TableView Datesource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
} //表视图当中存在section的个数，默认是1个


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // NSArray *data= [_dataDic objectForKey:[_keyArray objectAtIndex:section]];
    return [_mainArray count];
} //section 中包含row的数量



//使我们的表示图处于编辑和非编辑状态
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    if (_tableview.editing) {
        [_tableview setEditing:NO animated:YES];
    }else{
        [_tableview setEditing:YES animated:YES];
    }
}


#pragma mark - 设置tableview的cell是否能被编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
       //所以行cell都能被编辑
    return YES;
    
}

#pragma mark - Table View delegate
#pragma mark - 设置tableview的编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
          return  UITableViewCellEditingStyleDelete;
    
}

//新增、删除按钮事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //1.delete data   2.delete from table  [先把数据源删了，再到tableview里把那行cell删了]
        
        [_mainArray removeObjectAtIndex:indexPath.row];
        [_tableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
         [self postDelete];
    }
    
    
}




//indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UsermanageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    HasAboutinfomationData *model = _mainArray[indexPath.row];
    f_id = model.userId;
    msg_id = model.msgId;
    
    
    cell.label1.text = model.loginName;
    cell.label2.text = model.phone;
    
    //获取文件中的图片，作cell前面的小图标
    //UIImageView *touxiangimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50,50)];
    //touxiangimage.highlighted = YES;// flag
    [cell.leftimage sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"touxiang"]];

    
    //cell.imageView.image=touxiangimage.image;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.textColor=[UIColor darkTextColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
} //创建单元格

#pragma  TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HasAboutinfomationData *model = _mainArray[indexPath.row];
     NSString *idstr =   model.userId;
    
    PieChartViewController *pieChartVC = [[PieChartViewController alloc] init];
    pieChartVC.otheridstr = idstr;
    pieChartVC.isme = NO;
    [self.navigationController pushViewController:pieChartVC animated:YES];

  
}


#pragma mark - Navigation backButton Delegate
-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - Navigation SearchButton Delegate
-(void)SearchClick:(id)sender{
    NSLog(@"点击搜素");

    SearchUserController *search = [[SearchUserController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark - HeadView Button Delegate
-(void)HeadBtnClick:(id)sender{
    NSLog(@"点击HeadBtn");
    
    PieChartViewController *pieChartVC = [[PieChartViewController alloc] init];
    pieChartVC.isme = YES;
    [self.navigationController pushViewController:pieChartVC animated:YES];
    
    return;
//    BrokenLineViewController *brokenVC = [[BrokenLineViewController alloc] init];
//    [self.navigationController pushViewController:brokenVC animated:YES];
}



@end
