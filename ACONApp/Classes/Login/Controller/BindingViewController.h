//
//  BindingViewController.h
//  ACONApp
//
//  Created by fyf on 14/12/27.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BindingViewController : UIViewController<UITextFieldDelegate,WebServiceDelegate>
{
    WebServices *helper;
    
    //是否为第三方新浪登录进来的
    NSString *_ThirdLoginStation;

    NSString *_ThirdLoginUidstr;
}

@property(nonatomic,retain) NSString *ThirdLoginStation;
@property(nonatomic,retain) NSString *ThirdLoginUidstr;
@property(nonatomic,copy) NSString *userid;
@end
