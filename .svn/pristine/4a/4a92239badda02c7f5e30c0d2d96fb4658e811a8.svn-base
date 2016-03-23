//
//  DetailInformationController.m
//  ACONApp
//
//  Created by fyf on 14/12/4.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "DetailInformationController.h"

@interface DetailInformationController ()
{
    UILabel *DetailaddressLB; //地址Lable内容
    UILabel *DetailphoneLB;   //电话Lable内容
    UILabel *DetailDetailSayLB;  //详细说明内容
}
@end

@implementation DetailInformationController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = KBackgroundColor;
    self.title = @"详细信息";
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
    [self CreateContentView];
}

-(void)CreateImageView{
  
    
    _image=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, KScreenWidth,160)];
    _image.highlighted=YES;// flag
    [_image sd_setImageWithURL:[NSURL URLWithString:_imagestr] placeholderImage:[UIImage imageNamed:@"tu"]];

    
    [self.view addSubview:_image];


}

-(void)CreateContentView{
    UILabel *addressLB = [[UILabel alloc]initWithFrame:CGRectMake(10, _image.frame.origin.y+170, KScreenWidth, 30)];
    addressLB.font = [UIFont fontWithName:@"Helvetica" size:16];
    addressLB.textColor = [UIColor blackColor];
    addressLB.text = @"地址：";
    
    DetailaddressLB = [[UILabel alloc]initWithFrame:CGRectMake(addressLB.frame.origin.x, addressLB.frame.origin.y+30, KScreenWidth, 30)];
    DetailaddressLB.font = [UIFont fontWithName:@"Helvetica" size:14];
    DetailaddressLB.textColor = [UIColor darkGrayColor];
    DetailaddressLB.text = _addressstr;
    
    UILabel *phoneLB = [[UILabel alloc]initWithFrame:CGRectMake(DetailaddressLB.frame.origin.x, DetailaddressLB.frame.origin.y+40, KScreenWidth, 30)];
    phoneLB.font = [UIFont fontWithName:@"Helvetica" size:16];
    phoneLB.textColor = [UIColor blackColor];
    phoneLB.text = @"电话：";
    
    DetailphoneLB = [[UILabel alloc]initWithFrame:CGRectMake(DetailaddressLB.frame.origin.x, phoneLB.frame.origin.y+30, KScreenWidth, 30)];
    DetailphoneLB.font = [UIFont fontWithName:@"Helvetica" size:13];
    DetailphoneLB.textColor = [UIColor darkGrayColor];
    DetailphoneLB.text = _phonestr;

    
    UILabel *DetailSayLB = [[UILabel alloc]initWithFrame:CGRectMake(DetailaddressLB.frame.origin.x, DetailphoneLB.frame.origin.y+40, KScreenWidth, 30)];
    DetailSayLB.font = [UIFont fontWithName:@"Helvetica" size:16];
    DetailSayLB.textColor = [UIColor blackColor];
    DetailSayLB.text = @"详细说明：";
    
    
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(DetailSayLB.frame), KScreenWidth, KScreenHeight - CGRectGetMaxY(DetailSayLB.frame) - 64)];//设置_textView（为UITextView类型）位置
    _textView.backgroundColor=[UIColor redColor];
    _textView.text = _contentstr;
    _textView.font = [UIFont systemFontOfSize:16.0];//字体
    _textView.textColor = [UIColor darkGrayColor];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.editable = NO;//是否可编辑
    _textView.scrollEnabled = YES;
    [self.view addSubview:_textView];

    
    [self.view addSubview:addressLB];
    [self.view addSubview:DetailaddressLB];
    [self.view addSubview:phoneLB];
    [self.view addSubview:DetailphoneLB];
    [self.view addSubview:DetailSayLB];
  

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
