//
//  AboutAikangViewController.m
//  ACONApp
//
//  Created by fyf on 14/12/5.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "AboutAikangViewController.h"

#import "AboutAikangModel.h"
#import "AboutAikangData.h"

@interface AboutAikangViewController ()
{
    NSString *contentstr;
    NSString *imagestr;
}
@end

@implementation AboutAikangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于艾检";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
    self.edgesForExtendedLayout = NO;
    
     helper = [[WebServices alloc] initWithDelegate:self];
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
    
    //[self CreateImageView];
    //[self CreateContentView];
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];
    
    [self postAboutAikang];
}

-(void)CreateImageView{
    
    _image=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, KScreenWidth,200)];
    _image.highlighted=YES;// flag
  //  _image.image=[UIImage imageNamed:@"tupian"];
     [_image sd_setImageWithURL:[NSURL URLWithString:imagestr] placeholderImage:[UIImage imageNamed:@"tupian"]];
    
    
    [self.view addSubview:_image];
}

-(void)CreateContentView{

//    //获取txt文件
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *plistPath = [bundle pathForResource:
//                            @"23" ofType:@"txt"];//获取文件路径
//    string = [[NSString alloc]initWithContentsOfFile:plistPath encoding:NSUTF8StringEncoding error:nil];//提取文件中内容
//    _textView=[[UITextView alloc]initWithFrame:CGRectMake(0, _image.frame.origin.y+200, KScreenWidth, KScreenHeight-244)];//设置_textView（为UITextView类型）位置
//    _textView.text = string;//赋值
//    _textView.font = [UIFont systemFontOfSize:16.0];//字体
//    _textView.textColor = [UIColor darkGrayColor];
//    _textView.backgroundColor = [UIColor clearColor];
//    _textView.editable = NO;//是否可编辑
//    _textView.scrollEnabled = NO;
//    [self.view addSubview:_textView];
    
    
        _textView=[[UITextView alloc]initWithFrame:CGRectMake(0, _image.frame.origin.y+200, KScreenWidth, KScreenHeight-264)];//设置_textView（为UITextView类型）位置
        _textView.text = contentstr;//赋值
        _textView.font = [UIFont systemFontOfSize:16.0];//字体
        _textView.textColor = [UIColor darkGrayColor];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.editable = NO;//是否可编辑
        _textView.scrollEnabled = YES;
        [self.view addSubview:_textView];


}


/**
 *  关于艾康请求
 */
-(void)postAboutAikang{
    
   [MBProgressHUD showMessage:@"加载中..." toView:self.view];//显示动画
    WebServices *helper1 = [[WebServices alloc] init];
    
    NSMutableArray *arr=[NSMutableArray array];
    
    __weak AboutAikangViewController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetAboutMethodName];
    //执行异步并取得结果
     [helper1 asyncServiceUrl:GetNewsWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetAboutMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
         [MBProgressHUD hideAllHUDsForView:wself.view animated:YES];//移除动画
         if(![json isEqualToString:@""])
         {
             //返回的json字符串转换成NSDictionary
             NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
             
             AboutAikangModel *info = [[AboutAikangModel alloc] initWithDictionary:resultsDictionary];
             if (info.status == 0) {
                 
                 
                 contentstr =   [info.data[0]content];
                 imagestr =   [info.data[0]imageUrl];
                 [self CreateContentView];
                 [self CreateImageView];
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






#pragma mark - Navigation backButton Delegate
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
