//
//  SearchUserController.h
//  ACONApp
//
//  Created by fyf on 14/12/1.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchUserController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,WebServiceDelegate>
{
    UITableView *mainTableView;
    NSArray *_dataDic;
    NSArray *_dataDic2;
    
}

/// 数据源数组
@property(nonatomic,retain) NSArray *dataDic;
@property(nonatomic,retain) NSArray *dataDic2;

/// 数据源数组
@property (nonatomic,retain)NSMutableArray *mainArray;
@property (nonatomic,retain)UITextField *UserSearchBar;

@property (nonatomic,strong) id searchUserTarget;

@property (nonatomic,assign) SEL  searchUserTargetClick;


@end
