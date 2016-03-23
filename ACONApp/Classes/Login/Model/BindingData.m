//
//  BindingData.m
//
//  Created by   on 14/12/27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "BindingData.h"


#define kBindingDataUserType  @"UserType"
#define kBindingDataQQ  @"QQ"
#define kBindingDataUserInfoIp  @"UserInfoIp"
#define kBindingDataId  @"Id"
#define kBindingDataPassWord  @"PassWord"
#define kBindingDataUserName  @"UserName"
#define kBindingDataRemark  @"Remark"
#define kBindingDataPhone  @"Phone"
#define kBindingDataLoginName  @"LoginName"
#define kBindingDataAddDate  @"AddDate"
#define kBindingDataRegAppId  @"RegAppId"
#define kBindingDataIsVisible  @"IsVisible"
#define kBindingDataRoleName  @"RoleName"
#define kBindingDataPortraitURL  @"PortraitURL"
#define kBindingDataRoleId  @"RoleId"


@interface BindingData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BindingData

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
            self.userType = [[self objectOrNilForKey:kBindingDataUserType fromDictionary:dict] doubleValue];
            self.qQ = [self objectOrNilForKey:kBindingDataQQ fromDictionary:dict];
            self.userInfoIp = [self objectOrNilForKey:kBindingDataUserInfoIp fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kBindingDataId fromDictionary:dict];
            self.passWord = [self objectOrNilForKey:kBindingDataPassWord fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kBindingDataUserName fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kBindingDataRemark fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kBindingDataPhone fromDictionary:dict];
            self.loginName = [self objectOrNilForKey:kBindingDataLoginName fromDictionary:dict];
            self.addDate = [self objectOrNilForKey:kBindingDataAddDate fromDictionary:dict];
            self.regAppId = [self objectOrNilForKey:kBindingDataRegAppId fromDictionary:dict];
            self.isVisible = [[self objectOrNilForKey:kBindingDataIsVisible fromDictionary:dict] boolValue];
            self.roleName = [self objectOrNilForKey:kBindingDataRoleName fromDictionary:dict];
            self.portraitURL = [self objectOrNilForKey:kBindingDataPortraitURL fromDictionary:dict];
            self.roleId = [self objectOrNilForKey:kBindingDataRoleId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userType] forKey:kBindingDataUserType];
    [mutableDict setValue:self.qQ forKey:kBindingDataQQ];
    [mutableDict setValue:self.userInfoIp forKey:kBindingDataUserInfoIp];
    [mutableDict setValue:self.dataIdentifier forKey:kBindingDataId];
    [mutableDict setValue:self.passWord forKey:kBindingDataPassWord];
    [mutableDict setValue:self.userName forKey:kBindingDataUserName];
    [mutableDict setValue:self.remark forKey:kBindingDataRemark];
    [mutableDict setValue:self.phone forKey:kBindingDataPhone];
    [mutableDict setValue:self.loginName forKey:kBindingDataLoginName];
    [mutableDict setValue:self.addDate forKey:kBindingDataAddDate];
    [mutableDict setValue:self.regAppId forKey:kBindingDataRegAppId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isVisible] forKey:kBindingDataIsVisible];
    [mutableDict setValue:self.roleName forKey:kBindingDataRoleName];
    [mutableDict setValue:self.portraitURL forKey:kBindingDataPortraitURL];
    [mutableDict setValue:self.roleId forKey:kBindingDataRoleId];

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

    self.userType = [aDecoder decodeDoubleForKey:kBindingDataUserType];
    self.qQ = [aDecoder decodeObjectForKey:kBindingDataQQ];
    self.userInfoIp = [aDecoder decodeObjectForKey:kBindingDataUserInfoIp];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kBindingDataId];
    self.passWord = [aDecoder decodeObjectForKey:kBindingDataPassWord];
    self.userName = [aDecoder decodeObjectForKey:kBindingDataUserName];
    self.remark = [aDecoder decodeObjectForKey:kBindingDataRemark];
    self.phone = [aDecoder decodeObjectForKey:kBindingDataPhone];
    self.loginName = [aDecoder decodeObjectForKey:kBindingDataLoginName];
    self.addDate = [aDecoder decodeObjectForKey:kBindingDataAddDate];
    self.regAppId = [aDecoder decodeObjectForKey:kBindingDataRegAppId];
    self.isVisible = [aDecoder decodeBoolForKey:kBindingDataIsVisible];
    self.roleName = [aDecoder decodeObjectForKey:kBindingDataRoleName];
    self.portraitURL = [aDecoder decodeObjectForKey:kBindingDataPortraitURL];
    self.roleId = [aDecoder decodeObjectForKey:kBindingDataRoleId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_userType forKey:kBindingDataUserType];
    [aCoder encodeObject:_qQ forKey:kBindingDataQQ];
    [aCoder encodeObject:_userInfoIp forKey:kBindingDataUserInfoIp];
    [aCoder encodeObject:_dataIdentifier forKey:kBindingDataId];
    [aCoder encodeObject:_passWord forKey:kBindingDataPassWord];
    [aCoder encodeObject:_userName forKey:kBindingDataUserName];
    [aCoder encodeObject:_remark forKey:kBindingDataRemark];
    [aCoder encodeObject:_phone forKey:kBindingDataPhone];
    [aCoder encodeObject:_loginName forKey:kBindingDataLoginName];
    [aCoder encodeObject:_addDate forKey:kBindingDataAddDate];
    [aCoder encodeObject:_regAppId forKey:kBindingDataRegAppId];
    [aCoder encodeBool:_isVisible forKey:kBindingDataIsVisible];
    [aCoder encodeObject:_roleName forKey:kBindingDataRoleName];
    [aCoder encodeObject:_portraitURL forKey:kBindingDataPortraitURL];
    [aCoder encodeObject:_roleId forKey:kBindingDataRoleId];
}

- (id)copyWithZone:(NSZone *)zone
{
    BindingData *copy = [[BindingData alloc] init];
    
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
