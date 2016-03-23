//
//  SoapHelper.h
//  ACONApp
//
//  Created by fyf on 14/12/3.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoapHelper : NSObject
//默认soap信息
+(NSString*)defaultSoapMesage;
//生成soap信息
+(NSString*)methodSoapMessage:(NSString*)methodName;
+(NSString*)nameSpaceSoapMessage:(NSString*)space methodName:(NSString*)methodName;
//有参数soap生成
+(NSString*)arrayToDefaultSoapMessage:(NSArray*)arr methodName:(NSString*)methodName;
+(NSString*)arrayToNameSpaceSoapMessage:(NSString*)space params:(NSArray*)arr methodName:(NSString*)methodName;

@end
