//
//  BindingData.h
//
//  Created by   on 14/12/27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BindingData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double userType;
@property (nonatomic, assign) id qQ;
@property (nonatomic, assign) id userInfoIp;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, assign) id passWord;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, assign) id remark;
@property (nonatomic, assign) id phone;
@property (nonatomic, strong) NSString *loginName;
@property (nonatomic, strong) NSString *addDate;
@property (nonatomic, assign) id regAppId;
@property (nonatomic, assign) BOOL isVisible;
@property (nonatomic, assign) id roleName;
@property (nonatomic, assign) id portraitURL;
@property (nonatomic, strong) NSString *roleId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
