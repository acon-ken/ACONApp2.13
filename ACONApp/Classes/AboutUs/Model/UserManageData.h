//
//  UserManageData.h
//
//  Created by   on 14/12/9
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserManageData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) id qQ;
@property (nonatomic, assign) id passWord;
@property (nonatomic, strong) NSString *bloodType;
@property (nonatomic, assign) BOOL isVisible;
@property (nonatomic, strong) NSString *addDate;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, assign) BOOL isAllowFllow;
@property (nonatomic, assign) double sex;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, assign) id portraitURL;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, assign) id loginNameGrap;
@property (nonatomic, strong) NSString *loginName;
@property (nonatomic, assign) id weiBoNo;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) id remark;
@property (nonatomic, assign) id regPushId;
@property (nonatomic, assign) BOOL isDeleted;
@property (nonatomic, strong) NSString *weight;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
