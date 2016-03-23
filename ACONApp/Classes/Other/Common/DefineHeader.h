//
//  DefineHeader.h
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/11/25.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#ifndef ACONApp_DefineHeader_h
#define ACONApp_DefineHeader_h

//是否为iphone4
#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )

//是否为iphone5
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

//是否为iphone6
#define IS_IPHONE_6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )

//是否为iphone6Plus
#define IS_IPHONE_6PLUS ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )

//获取屏幕宽度
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
//获取屏幕高度
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

//导航栏 + 状态栏高度
#define KNavTopH 64

#define KBorderH 10

#define KBackgroundColor [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]
#define KCommonColor [UIColor colorWithRed:76/255.0 green:193/255.0 blue:210/255.0 alpha:1.0]

#define userinfokey @"userinfokey"
#define DEF_ACONUserID @"ACONUserID"//本地通知用户ID
#endif
