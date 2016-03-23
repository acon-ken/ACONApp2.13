//
//  SaveUserInfo.h
//  ACONApp
//
//  Created by fyf on 14/12/3.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginInfoModel.h"
@interface SaveUserInfo : NSObject
{
    LoginInfoModel *usermodel;
}
+(LoginInfoModel *)loadCustomObjectWithKey;
+(void)saveCustomObject:(LoginInfoModel *)mo;
+(void)deleteCustomObject;

@end
