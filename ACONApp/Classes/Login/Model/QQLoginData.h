//
//  QQLoginData.h
//
//  Created by   on 15/1/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QQLoginData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double userType;
@property (nonatomic, copy) NSString *qQ;
@property (nonatomic, copy) NSString *userInfoIp;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, strong) NSString *loginName;
@property (nonatomic, strong) NSString *addDate;
@property (nonatomic, copy) NSString *regAppId;
@property (nonatomic, assign) BOOL isVisible;
@property (nonatomic, copy) NSString *roleName;
@property (nonatomic, copy) NSString *portraitURL;
@property (nonatomic, strong) NSString *roleId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
