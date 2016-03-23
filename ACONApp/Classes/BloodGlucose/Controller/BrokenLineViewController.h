//
//  BrokenLineViewController.h
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/12/14.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
//** 偏高*/
#define k_Statue_ku_image @"ku"
//** 正常*/
#define k_Statue_lv_image @"lv"
//** 偏低*/
#define k_Statue_qi_image @"qi"

//** 偏高*/
#define k_Statue_high_image @"xiangshang"
//** 正常*/
#define k_Statue_nomal_image @"heng"
//** 偏低*/
#define k_Statue_low_image @"xiangxia_zw"
@interface BrokenLineViewController : UIViewController<WebServiceDelegate>

@property (nonatomic,assign) BOOL isme;

 @property (nonatomic,retain)NSString *timerString;//选择时间段后通知回来的数据
@property (nonatomic,retain)NSString *timerstr; //自定义选择的时间值（要传给饼状图的）

@property (nonatomic,assign) NSString *secondSwitchStatus; //选择天数控件的状态

@property (nonatomic,copy)NSString *currenttimerstr;// 用来暂时存放自定义时间的字符串
@end
