//
//  ConnectAikangController.m
//  ACONApp
//
//  Created by fyf on 14/12/3.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "ConnectAikangController.h"
#import "ConnectAikangCell.h"
#import "DetailInformationController.h"

#import "ConnectAikangModel.h"
#import "ConnectAikangData.h"

@interface ConnectAikangController ()
{
    NSString *Addressstr;
    NSString *Phonestr;
    NSString *ContentStr;
    NSString *Imagestr;
    
    ConnectAikangModel *info;

}
@end

@implementation ConnectAikangController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    helper = [[WebServices alloc] initWithDelegate:self];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
    self.title = @"联系艾检";//@"联系艾康";
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBarHidden = NO;
    
     [self postConnectAikang];
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;

    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
    
    [self CreateTableView];
}


-(void)CreateTableView{
    

    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStyleGrouped];
    _tableview.rowHeight  = 70;
    _tableview.dataSource=self;
    _tableview.delegate=self;
    
    [_tableview registerClass:[ConnectAikangCell class] forCellReuseIdentifier:@"cell"];
    
    //设置表视图的背景
    UIImageView *backgroundview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijin"]];
    _tableview.backgroundView=backgroundview;
    [self.view addSubview:_tableview];
    
    //获取到当前表视图选中的单元格
    NSIndexPath *indexPath=[_tableview indexPathForSelectedRow];
    //取消当前表视图的选中状态
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
}


//联系艾康请求
-(void)postConnectAikang{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];//显示动画
    WebServices *helper1 = [[WebServices alloc] init];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"pageIndex", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"100",@"pageSize", nil]];
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetContractInfoMethodName];
    //执行异步并取得结果
    [helper1 asyncServiceUrl:GetContractInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetContractInfoMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];//移除动画
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            info = [[ConnectAikangModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
                _mainArray = [NSMutableArray arrayWithArray:info.data];
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


//indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConnectAikangCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    ConnectAikangData *model = _mainArray[indexPath.row];
    NSString *imagestr = model.imageUrl;
    
    cell.label1.text = model.suppName;
    cell.label2.text = model.phone;
    cell.label3.text = model.address;
    
    Addressstr = model.address;
    Phonestr = model.phone;
    ContentStr = model.content;
    Imagestr = model.imageUrl;
  //  cell.leftimage.image = [UIImage imageNamed:@"touxiang"];
     [cell.leftimage sd_setImageWithURL:[NSURL URLWithString:imagestr] placeholderImage:[UIImage imageNamed:@"touxiang"]];
   
    cell.backgroundColor=[UIColor clearColor];
    return cell;
} //创建单元格

#pragma  TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
   
    DetailInformationController *detailinformation = [[DetailInformationController alloc]init];
//    detailinformation.addressstr = [info.data[indexPath.row]address];
//     detailinformation.phonestr = [info.data[indexPath.row]address];
//     detailinformation.s = [info.data[indexPath.row]address];
    detailinformation.addressstr = [info.data[indexPath.row]address];
    detailinformation.phonestr =[info.data[indexPath.row]phone];
    detailinformation.contentstr =[info.data[indexPath.row]content];
    detailinformation.imagestr =[info.data[indexPath.row]imageUrl];
    
    [self.navigationController pushViewController:detailinformation animated:YES];
    
}



#pragma mark - NavigationBack Delegate
-(void)backClick:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
