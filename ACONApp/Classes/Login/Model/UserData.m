//
//  UserData.m
//
//  Created by   on 14/12/3
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "UserData.h"


#define kUserDataUserType  @"UserType"
#define kUserDataQQ  @"QQ"
#define kUserDataUserInfoIp  @"UserInfoIp"
#define kUserDataId  @"Id"
#define kUserDataPassWord  @"PassWord"
#define kUserDataUserName  @"UserName"
#define kUserDataRemark  @"Remark"
#define kUserDataPhone  @"Phone"
#define kUserDataLoginName  @"LoginName"
#define kUserDataAddDate  @"AddDate"
#define kUserDataRegAppId  @"RegAppId"
#define kUserDataIsVisible  @"IsVisible"
#define kUserDataRoleName  @"RoleName"
#define kUserDataRoleId  @"RoleId"


@interface UserData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserData

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
            self.userType = [[self objectOrNilForKey:kUserDataUserType fromDictionary:dict] doubleValue];
            self.qQ = [self objectOrNilForKey:kUserDataQQ fromDictionary:dict];
            self.userInfoIp = [self objectOrNilForKey:kUserDataUserInfoIp fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kUserDataId fromDictionary:dict];
            self.passWord = [self objectOrNilForKey:kUserDataPassWord fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kUserDataUserName fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kUserDataRemark fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kUserDataPhone fromDictionary:dict];
            self.loginName = [self objectOrNilForKey:kUserDataLoginName fromDictionary:dict];
            self.addDate = [self objectOrNilForKey:kUserDataAddDate fromDictionary:dict];
            self.regAppId = [self objectOrNilForKey:kUserDataRegAppId fromDictionary:dict];
            self.isVisible = [[self objectOrNilForKey:kUserDataIsVisible fromDictionary:dict] boolValue];
            self.roleName = [self objectOrNilForKey:kUserDataRoleName fromDictionary:dict];
            self.roleId = [self objectOrNilForKey:kUserDataRoleId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userType] forKey:kUserDataUserType];
    [mutableDict setValue:self.qQ forKey:kUserDataQQ];
    [mutableDict setValue:self.userInfoIp forKey:kUserDataUserInfoIp];
    [mutableDict setValue:self.dataIdentifier forKey:kUserDataId];
    [mutableDict setValue:self.passWord forKey:kUserDataPassWord];
    [mutableDict setValue:self.userName forKey:kUserDataUserName];
    [mutableDict setValue:self.remark forKey:kUserDataRemark];
    [mutableDict setValue:self.phone forKey:kUserDataPhone];
    [mutableDict setValue:self.loginName forKey:kUserDataLoginName];
    [mutableDict setValue:self.addDate forKey:kUserDataAddDate];
    [mutableDict setValue:self.regAppId forKey:kUserDataRegAppId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isVisible] forKey:kUserDataIsVisible];
    [mutableDict setValue:self.roleName forKey:kUserDataRoleName];
    [mutableDict setValue:self.roleId forKey:kUserDataRoleId];

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

    self.userType = [aDecoder decodeDoubleForKey:kUserDataUserType];
    self.qQ = [aDecoder decodeObjectForKey:kUserDataQQ];
    self.userInfoIp = [aDecoder decodeObjectForKey:kUserDataUserInfoIp];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kUserDataId];
    self.passWord = [aDecoder decodeObjectForKey:kUserDataPassWord];
    self.userName = [aDecoder decodeObjectForKey:kUserDataUserName];
    self.remark = [aDecoder decodeObjectForKey:kUserDataRemark];
    self.phone = [aDecoder decodeObjectForKey:kUserDataPhone];
    self.loginName = [aDecoder decodeObjectForKey:kUserDataLoginName];
    self.addDate = [aDecoder decodeObjectForKey:kUserDataAddDate];
    self.regAppId = [aDecoder decodeObjectForKey:kUserDataRegAppId];
    self.isVisible = [aDecoder decodeBoolForKey:kUserDataIsVisible];
    self.roleName = [aDecoder decodeObjectForKey:kUserDataRoleName];
    self.roleId = [aDecoder decodeObjectForKey:kUserDataRoleId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_userType forKey:kUserDataUserType];
    [aCoder encodeObject:_qQ forKey:kUserDataQQ];
    [aCoder encodeObject:_userInfoIp forKey:kUserDataUserInfoIp];
    [aCoder encodeObject:_dataIdentifier forKey:kUserDataId];
    [aCoder encodeObject:_passWord forKey:kUserDataPassWord];
    [aCoder encodeObject:_userName forKey:kUserDataUserName];
    [aCoder encodeObject:_remark forKey:kUserDataRemark];
    [aCoder encodeObject:_phone forKey:kUserDataPhone];
    [aCoder encodeObject:_loginName forKey:kUserDataLoginName];
    [aCoder encodeObject:_addDate forKey:kUserDataAddDate];
    [aCoder encodeObject:_regAppId forKey:kUserDataRegAppId];
    [aCoder encodeBool:_isVisible forKey:kUserDataIsVisible];
    [aCoder encodeObject:_roleName forKey:kUserDataRoleName];
    [aCoder encodeObject:_roleId forKey:kUserDataRoleId];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserData *copy = [[UserData alloc] init];
    
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
        copy.roleId = [self.roleId copyWithZone:zone];
    }
    
    return copy;
}


@end
