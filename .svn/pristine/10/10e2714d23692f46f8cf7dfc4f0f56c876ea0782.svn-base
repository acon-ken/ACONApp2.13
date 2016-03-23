//
//  AiKangNewsViewController.m
//  ACONApp
//
//  Created by fyf on 14/12/1.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "AiKangNewsViewController.h"
#import "NewsCell.h"

#import "NewsDetailController.h"

#import "AikangNewsModel.h"
#import "AikangNewsData.h"
#import "TangniaoNewsModel.h"
#import "TangniaoNewsData.h"

#define KCTaskSearchNavigationColor [UIColor colorWithRed:62/255.0 green:206/255.0 blue:232/255.0 alpha:1.0]

@interface AiKangNewsViewController ()
{
    TangniaoNewsModel *info1;
    AikangNewsModel *info;
    NewsDetailController *newsdetail;
    NSString *idstrrr; //修改艾康资讯浏览量的ID参数字符串
}

@end

@implementation AiKangNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    helper = [[WebServices alloc] initWithDelegate:self];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
    self.title = @"艾检资讯";//@"艾康资讯";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBarHidden = NO;
    
    [self CreateTableView1];
    [self selectButttonView];
    
    [self postAikangNews];
    [self postAikangNewsTangniaobing];

    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
  
    
}



-(void)selectButttonView{
    
    NSArray *items=@[@"行业动态",@"健康学堂"];//@[@"艾康新闻",@"糖尿病知识"];
    
    _sc = [[UISegmentedControl alloc]initWithItems:items];
      _sc.selectedSegmentIndex = 0;
    _sc.frame=CGRectMake(5, 10, KScreenWidth-10, 35);
    [_sc addTarget:self action:@selector(segmentAction:)
  forControlEvents:
     UIControlEventValueChanged];
    _sc.tintColor=KCTaskSearchNavigationColor;
    
    [self.view addSubview:_sc];

}

-(void)CreateTableView1{
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0 , 50, KScreenWidth, KScreenHeight-50-64) style:UITableViewStyleGrouped];
    _tableview.rowHeight  = 70;
    _tableview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
    _tableview.tag=1;
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [_tableview registerClass:[NewsCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableview];
}


-(void)CreateTableView2{
//    _dataDic=[NSMutableArray arrayWithObjects:@"科技行业迎来春天",@"艾康生物",@"血红蛋白",@"行业最新动态", nil];
//    _dataDic2=[NSMutableArray arrayWithObjects:@"年收入增长20%，年利润增长38%，三季度预期30%～50%。上半年减少毛利率低下的番茄酱和...",@"年收入增长20%，年利润增长38%，三季度预期30%～50%。上半年减少毛利率低下的番茄酱和...",@"年收入增长20%，年利润增长38%，三季度预期30%～50%。上半年减少毛利率低下的番茄酱和...", @"年收入增长20%，年利润增长38%，三季度预期30%～50%。上半年减少毛利率低下的番茄酱和...", nil];
//    _dataDic3=[NSMutableArray arrayWithObjects:@"2014-08-08",@"2014-08-08",@"2014-08-08",@"2014-08-08",nil];
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, KScreenWidth, KScreenHeight-50-64) style:UITableViewStyleGrouped];
    _tableview.rowHeight  = 70;
    _tableview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
    _tableview.tag=2;
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [_tableview registerClass:[NewsCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableview];
    
}


#pragma mark - Navigation backButton Delegate
-(void)backClick:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - SelectButtonView Delegate
-(void)segmentAction:(id)sender{
    
    NSInteger i = [_sc selectedSegmentIndex];
    if (i == 0) {
        
        CATransition *transaction = [CATransition animation];
        //设置专场动画类型
        [transaction setType:kCATransitionFromRight];
        [transaction setDuration:1.0f];
        [transaction  setSubtype:kCATransitionFromRight];
        [_tableview.layer addAnimation:transaction forKey:nil];
        [_tableview removeFromSuperview];
        
        [self CreateTableView1];
        [_tableview reloadData];
        
    }
    if (i == 1) {
        
        CATransition *transaction = [CATransition animation];
        //设置专场动画类型
        [transaction setType:kCATransitionFromRight];
        [transaction setDuration:1.0f];
        [transaction  setSubtype:kCATransitionFromRight];
        [_tableview.layer addAnimation:transaction forKey:nil];
        
    
        [_tableview removeFromSuperview];
      //  [self postAikangNewsTangniaobing];
        [self CreateTableView2];
        [_tableview reloadData];
  }
}

//艾康新闻
-(void)postAikangNews{
    
    
    WebServices *helper1 = [[WebServices alloc] init];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"7028e577-59bc-ab97-459d-1b55019e767d",@"infoType", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"pageIndex", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"100",@"pageSize", nil]];
    
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetNewsMethodName];
    //执行异步并取得结果
    [helper1 asyncServiceUrl:GetNewsWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetNewsMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
   

   
        if(![json isEqualToString:@""])
    {
            //返回的json字符串转换成NSDictionary
        NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
        info = [[AikangNewsModel alloc] initWithDictionary:resultsDictionary];
        if (info.status == 0) {
                
            _mainArray1 = [NSMutableArray arrayWithArray:info.data];
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

//糖尿病知识
-(void)postAikangNewsTangniaobing{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];//显示动画
    WebServices *helper2 = [[WebServices alloc] init];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"90d0afd8-f898-d200-d74f-ffdc79c40dfc",@"infoType", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"pageIndex", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"100",@"pageSize", nil]];
    
    
    __weak AiKangNewsViewController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetNewsMethodName];
    //执行异步并取得结果
    [helper2 asyncServiceUrl:GetNewsWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetNewsMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
         [MBProgressHUD hideHUDForView:wself.view animated:YES];//移除动画
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            info1 = [[TangniaoNewsModel alloc] initWithDictionary:resultsDictionary];
            if (info1.status == 0) {
                
                _mainArray2 = [NSMutableArray arrayWithArray:info1.data];
                [_tableview reloadData];
                
                
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:info1.msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
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



//修改艾康咨询浏览量，每次详请加1
-(void)postAikangNewsScans{
    
    WebServices *helper3 = [[WebServices alloc] init];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:idstrrr,@"infoId", nil]];
    
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:ChangePageViewsMethodName];
    //执行异步并取得结果
     [helper3 asyncServiceUrl:GetNewsWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:ChangePageViewsMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
       
         if(![json isEqualToString:@""])
         {
             //返回的json字符串转换成NSDictionary
             NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
             
             UserModel *info11 = [[UserModel alloc] initWithDictionary:resultsDictionary];
             if (info11.status == 0) {
                 
                    
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



#pragma  mark- TableView Datesource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
} //表视图当中存在section的个数，默认是1个


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag==1) {
        return [_mainArray1 count];
    }
    if (tableView.tag==2) {
        return [_mainArray2 count];
    }
    return 0;

} //section 中包含row的数量


//indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
      //  NSInteger ID=[indexPath section];
    if (tableView.tag==1) {
        
        if(_mainArray1 != nil && [_mainArray1 count]>0){
            
            AikangNewsData *model = _mainArray1[indexPath.row];
            NSString *imageUrlstr = model.imageUrl;
            
            //截取Model里的时间字符串转化格式为yyyy-MM-dd
            NSMutableString* string =[NSMutableString stringWithString:model.addTime];
            NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
            [inputFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
            
            NSDate* inputDate = [inputFormatter dateFromString:string];
            [inputFormatter setDateFormat:@"yyyy-MM-dd"];
            [inputFormatter stringFromDate:inputDate];

            
            cell.label1.text = model.title;
            cell.label2.text = model.content;
            cell.label3.text= [inputFormatter stringFromDate:inputDate];
            
            [cell.leftimage sd_setImageWithURL:[NSURL URLWithString:imageUrlstr] placeholderImage:[UIImage imageNamed:@"tu.png"]];

            /*----------------取消cell的选中状态---------------*/
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            
            
        }

    }if(tableView.tag==2){
        if(_mainArray2 != nil && [_mainArray2 count]>0){
            
            TangniaoNewsData *modell = _mainArray2[indexPath.row];
            NSString *imageStr = modell.imageUrl;
            
            //截取Model里的时间字符串转化格式为yyyy-MM-dd
            NSMutableString* string =[NSMutableString stringWithString:modell.addTime];
            NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
            [inputFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
            
            NSDate* inputDate = [inputFormatter dateFromString:string];
            [inputFormatter setDateFormat:@"yyyy-MM-dd"];
            [inputFormatter stringFromDate:inputDate];

            
            cell.label1.text = modell.title;
            cell.label2.text = modell.content;
            cell.label3.text = [inputFormatter stringFromDate:inputDate];
           
             [cell.leftimage sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"tu.png"]];
            /*----------------取消cell的选中状态---------------*/
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            
        }
        
    }

    cell.backgroundColor=[UIColor clearColor];

    
    
    return cell;

} //创建单元格

#pragma  TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag==1) {
        

        newsdetail = [[NewsDetailController alloc]init];
        
        //截取Model里的时间字符串转化格式为yyyy-MM-dd
        NSMutableString* string =[NSMutableString stringWithString:[info.data[indexPath.row]addTime]];
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        
        NSDate* inputDate = [inputFormatter dateFromString:string];
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
        [inputFormatter stringFromDate:inputDate];

        
        newsdetail.imagestr = [info.data[indexPath.row]imageUrl];
        newsdetail.idstr =  [info.data[indexPath.row]title];
        newsdetail.time = [inputFormatter stringFromDate:inputDate];
        newsdetail.contentstr = [info.data[indexPath.row]content];
       

        idstrrr=[info.data[indexPath.row]dataIdentifier];
        [self postAikangNewsScans];
        newsdetail.Clickcount =[NSString stringWithFormat:@"%f",[info.data[indexPath.row]pageView]];
        
        
    [self.navigationController pushViewController:newsdetail animated:YES];
    }
    if (tableView.tag==2) {
       
      
     
        newsdetail = [[NewsDetailController alloc]init];
        
         //截取Model里的时间字符串0到10位
        NSString *JiequDatastr2= [[info1.data[indexPath.row]addTime] substringWithRange:NSMakeRange(0,10)];
        //把jiequDatastr1转换格式：分隔号为“－”
        NSString *CurrentDateStr2 = [JiequDatastr2 stringByReplacingOccurrencesOfString:@"\/" withString:@"-"];

        
        newsdetail.imagestr = [info1.data[indexPath.row]imageUrl];
        newsdetail.idstr =  [info1.data[indexPath.row]title];
        newsdetail.time =CurrentDateStr2;
        newsdetail.contentstr = [info1.data[indexPath.row]content];
        
        idstrrr =[info1.data[indexPath.row]dataIdentifier];
        
        [self postAikangNewsScans];
        newsdetail.Clickcount =[NSString stringWithFormat:@"%f",[info1.data[indexPath.row]pageView]];

        
        [self.navigationController pushViewController:newsdetail animated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
