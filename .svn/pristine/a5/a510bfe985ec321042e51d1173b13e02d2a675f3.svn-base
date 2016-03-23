//
//  ServiceTermViewController.m
//  ACONApp
//
//  Created by fyf on 14/11/27.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "ServiceTermViewController.h"

#import "ServiceTermModel.h"
#import "ServiceTermData.h"

@interface ServiceTermViewController ()
{
    //ServiceTermData *model;
    NSString *contentstr;
}
@end

@implementation ServiceTermViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     helper = [[WebServices alloc] initWithDelegate:self];
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButton;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
    self.title = @"服务条款";
    self.edgesForExtendedLayout = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [self postServiceTerm];
}

-(void)CreateContentView{
//    if(_webview == nil){
//        _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-KBorderH)];
//    }
//    
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64)];//设置_textView（为UITextView类型）位置
  
    _textView.text = contentstr;
    _textView.font = [UIFont systemFontOfSize:16.0];//字体
    _textView.textColor = [UIColor darkGrayColor];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.editable = NO;//是否可编辑
    _textView.scrollEnabled = YES;
    [self.view addSubview:_textView];}


/**
 *  服务条款请求
 */
-(void)postServiceTerm{

    [MBProgressHUD showMessage:@"加载中..." toView:self.view];//显示动画
    WebServices *helper1 = [[WebServices alloc] init];
    NSMutableArray *arr=[NSMutableArray array];

    __weak ServiceTermViewController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetServiceClauseMethodName];
    //执行异步并取得结果
    [helper1 asyncServiceUrl:GetNewsWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetServiceClauseMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:wself.view animated:YES];//移除动画
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            ServiceTermModel *info = [[ServiceTermModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
                
                
                contentstr =   [info.data[0]content];
                [wself CreateContentView];
                
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

#pragma mark - NavigationBack Delegate
-(void)backClick:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
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
