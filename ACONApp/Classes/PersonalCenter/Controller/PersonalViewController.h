//
//  PersonalViewController.h
//  ACONApp
//
//  Created by suhe on 14/11/25.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalViewController : UIViewController<WebServiceDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
{
    WebServices *helper;
    UITableView *_tableview;
    NSArray *_dataDic;
    NSArray *_dataDic2;
}
@property(nonatomic,retain) NSArray *dataDic;
@property(nonatomic,retain) NSArray *dataDic2;




@end
