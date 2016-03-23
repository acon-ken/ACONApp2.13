//
//  NewsDetailController.m
//  ACONApp
//
//  Created by fyf on 14/12/2.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "NewsDetailController.h"

#import "AikangNewsModel.h"

@interface NewsDetailController ()
{
    UILabel *TiTLB;
    UILabel *TimeLB;
    //UILabel *ScanDataLB;
    UILabel *ContentLB;
}
@end

@implementation NewsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"资讯详情";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
    self.edgesForExtendedLayout = NO;
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
    
    [self CreateImageView];
    [self CreateFootView];

}

-(void)CreateImageView{

    _image=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, KScreenWidth,160)];
    _image.highlighted=YES;// flag
    //_image.image=[UIImage imageNamed:@"tu"];
     [_image sd_setImageWithURL:[NSURL URLWithString:_imagestr] placeholderImage:[UIImage imageNamed:@"tu"]];
    
    [self.view addSubview:_image];


}

-(void)CreateFootView{
   TiTLB = [[UILabel alloc]initWithFrame:CGRectMake(0, _image.frame.origin.y+170, KScreenWidth, 40)];
    TiTLB.font = [UIFont boldSystemFontOfSize:14.0f];
    TiTLB.textColor = [UIColor blackColor];
    TiTLB.textAlignment = NSTextAlignmentCenter;
    TiTLB.numberOfLines = 0;
    TiTLB.lineBreakMode = 0;
    TiTLB.text = _idstr;
    
    TimeLB = [[UILabel alloc]initWithFrame:CGRectMake(5, TiTLB.frame.origin.y+30, 200, 30)];
    TimeLB.font = [UIFont fontWithName:@"Helvetica" size:15];
    TimeLB.textColor = [UIColor blackColor];
    TimeLB.text = _time;
    

    
    //浮点型字符串 转 整形字符串
    NSString *stringInt  =  [ NSString stringWithFormat:@"浏览量：%-7zi",[_Clickcount  intValue]];
    
    
//    ScanDataLB = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-100, TimeLB.frame.origin.y, 200, 30)];
//    ScanDataLB.font = [UIFont fontWithName:@"Helvetica" size:15];
//    ScanDataLB.textColor = [UIColor blackColor];
//    ScanDataLB.text= stringInt;

    
 
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(0, TimeLB.frame.origin.y+30, KScreenWidth, KScreenHeight-_image.frame.size.height-TiTLB.frame.size.height-TimeLB.frame.size.height-64)];//设置_textView（为UITextView类型）位置  280-10
    
    _textView.text = _contentstr;
    _textView.font = [UIFont systemFontOfSize:16.0];//字体
    _textView.textColor = [UIColor darkGrayColor];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.editable = NO;//是否可编辑    
    _textView.scrollEnabled = YES;
    [self.view addSubview:_textView];

    

    [self.view addSubview:TiTLB];
    [self.view addSubview:TimeLB];
  //  [self.view addSubview:ScanDataLB];
    
    
    
    
    

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
