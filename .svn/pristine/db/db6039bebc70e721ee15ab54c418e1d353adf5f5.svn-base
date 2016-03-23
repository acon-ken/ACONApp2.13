//
//  QQLoginData.m
//
//  Created by   on 15/1/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "QQLoginData.h"


#define kQQLoginDataUserType  @"UserType"
#define kQQLoginDataQQ  @"QQ"
#define kQQLoginDataUserInfoIp  @"UserInfoIp"
#define kQQLoginDataId  @"Id"
#define kQQLoginDataPassWord  @"PassWord"
#define kQQLoginDataUserName  @"UserName"
#define kQQLoginDataRemark  @"Remark"
#define kQQLoginDataPhone  @"Phone"
#define kQQLoginDataLoginName  @"LoginName"
#define kQQLoginDataAddDate  @"AddDate"
#define kQQLoginDataRegAppId  @"RegAppId"
#define kQQLoginDataIsVisible  @"IsVisible"
#define kQQLoginDataRoleName  @"RoleName"
#define kQQLoginDataPortraitURL  @"PortraitURL"
#define kQQLoginDataRoleId  @"RoleId"


@interface QQLoginData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QQLoginData

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
            self.userType = [[self objectOrNilForKey:kQQLoginDataUserType fromDictionary:dict] doubleValue];
            self.qQ = [self objectOrNilForKey:kQQLoginDataQQ fromDictionary:dict];
            self.userInfoIp = [self objectOrNilForKey:kQQLoginDataUserInfoIp fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kQQLoginDataId fromDictionary:dict];
            self.passWord = [self objectOrNilForKey:kQQLoginDataPassWord fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kQQLoginDataUserName fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kQQLoginDataRemark fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kQQLoginDataPhone fromDictionary:dict];
            self.loginName = [self objectOrNilForKey:kQQLoginDataLoginName fromDictionary:dict];
            self.addDate = [self objectOrNilForKey:kQQLoginDataAddDate fromDictionary:dict];
            self.regAppId = [self objectOrNilForKey:kQQLoginDataRegAppId fromDictionary:dict];
            self.isVisible = [[self objectOrNilForKey:kQQLoginDataIsVisible fromDictionary:dict] boolValue];
            self.roleName = [self objectOrNilForKey:kQQLoginDataRoleName fromDictionary:dict];
            self.portraitURL = [self objectOrNilForKey:kQQLoginDataPortraitURL fromDictionary:dict];
            self.roleId = [self objectOrNilForKey:kQQLoginDataRoleId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userType] forKey:kQQLoginDataUserType];
    [mutableDict setValue:self.qQ forKey:kQQLoginDataQQ];
    [mutableDict setValue:self.userInfoIp forKey:kQQLoginDataUserInfoIp];
    [mutableDict setValue:self.dataIdentifier forKey:kQQLoginDataId];
    [mutableDict setValue:self.passWord forKey:kQQLoginDataPassWord];
    [mutableDict setValue:self.userName forKey:kQQLoginDataUserName];
    [mutableDict setValue:self.remark forKey:kQQLoginDataRemark];
    [mutableDict setValue:self.phone forKey:kQQLoginDataPhone];
    [mutableDict setValue:self.loginName forKey:kQQLoginDataLoginName];
    [mutableDict setValue:self.addDate forKey:kQQLoginDataAddDate];
    [mutableDict setValue:self.regAppId forKey:kQQLoginDataRegAppId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isVisible] forKey:kQQLoginDataIsVisible];
    [mutableDict setValue:self.roleName forKey:kQQLoginDataRoleName];
    [mutableDict setValue:self.portraitURL forKey:kQQLoginDataPortraitURL];
    [mutableDict setValue:self.roleId forKey:kQQLoginDataRoleId];

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

    self.userType = [aDecoder decodeDoubleForKey:kQQLoginDataUserType];
    self.qQ = [aDecoder decodeObjectForKey:kQQLoginDataQQ];
    self.userInfoIp = [aDecoder decodeObjectForKey:kQQLoginDataUserInfoIp];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kQQLoginDataId];
    self.passWord = [aDecoder decodeObjectForKey:kQQLoginDataPassWord];
    self.userName = [aDecoder decodeObjectForKey:kQQLoginDataUserName];
    self.remark = [aDecoder decodeObjectForKey:kQQLoginDataRemark];
    self.phone = [aDecoder decodeObjectForKey:kQQLoginDataPhone];
    self.loginName = [aDecoder decodeObjectForKey:kQQLoginDataLoginName];
    self.addDate = [aDecoder decodeObjectForKey:kQQLoginDataAddDate];
    self.regAppId = [aDecoder decodeObjectForKey:kQQLoginDataRegAppId];
    self.isVisible = [aDecoder decodeBoolForKey:kQQLoginDataIsVisible];
    self.roleName = [aDecoder decodeObjectForKey:kQQLoginDataRoleName];
    self.portraitURL = [aDecoder decodeObjectForKey:kQQLoginDataPortraitURL];
    self.roleId = [aDecoder decodeObjectForKey:kQQLoginDataRoleId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_userType forKey:kQQLoginDataUserType];
    [aCoder encodeObject:_qQ forKey:kQQLoginDataQQ];
    [aCoder encodeObject:_userInfoIp forKey:kQQLoginDataUserInfoIp];
    [aCoder encodeObject:_dataIdentifier forKey:kQQLoginDataId];
    [aCoder encodeObject:_passWord forKey:kQQLoginDataPassWord];
    [aCoder encodeObject:_userName forKey:kQQLoginDataUserName];
    [aCoder encodeObject:_remark forKey:kQQLoginDataRemark];
    [aCoder encodeObject:_phone forKey:kQQLoginDataPhone];
    [aCoder encodeObject:_loginName forKey:kQQLoginDataLoginName];
    [aCoder encodeObject:_addDate forKey:kQQLoginDataAddDate];
    [aCoder encodeObject:_regAppId forKey:kQQLoginDataRegAppId];
    [aCoder encodeBool:_isVisible forKey:kQQLoginDataIsVisible];
    [aCoder encodeObject:_roleName forKey:kQQLoginDataRoleName];
    [aCoder encodeObject:_portraitURL forKey:kQQLoginDataPortraitURL];
    [aCoder encodeObject:_roleId forKey:kQQLoginDataRoleId];
}

- (id)copyWithZone:(NSZone *)zone
{
    QQLoginData *copy = [[QQLoginData alloc] init];
    
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
