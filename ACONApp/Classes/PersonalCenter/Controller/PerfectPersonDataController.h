//
//  PerfectPersonDataController.h
//  ACONApp
//
//  Created by fyf on 14/12/4.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerfectDropDown.h"
#import "PerfectDropDown2.h"

@interface PerfectPersonDataController : UIViewController<UIScrollViewDelegate, UIGestureRecognizerDelegate,WebServiceDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,PerfectDropDownDelegate,PerfectDropDownDelegate2>
{
  PerfectDropDown *dropDown;
    PerfectDropDown2 *dropDown2;
    WebServices *helper;
    
    NSString *_userLoginname;
    NSString *_username;
    NSString *_usersex;
    NSString *_useBloodTypestr;
    NSString *_userPhonestr;
    NSString *_userheightstr;
    NSString *_userweightstr;
    NSString *_userbirthdaystr;
    
}
@property (nonatomic,retain)UIDatePicker *datePicker4;

@property (nonatomic,retain)NSString *userLoginname;

@property (nonatomic,retain)NSString *username;

@property (nonatomic,retain)NSString *usersex;

@property (nonatomic,retain)NSString *useBloodTypestr;

@property (nonatomic,retain)NSString *userPhonestr;

@property (nonatomic,retain)NSString *userheightstr;

@property (nonatomic,retain)NSString *userweightstr;

@property (nonatomic,retain)NSString *userbirthdaystr;



+(id)shareIndence;
@end
@interface myPicker4 : UIPickerView

-(void)rel;

@end
