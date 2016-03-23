//
//  SearchUserController.m
//  ACONApp
//
//  Created by fyf on 14/12/1.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "SearchUserController.h"
#import "UsermanageCell.h"
#import "SearchErweimaViewController.h"
#import "SearchUserModel.h"
#import "SearchUserData.h"

#import "LoginInfoModel.h"
#import "LoginInfoData.h"

@interface SearchUserController ()
{
//    UIButton *anxinBtn ;
    
    NSString *Usernamestr;
    NSString *regPushIdstr;
    NSString *receivePhonestr;
    int state;
}
@end

@implementation SearchUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KBackgroundColor;
    self.title = @"搜索用户";
    self.edgesForExtendedLayout = NO;
        
    state = 1; //没输入状态走接口，_mainArray有值但不再表示图上显示
    //[self postSearchUser];
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    
    //给导航栏加右侧按钮
    UIButton *erweimaBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [erweimaBtn setImage:[UIImage imageNamed:@"erweima"] forState:UIControlStateNormal];
    [erweimaBtn setImage:[UIImage imageNamed:@"erweima"] forState:UIControlStateSelected];
    [erweimaBtn  addTarget:self action:@selector(erweimaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    erweimaBtn.selected = YES;
    
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
    UIBarButtonItem *righButtonitemt  = [[UIBarButtonItem alloc] initWithCustomView:erweimaBtn];
    self.navigationItem.rightBarButtonItem=righButtonitemt;
    
    // [self postSearchUser];
    
    [self CreatHeadView];
    [self postSearchUser];
    [self CreateTableView];
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];

//    [self postSearchUser];
    
}

-(void)CreatHeadView{
//    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 80)];
//    headview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"baise"]];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"fangdajing"] forState:UIControlStateNormal];
     [searchBtn addTarget:self action:@selector(postSearchUser) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.frame = CGRectMake(5, 10, 18, 18);
    
    //搜索框View
    UIView *SearchView = [[UIView alloc]initWithFrame:CGRectMake(5, 23,KScreenWidth-10, 40)];
    SearchView.userInteractionEnabled = YES;
    
    //搜索框背景色
    UIImageView *SearchBackground = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, SearchView.frame.size.width,SearchView.frame.size.height)];
    SearchBackground.highlighted = YES;// flag
    SearchBackground.image = [UIImage imageNamed:@"sousuo"];
    
    //    // 设置 搜索框
    _UserSearchBar = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(searchBtn.frame)+5, 0, SearchView.frame.size.width-25, SearchView.frame.size.height)];
    _UserSearchBar.backgroundColor = [UIColor clearColor];
    _UserSearchBar.borderStyle=UITextBorderStyleNone;
    //设置全部清除按钮，永远显示
    _UserSearchBar.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    _UserSearchBar.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _UserSearchBar.placeholder=@"请根据用户名、姓名、电话号码搜索";
    _UserSearchBar.delegate=self;
    _UserSearchBar.leftViewMode = UITextFieldViewModeAlways;
    _UserSearchBar.clearsOnBeginEditing=YES;
    _UserSearchBar.returnKeyType=UIReturnKeyDone;
    [_UserSearchBar addTarget:self action:@selector(textFieldValueChanged:)  forControlEvents:UIControlEventEditingChanged];
    
    [SearchView addSubview:SearchBackground];
    [SearchView addSubview:searchBtn];
    [SearchView addSubview:_UserSearchBar];

    [self.view addSubview:SearchView];
}

-(void)CreateTableView{    
    
    mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 80, KScreenWidth, KScreenHeight-80-64) style:UITableViewStyleGrouped];
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
    
    return [_mainArray count];
} //section 中包含row的数量


//indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UsermanageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    SearchUserData *model = _mainArray[indexPath.row];
    NSString *portimaegstr = model.portraitURL;
    
    cell.label1.text = model.loginName;
    cell.label2.text =model.phone;
    cell.rightimage.image = [UIImage imageNamed:@"aixin"];
   
    
    
    [cell.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.rightBtn.selected = YES;
    cell.rightBtn.tag=indexPath.row+10;
    
    
  [cell.leftimage sd_setImageWithURL:[NSURL URLWithString:portimaegstr] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor=[UIColor darkTextColor];
    cell.backgroundColor=[UIColor clearColor];
    
    
    
    
    return cell;
} //创建单元格



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
    
#warning    检索信息 
    
    
    SearchErweimaViewController *erweima = [[SearchErweimaViewController alloc]init];
    //erweima.mainSearchArray = _mainArray;
    [self.navigationController pushViewController:erweima animated:YES];
}


#pragma mark -
#pragma mark - 搜索框代理
-(void)textFieldValueChanged:(id)sender{
    
  
    state = 2; //输入状态走接口，_mainArray有值，同时表示图显示数据
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;{ //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    if ([string isEqualToString:@"\n"]) //按会车可以改变
    {
        return YES;
    
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (_UserSearchBar == textField) //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11) { //如果输入框内容大于20则弹出警告
            textField.text = [toBeString substringToIndex:11];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入11位手机号或昵称" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
            [alert show];
            return NO;
        }
    } return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField*)theTextField {
    [theTextField resignFirstResponder];
    if ([_UserSearchBar.text isEqualToString:@""]) {
        return YES;
    }
     [self postSearchUser];
       return YES;
}
//textField的文本内容发生变化时，处理事件函数

//搜素用户
-(void)postSearchUser{
    
    [AppHelper showHUD:@"加载中..."];//显示动画
    WebServices *service = [[WebServices alloc] init];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:_UserSearchBar.text,@"inputStr", nil]];

    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:SearchAllowUserInfoMethodName];
    
    [service asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:SearchAllowUserInfoMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [AppHelper removeHUD];//移除动画
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            SearchUserModel *info = [[SearchUserModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                if (([_UserSearchBar.text isEqualToString:@""])&&(info.data.count>0)) {
                    _mainArray = [NSMutableArray arrayWithArray:info.data];
                }
                if ((![_UserSearchBar.text isEqualToString:@""])&&(info.data.count>0)) {
                    _mainArray = [NSMutableArray arrayWithArray:info.data];
                    [mainTableView reloadData];
                }
                else if(([_UserSearchBar.text isEqualToString:@""])&&(state==2)){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入要搜索的用户" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alertView show];
                }
                
                else if((![_UserSearchBar.text isEqualToString:@""])&&(info.data.count==0)){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"没有此用户" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alertView show];
                }
                
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


-(void)rightBtnAction:(UIButton *)sender{

    NSLog(@"点击爱心按钮");

    
    SearchUserData *model = _mainArray[sender.tag-10];
    Usernamestr =  model.dataIdentifier;
    regPushIdstr = model.regPushId;
    receivePhonestr = model.phone;

    [self postAddUser];
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
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:Usernamestr,@"receiveUserId", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:regPushIdstr,@"receivePushId", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:receivePhonestr,@"receivePhone", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:msgstr,@"msgContent", nil]];

    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:ReceiveUserRequestMethodName];
    
    [service asyncServiceUrl:GetUserInfoFollowWithWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:ReceiveUserRequestMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [AppHelper removeHUD];//移除动画

        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            UserModel *info = [[UserModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
                //            _mainArray = [NSMutableArray arrayWithArray:info.data];
                //            [mainTableView reloadData];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:info.msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
                
                
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}


@end
