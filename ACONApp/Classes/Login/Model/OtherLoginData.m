//
//  OtherLoginData.m
//
//  Created by   on 14/12/27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "OtherLoginData.h"


#define kOtherLoginDataUserType  @"UserType"
#define kOtherLoginDataQQ  @"QQ"
#define kOtherLoginDataUserInfoIp  @"UserInfoIp"
#define kOtherLoginDataId  @"Id"
#define kOtherLoginDataPassWord  @"PassWord"
#define kOtherLoginDataUserName  @"UserName"
#define kOtherLoginDataRemark  @"Remark"
#define kOtherLoginDataPhone  @"Phone"
#define kOtherLoginDataLoginName  @"LoginName"
#define kOtherLoginDataAddDate  @"AddDate"
#define kOtherLoginDataRegAppId  @"RegAppId"
#define kOtherLoginDataIsVisible  @"IsVisible"
#define kOtherLoginDataRoleName  @"RoleName"
#define kOtherLoginDataPortraitURL  @"PortraitURL"
#define kOtherLoginDataRoleId  @"RoleId"


@interface OtherLoginData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OtherLoginData

@synthesize userType = _userType;
@synthesize qQ = _qQ;
@synthesize userInfoIp = _userInfoIp;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize passWord = _passWord;
@synthesize userName = _userName;
@synthesize remark = _remark;
@synthesize phone = _phone;
@synthesize loginName = _loginName;
@synthesize addDate = _addDate;
@synthesize regAppId = _regAppId;
@synthesize isVisible = _isVisible;
@synthesize roleName = _roleName;
@synthesize portraitURL = _portraitURL;
@synthesize roleId = _roleId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.userType = [[self objectOrNilForKey:kOtherLoginDataUserType fromDictionary:dict] doubleValue];
            self.qQ = [self objectOrNilForKey:kOtherLoginDataQQ fromDictionary:dict];
            self.userInfoIp = [self objectOrNilForKey:kOtherLoginDataUserInfoIp fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kOtherLoginDataId fromDictionary:dict];
            self.passWord = [self objectOrNilForKey:kOtherLoginDataPassWord fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kOtherLoginDataUserName fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kOtherLoginDataRemark fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kOtherLoginDataPhone fromDictionary:dict];
            self.loginName = [self objectOrNilForKey:kOtherLoginDataLoginName fromDictionary:dict];
            self.addDate = [self objectOrNilForKey:kOtherLoginDataAddDate fromDictionary:dict];
            self.regAppId = [self objectOrNilForKey:kOtherLoginDataRegAppId fromDictionary:dict];
            self.isVisible = [[self objectOrNilForKey:kOtherLoginDataIsVisible fromDictionary:dict] boolValue];
            self.roleName = [self objectOrNilForKey:kOtherLoginDataRoleName fromDictionary:dict];
            self.portraitURL = [self objectOrNilForKey:kOtherLoginDataPortraitURL fromDictionary:dict];
            self.roleId = [self objectOrNilForKey:kOtherLoginDataRoleId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userType] forKey:kOtherLoginDataUserType];
    [mutableDict setValue:self.qQ forKey:kOtherLoginDataQQ];
    [mutableDict setValue:self.userInfoIp forKey:kOtherLoginDataUserInfoIp];
    [mutableDict setValue:self.dataIdentifier forKey:kOtherLoginDataId];
    [mutableDict setValue:self.passWord forKey:kOtherLoginDataPassWord];
    [mutableDict setValue:self.userName forKey:kOtherLoginDataUserName];
    [mutableDict setValue:self.remark forKey:kOtherLoginDataRemark];
    [mutableDict setValue:self.phone forKey:kOtherLoginDataPhone];
    [mutableDict setValue:self.loginName forKey:kOtherLoginDataLoginName];
    [mutableDict setValue:self.addDate forKey:kOtherLoginDataAddDate];
    [mutableDict setValue:self.regAppId forKey:kOtherLoginDataRegAppId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isVisible] forKey:kOtherLoginDataIsVisible];
    [mutableDict setValue:self.roleName forKey:kOtherLoginDataRoleName];
    [mutableDict setValue:self.portraitURL forKey:kOtherLoginDataPortraitURL];
    [mutableDict setValue:self.roleId forKey:kOtherLoginDataRoleId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.userType = [aDecoder decodeDoubleForKey:kOtherLoginDataUserType];
    self.qQ = [aDecoder decodeObjectForKey:kOtherLoginDataQQ];
    self.userInfoIp = [aDecoder decodeObjectForKey:kOtherLoginDataUserInfoIp];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kOtherLoginDataId];
    self.passWord = [aDecoder decodeObjectForKey:kOtherLoginDataPassWord];
    self.userName = [aDecoder decodeObjectForKey:kOtherLoginDataUserName];
    self.remark = [aDecoder decodeObjectForKey:kOtherLoginDataRemark];
    self.phone = [aDecoder decodeObjectForKey:kOtherLoginDataPhone];
    self.loginName = [aDecoder decodeObjectForKey:kOtherLoginDataLoginName];
    self.addDate = [aDecoder decodeObjectForKey:kOtherLoginDataAddDate];
    self.regAppId = [aDecoder decodeObjectForKey:kOtherLoginDataRegAppId];
    self.isVisible = [aDecoder decodeBoolForKey:kOtherLoginDataIsVisible];
    self.roleName = [aDecoder decodeObjectForKey:kOtherLoginDataRoleName];
    self.portraitURL = [aDecoder decodeObjectForKey:kOtherLoginDataPortraitURL];
    self.roleId = [aDecoder decodeObjectForKey:kOtherLoginDataRoleId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_userType forKey:kOtherLoginDataUserType];
    [aCoder encodeObject:_qQ forKey:kOtherLoginDataQQ];
    [aCoder encodeObject:_userInfoIp forKey:kOtherLoginDataUserInfoIp];
    [aCoder encodeObject:_dataIdentifier forKey:kOtherLoginDataId];
    [aCoder encodeObject:_passWord forKey:kOtherLoginDataPassWord];
    [aCoder encodeObject:_userName forKey:kOtherLoginDataUserName];
    [aCoder encodeObject:_remark forKey:kOtherLoginDataRemark];
    [aCoder encodeObject:_phone forKey:kOtherLoginDataPhone];
    [aCoder encodeObject:_loginName forKey:kOtherLoginDataLoginName];
    [aCoder encodeObject:_addDate forKey:kOtherLoginDataAddDate];
    [aCoder encodeObject:_regAppId forKey:kOtherLoginDataRegAppId];
    [aCoder encodeBool:_isVisible forKey:kOtherLoginDataIsVisible];
    [aCoder encodeObject:_roleName forKey:kOtherLoginDataRoleName];
    [aCoder encodeObject:_portraitURL forKey:kOtherLoginDataPortraitURL];
    [aCoder encodeObject:_roleId forKey:kOtherLoginDataRoleId];
}

- (id)copyWithZone:(NSZone *)zone
{
    OtherLoginData *copy = [[OtherLoginData alloc] init];
    
    if (copy) {

        copy.userType = self.userType;
        copy.qQ = [self.qQ copyWithZone:zone];
        copy.userInfoIp = [self.userInfoIp copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.passWord = [self.passWord copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.remark = [self.remark copyWithZone:zone];
        copy.phone = [self.phone copyWithZone:zone];
        copy.loginName = [self.loginName copyWithZone:zone];
        copy.addDate = [self.addDate copyWithZone:zone];
        copy.regAppId = [self.regAppId copyWithZone:zone];
        copy.isVisible = self.isVisible;
        copy.roleName = [self.roleName copyWithZone:zone];
        copy.portraitURL = [self.portraitURL copyWithZone:zone];
        copy.roleId = [self.roleId copyWithZone:zone];
    }
    
    return copy;
}


@end
