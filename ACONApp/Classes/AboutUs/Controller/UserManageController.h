//
//  UserManageController.h
//  ACONApp
//
//  Created by fyf on 14/12/1.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserManageController : UIViewController<UITableViewDataSource,UITableViewDelegate,WebServiceDelegate>
{
    UITableView *_tableview;
    NSArray *_dataDic;
    NSArray *_dataDic2;
    
}
@property(nonatomic,retain) NSArray *dataDic;
@property(nonatomic,retain) NSArray *dataDic2;
/// 数据源数组
@property (nonatomic,retain)NSMutableArray *mainArray;

@end
