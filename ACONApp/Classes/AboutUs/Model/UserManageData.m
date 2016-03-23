//
//  UserManageData.m
//
//  Created by   on 14/12/9
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "UserManageData.h"


#define kUserManageDataQQ  @"QQ"
#define kUserManageDataPassWord  @"PassWord"
#define kUserManageDataBloodType  @"BloodType"
#define kUserManageDataIsVisible  @"IsVisible"
#define kUserManageDataAddDate  @"AddDate"
#define kUserManageDataUserName  @"UserName"
#define kUserManageDataIsAllowFllow  @"IsAllowFllow"
#define kUserManageDataSex  @"Sex"
#define kUserManageDataBirthday  @"Birthday"
#define kUserManageDataPortraitURL  @"PortraitURL"
#define kUserManageDataHeight  @"Height"
#define kUserManageDataLoginNameGrap  @"LoginNameGrap"
#define kUserManageDataLoginName  @"LoginName"
#define kUserManageDataWeiBoNo  @"WeiBoNo"
#define kUserManageDataId  @"Id"
#define kUserManageDataPhone  @"Phone"
#define kUserManageDataRemark  @"Remark"
#define kUserManageDataRegPushId  @"RegPushId"
#define kUserManageDataIsDeleted  @"IsDeleted"
#define kUserManageDataWeight  @"Weight"


@interface UserManageData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserManageData

@synthesize qQ = _qQ;
@synthesize passWord = _passWord;
@synthesize bloodType = _bloodType;
@synthesize isVisible = _isVisible;
@synthesize addDate = _addDate;
@synthesize userName = _userName;
@synthesize isAllowFllow = _isAllowFllow;
@synthesize sex = _sex;
@synthesize birthday = _birthday;
@synthesize portraitURL = _portraitURL;
@synthesize height = _height;
@synthesize loginNameGrap = _loginNameGrap;
@synthesize loginName = _loginName;
@synthesize weiBoNo = _weiBoNo;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize phone = _phone;
@synthesize remark = _remark;
@synthesize regPushId = _regPushId;
@synthesize isDeleted = _isDeleted;
@synthesize weight = _weight;


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
            self.qQ = [self objectOrNilForKey:kUserManageDataQQ fromDictionary:dict];
            self.passWord = [self objectOrNilForKey:kUserManageDataPassWord fromDictionary:dict];
            self.bloodType = [self objectOrNilForKey:kUserManageDataBloodType fromDictionary:dict];
            self.isVisible = [[self objectOrNilForKey:kUserManageDataIsVisible fromDictionary:dict] boolValue];
            self.addDate = [self objectOrNilForKey:kUserManageDataAddDate fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kUserManageDataUserName fromDictionary:dict];
            self.isAllowFllow = [[self objectOrNilForKey:kUserManageDataIsAllowFllow fromDictionary:dict] boolValue];
            self.sex = [[self objectOrNilForKey:kUserManageDataSex fromDictionary:dict] doubleValue];
            self.birthday = [self objectOrNilForKey:kUserManageDataBirthday fromDictionary:dict];
            self.portraitURL = [self objectOrNilForKey:kUserManageDataPortraitURL fromDictionary:dict];
            self.height = [self objectOrNilForKey:kUserManageDataHeight fromDictionary:dict];
            self.loginNameGrap = [self objectOrNilForKey:kUserManageDataLoginNameGrap fromDictionary:dict];
            self.loginName = [self objectOrNilForKey:kUserManageDataLoginName fromDictionary:dict];
            self.weiBoNo = [self objectOrNilForKey:kUserManageDataWeiBoNo fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kUserManageDataId fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kUserManageDataPhone fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kUserManageDataRemark fromDictionary:dict];
            self.regPushId = [self objectOrNilForKey:kUserManageDataRegPushId fromDictionary:dict];
            self.isDeleted = [[self objectOrNilForKey:kUserManageDataIsDeleted fromDictionary:dict] boolValue];
            self.weight = [self objectOrNilForKey:kUserManageDataWeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.qQ forKey:kUserManageDataQQ];
    [mutableDict setValue:self.passWord forKey:kUserManageDataPassWord];
    [mutableDict setValue:self.bloodType forKey:kUserManageDataBloodType];
    [mutableDict setValue:[NSNumber numberWithBool:self.isVisible] forKey:kUserManageDataIsVisible];
    [mutableDict setValue:self.addDate forKey:kUserManageDataAddDate];
    [mutableDict setValue:self.userName forKey:kUserManageDataUserName];
    [mutableDict setValue:[NSNumber numberWithBool:self.isAllowFllow] forKey:kUserManageDataIsAllowFllow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sex] forKey:kUserManageDataSex];
    [mutableDict setValue:self.birthday forKey:kUserManageDataBirthday];
    [mutableDict setValue:self.portraitURL forKey:kUserManageDataPortraitURL];
    [mutableDict setValue:self.height forKey:kUserManageDataHeight];
    [mutableDict setValue:self.loginNameGrap forKey:kUserManageDataLoginNameGrap];
    [mutableDict setValue:self.loginName forKey:kUserManageDataLoginName];
    [mutableDict setValue:self.weiBoNo forKey:kUserManageDataWeiBoNo];
    [mutableDict setValue:self.dataIdentifier forKey:kUserManageDataId];
    [mutableDict setValue:self.phone forKey:kUserManageDataPhone];
    [mutableDict setValue:self.remark forKey:kUserManageDataRemark];
    [mutableDict setValue:self.regPushId forKey:kUserManageDataRegPushId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDeleted] forKey:kUserManageDataIsDeleted];
    [mutableDict setValue:self.weight forKey:kUserManageDataWeight];

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

    self.qQ = [aDecoder decodeObjectForKey:kUserManageDataQQ];
    self.passWord = [aDecoder decodeObjectForKey:kUserManageDataPassWord];
    self.bloodType = [aDecoder decodeObjectForKey:kUserManageDataBloodType];
    self.isVisible = [aDecoder decodeBoolForKey:kUserManageDataIsVisible];
    self.addDate = [aDecoder decodeObjectForKey:kUserManageDataAddDate];
    self.userName = [aDecoder decodeObjectForKey:kUserManageDataUserName];
    self.isAllowFllow = [aDecoder decodeBoolForKey:kUserManageDataIsAllowFllow];
    self.sex = [aDecoder decodeDoubleForKey:kUserManageDataSex];
    self.birthday = [aDecoder decodeObjectForKey:kUserManageDataBirthday];
    self.portraitURL = [aDecoder decodeObjectForKey:kUserManageDataPortraitURL];
    self.height = [aDecoder decodeObjectForKey:kUserManageDataHeight];
    self.loginNameGrap = [aDecoder decodeObjectForKey:kUserManageDataLoginNameGrap];
    self.loginName = [aDecoder decodeObjectForKey:kUserManageDataLoginName];
    self.weiBoNo = [aDecoder decodeObjectForKey:kUserManageDataWeiBoNo];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kUserManageDataId];
    self.phone = [aDecoder decodeObjectForKey:kUserManageDataPhone];
    self.remark = [aDecoder decodeObjectForKey:kUserManageDataRemark];
    self.regPushId = [aDecoder decodeObjectForKey:kUserManageDataRegPushId];
    self.isDeleted = [aDecoder decodeBoolForKey:kUserManageDataIsDeleted];
    self.weight = [aDecoder decodeObjectForKey:kUserManageDataWeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_qQ forKey:kUserManageDataQQ];
    [aCoder encodeObject:_passWord forKey:kUserManageDataPassWord];
    [aCoder encodeObject:_bloodType forKey:kUserManageDataBloodType];
    [aCoder encodeBool:_isVisible forKey:kUserManageDataIsVisible];
    [aCoder encodeObject:_addDate forKey:kUserManageDataAddDate];
    [aCoder encodeObject:_userName forKey:kUserManageDataUserName];
    [aCoder encodeBool:_isAllowFllow forKey:kUserManageDataIsAllowFllow];
    [aCoder encodeDouble:_sex forKey:kUserManageDataSex];
    [aCoder encodeObject:_birthday forKey:kUserManageDataBirthday];
    [aCoder encodeObject:_portraitURL forKey:kUserManageDataPortraitURL];
    [aCoder encodeObject:_height forKey:kUserManageDataHeight];
    [aCoder encodeObject:_loginNameGrap forKey:kUserManageDataLoginNameGrap];
    [aCoder encodeObject:_loginName forKey:kUserManageDataLoginName];
    [aCoder encodeObject:_weiBoNo forKey:kUserManageDataWeiBoNo];
    [aCoder encodeObject:_dataIdentifier forKey:kUserManageDataId];
    [aCoder encodeObject:_phone forKey:kUserManageDataPhone];
    [aCoder encodeObject:_remark forKey:kUserManageDataRemark];
    [aCoder encodeObject:_regPushId forKey:kUserManageDataRegPushId];
    [aCoder encodeBool:_isDeleted forKey:kUserManageDataIsDeleted];
    [aCoder encodeObject:_weight forKey:kUserManageDataWeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserManageData *copy = [[UserManageData alloc] init];
    
    if (copy) {

        copy.qQ = [self.qQ copyWithZone:zone];
        copy.passWord = [self.passWord copyWithZone:zone];
        copy.bloodType = [self.bloodType copyWithZone:zone];
        copy.isVisible = self.isVisible;
        copy.addDate = [self.addDate copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.isAllowFllow = self.isAllowFllow;
        copy.sex = self.sex;
        copy.birthday = [self.birthday copyWithZone:zone];
        copy.portraitURL = [self.portraitURL copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
        copy.loginNameGrap = [self.loginNameGrap copyWithZone:zone];
        copy.loginName = [self.loginName copyWithZone:zone];
        copy.weiBoNo = [self.weiBoNo copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.phone = [self.phone copyWithZone:zone];
        copy.remark = [self.remark copyWithZone:zone];
        copy.regPushId = [self.regPushId copyWithZone:zone];
        copy.isDeleted = self.isDeleted;
        copy.weight = [self.weight copyWithZone:zone];
    }
    
    return copy;
}


@end
