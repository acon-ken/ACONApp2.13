//
//  SaveUserInfo.m
//  ACONApp
//
//  Created by fyf on 14/12/3.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "SaveUserInfo.h"

@implementation SaveUserInfo
#pragma mark 从NSUserDefaults把用户信息取出来
+(LoginInfoModel *)loadCustomObjectWithKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey:userinfokey];
    LoginInfoModel *obj = (LoginInfoModel *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    return obj;
}

#pragma mark 把登录信息写入NSUserDefaults
+(void)saveCustomObject:(LoginInfoModel *)mo
{
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:mo];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:myEncodedObject forKey:userinfokey];
    [defaults synchronize];
}


#pragma mark 删除本地信息写入NSUserDefaults
+(void)deleteCustomObject
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:userinfokey];
}

@end
