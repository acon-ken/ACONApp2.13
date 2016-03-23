//
//  KnowledgeViewController.m
//  ACONApp
//
//  Created by fyf on 14/12/2.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "KnowledgeViewController.h"
#import "KnowledgeCell.h"
#import "AskQuestionController.h"

#import "KnowledgeModel.h"
#import "KnowledgeData.h"
@interface KnowledgeViewController ()

@end

@implementation KnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    helper = [[WebServices alloc] initWithDelegate:self];
    
    self.view.backgroundColor = KBackgroundColor;
    self.title = @"艾检知道";//@"艾康知道";
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBarHidden = NO;
    
   
   //  [self postKnowlege];
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    
    //给导航栏加右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0, 0, 80, 40);
    rightBtn.selected=YES;
    [rightBtn setTitle:@"我要提问" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame=CGRectMake(0, 0, 80, 40);
//    rightBtn.selected=YES;
//    [rightBtn setTitle:@"我要提问" forState:UIControlStateNormal];
//    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(pushMaterialView) forControlEvents:UIControlEventTouchUpInside];


    
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
    UIBarButtonItem *righButtonitemt  = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=righButtonitemt;
    [self CreateTableView];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self postKnowlege];



}

-(void)CreateTableView{

//    _dataDic=[NSArray arrayWithObjects:@"请问糖尿病患者可以医治的么",@"请问糖尿病患者可以医治的么",@"请问糖尿病患者可以医治的么", nil];
//    _dataDic2=[NSArray arrayWithObjects:@"亲，只要多多注意饮食习惯即可。亲，只要多多注意饮食习惯即可。亲，只要多多之一饮食习惯即可。",@"亲，只要多多注意饮食习惯即可。亲，只要多多注意饮食习惯即可。亲，只要多多之一饮食习惯即可。",@"亲，只要多多注意饮食习惯即可。亲，只要多多注意饮食习惯即可。亲，只要多多之一饮食习惯即可。", nil];
    
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight -64) style:UITableViewStyleGrouped];
//    _tableview.rowHeight  = 300;
    _tableview.dataSource=self;
    _tableview.delegate=self;
    
    [_tableview registerClass:[KnowledgeCell class] forCellReuseIdentifier:@"cell"];
    
    //设置表视图的背景
    UIImageView *backgroundview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijing"]];
    _tableview.backgroundView=backgroundview;
    [self.view addSubview:_tableview];
    
    //获取到当前表视图选中的单元格
    NSIndexPath *indexPath=[_tableview indexPathForSelectedRow];
    //取消当前表视图的选中状态
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];

}

//艾康知道请求
-(void)postKnowlege{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];//显示动画
    WebServices *helper1 = [[WebServices alloc] init];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"pageIndex", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"100",@"pageSize", nil]];
    
    __weak KnowledgeViewController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetQAMethodName];
    //执行异步并取得结果
    [helper1 asyncServiceUrl:GetQAWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetQAMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:wself.view animated:YES];//移除动画
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            KnowledgeModel *info = [[KnowledgeModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
                _mainArray = [NSMutableArray arrayWithArray:info.data];
                
                
                for (int index =0; index < [_mainArray count]; index++) {
                    
                    KnowledgeData *model  = [_mainArray objectAtIndex:index];
                    if ([ model.reply isEqualToString:@""]) {
                        
                        [_mainArray removeObject: model];
                        index--;
                    }
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





#pragma  mark- TableView Datesource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
        return [_mainArray count];
} //表视图当中存在section的个数，默认是1个


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // NSArray *data= [_dataDic objectForKey:[_keyArray objectAtIndex:section]];
    return 1;
} //section 中包含row的数量


//根据内容自定义cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    KnowledgeData *model = _mainArray[indexPath.section];
    NSString *Qstr = @"Q：";
    
    CGRect ContentlabelRect = [[Qstr stringByAppendingString:model.content]  boundingRectWithSize:CGSizeMake(KScreenWidth-15, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14.0f] forKey:NSFontAttributeName] context:nil];
    
    
    if (model.isShow==YES ) {
        
        CGRect replylabelRect = [ model.reply boundingRectWithSize:CGSizeMake(KScreenWidth-60, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Helvetica" size:12] forKey:NSFontAttributeName] context:nil];

        return ContentlabelRect.size.height + replylabelRect.size.height+ 40 +20;
       
    }else
    
    return ContentlabelRect.size.height + 60+ 40 +20;

    

}
//indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KnowledgeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    KnowledgeData *model = _mainArray[indexPath.section];
    
    cell.label2 .tag  = 1002;
    cell.backview.tag  = 1003;
    
    //用户名
    cell.label1.text=  model.userName;

    //问题名字
    NSString *Qstr = @"Q：";
    cell.label2.text = [Qstr stringByAppendingString:model.content];
    
    //回复内容
    cell.label3.text = model.reply;
    
    //自定义问题名字的高度（根据内容）
     CGRect ContentlabelRect = [cell.label2.text boundingRectWithSize:CGSizeMake(cell.label2.frame.size.width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14.0f] forKey:NSFontAttributeName] context:nil];
   
    
    //根据内容自定义后需重新再设置问题名字的位置
    cell.label2.frame = CGRectMake(15,28, KScreenWidth-15, ContentlabelRect.size.height);
        if (model.isShow==YES) {
            //自定义回复内容的高度（根据内容）
            CGRect replylabelRect = [cell.label3.text boundingRectWithSize:CGSizeMake(cell.label3.frame.size.width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Helvetica" size:12] forKey:NSFontAttributeName] context:nil];

    cell.backview.frame = CGRectMake(0,CGRectGetMaxY(cell.label2.frame)+5, KScreenWidth, replylabelRect.size.height+25);//230
            
        cell.label3.frame = CGRectMake(40,5, KScreenWidth-60, replylabelRect.size.height);
    }else if (model.isShow==NO){
        cell.label3.frame = CGRectMake(40,5, KScreenWidth-60, 60);
        
       

           cell.backview.frame = CGRectMake(0,CGRectGetMaxY(cell.label2.frame)+5, KScreenWidth, 60+25);//230
        
    }

    
    
   
    
   //选中cell时背景色为无
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

   //设置cell的背景色为白色
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
} //创建单元格

#pragma  TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KnowledgeData *model = _mainArray[indexPath.section];
    model.isShow = !model.isShow;
    
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

}



#pragma mark - NavigationBack Delegate
-(void)backClick:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnAction:(id)sender{
    NSLog(@"点击我要提问");

    AskQuestionController *askquestion = [[AskQuestionController alloc]init];
    [self.navigationController pushViewController:askquestion animated:YES];
}



@end
