//
//  LoginInfoData.m
//
//  Created by   on 15/4/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginInfoData.h"


#define kLoginInfoDataQQ  @"QQ"
#define kLoginInfoDataPassWord  @"PassWord"
#define kLoginInfoDataBloodType  @"BloodType"
#define kLoginInfoDataIsVisible  @"IsVisible"
#define kLoginInfoDataAddDate  @"AddDate"
#define kLoginInfoDataUserName  @"UserName"
#define kLoginInfoDataIsAllowFllow  @"IsAllowFllow"
#define kLoginInfoDataSex  @"Sex"
#define kLoginInfoDataUserInfoIp  @"UserInfoIp"
#define kLoginInfoDataBirthday  @"Birthday"
#define kLoginInfoDataPortraitURL  @"PortraitURL"
#define kLoginInfoDataHeight  @"Height"
#define kLoginInfoDataLoginNameGrap  @"LoginNameGrap"
#define kLoginInfoDataLoginName  @"LoginName"
#define kLoginInfoDataWeiBoNo  @"WeiBoNo"
#define kLoginInfoDataId  @"Id"
#define kLoginInfoDataPhone  @"Phone"
#define kLoginInfoDataRemark  @"Remark"
#define kLoginInfoDataRegPushId  @"RegPushId"
#define kLoginInfoDataIsDeleted  @"IsDeleted"
#define kLoginInfoDataUserType  @"UserType"
#define kLoginInfoDataWeight  @"Weight"
#define kLoginInfoDataImageUrl  @"ImageUrl"


@interface LoginInfoData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginInfoData

@synthesize qQ = _qQ;
@synthesize passWord = _passWord;
@synthesize bloodType = _bloodType;
@synthesize isVisible = _isVisible;
@synthesize addDate = _addDate;
@synthesize userName = _userName;
@synthesize isAllowFllow = _isAllowFllow;
@synthesize sex = _sex;
@synthesize userInfoIp = _userInfoIp;
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
@synthesize userType = _userType;
@synthesize weight = _weight;
@synthesize imageUrl = _imageUrl;


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
            self.qQ = [self objectOrNilForKey:kLoginInfoDataQQ fromDictionary:dict];
            self.passWord = [self objectOrNilForKey:kLoginInfoDataPassWord fromDictionary:dict];
            self.bloodType = [self objectOrNilForKey:kLoginInfoDataBloodType fromDictionary:dict];
            self.isVisible = [[self objectOrNilForKey:kLoginInfoDataIsVisible fromDictionary:dict] boolValue];
            self.addDate = [self objectOrNilForKey:kLoginInfoDataAddDate fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kLoginInfoDataUserName fromDictionary:dict];
            self.isAllowFllow = [self objectOrNilForKey:kLoginInfoDataIsAllowFllow fromDictionary:dict];
            self.sex = [[self objectOrNilForKey:kLoginInfoDataSex fromDictionary:dict] doubleValue];
            self.userInfoIp = [self objectOrNilForKey:kLoginInfoDataUserInfoIp fromDictionary:dict];
            self.birthday = [self objectOrNilForKey:kLoginInfoDataBirthday fromDictionary:dict];
            self.portraitURL = [self objectOrNilForKey:kLoginInfoDataPortraitURL fromDictionary:dict];
            self.height = [self objectOrNilForKey:kLoginInfoDataHeight fromDictionary:dict];
            self.loginNameGrap = [self objectOrNilForKey:kLoginInfoDataLoginNameGrap fromDictionary:dict];
            self.loginName = [self objectOrNilForKey:kLoginInfoDataLoginName fromDictionary:dict];
            self.weiBoNo = [self objectOrNilForKey:kLoginInfoDataWeiBoNo fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kLoginInfoDataId fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kLoginInfoDataPhone fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kLoginInfoDataRemark fromDictionary:dict];
            self.regPushId = [self objectOrNilForKey:kLoginInfoDataRegPushId fromDictionary:dict];
            self.isDeleted = [[self objectOrNilForKey:kLoginInfoDataIsDeleted fromDictionary:dict] boolValue];
            self.userType = [self objectOrNilForKey:kLoginInfoDataUserType fromDictionary:dict];
            self.weight = [self objectOrNilForKey:kLoginInfoDataWeight fromDictionary:dict];
            self.imageUrl = [self objectOrNilForKey:kLoginInfoDataImageUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.qQ forKey:kLoginInfoDataQQ];
    [mutableDict setValue:self.passWord forKey:kLoginInfoDataPassWord];
    [mutableDict setValue:self.bloodType forKey:kLoginInfoDataBloodType];
    [mutableDict setValue:[NSNumber numberWithBool:self.isVisible] forKey:kLoginInfoDataIsVisible];
    [mutableDict setValue:self.addDate forKey:kLoginInfoDataAddDate];
    [mutableDict setValue:self.userName forKey:kLoginInfoDataUserName];
    [mutableDict setValue:self.isAllowFllow forKey:kLoginInfoDataIsAllowFllow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sex] forKey:kLoginInfoDataSex];
    [mutableDict setValue:self.userInfoIp forKey:kLoginInfoDataUserInfoIp];
    [mutableDict setValue:self.birthday forKey:kLoginInfoDataBirthday];
    [mutableDict setValue:self.portraitURL forKey:kLoginInfoDataPortraitURL];
    [mutableDict setValue:self.height forKey:kLoginInfoDataHeight];
    [mutableDict setValue:self.loginNameGrap forKey:kLoginInfoDataLoginNameGrap];
    [mutableDict setValue:self.loginName forKey:kLoginInfoDataLoginName];
    [mutableDict setValue:self.weiBoNo forKey:kLoginInfoDataWeiBoNo];
    [mutableDict setValue:self.dataIdentifier forKey:kLoginInfoDataId];
    [mutableDict setValue:self.phone forKey:kLoginInfoDataPhone];
    [mutableDict setValue:self.remark forKey:kLoginInfoDataRemark];
    [mutableDict setValue:self.regPushId forKey:kLoginInfoDataRegPushId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDeleted] forKey:kLoginInfoDataIsDeleted];
    [mutableDict setValue:self.userType forKey:kLoginInfoDataUserType];
    [mutableDict setValue:self.weight forKey:kLoginInfoDataWeight];
    [mutableDict setValue:self.imageUrl forKey:kLoginInfoDataImageUrl];

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

    self.qQ = [aDecoder decodeObjectForKey:kLoginInfoDataQQ];
    self.passWord = [aDecoder decodeObjectForKey:kLoginInfoDataPassWord];
    self.bloodType = [aDecoder decodeObjectForKey:kLoginInfoDataBloodType];
    self.isVisible = [aDecoder decodeBoolForKey:kLoginInfoDataIsVisible];
    self.addDate = [aDecoder decodeObjectForKey:kLoginInfoDataAddDate];
    self.userName = [aDecoder decodeObjectForKey:kLoginInfoDataUserName];
    self.isAllowFllow = [aDecoder decodeObjectForKey:kLoginInfoDataIsAllowFllow];
    self.sex = [aDecoder decodeDoubleForKey:kLoginInfoDataSex];
    self.userInfoIp = [aDecoder decodeObjectForKey:kLoginInfoDataUserInfoIp];
    self.birthday = [aDecoder decodeObjectForKey:kLoginInfoDataBirthday];
    self.portraitURL = [aDecoder decodeObjectForKey:kLoginInfoDataPortraitURL];
    self.height = [aDecoder decodeObjectForKey:kLoginInfoDataHeight];
    self.loginNameGrap = [aDecoder decodeObjectForKey:kLoginInfoDataLoginNameGrap];
    self.loginName = [aDecoder decodeObjectForKey:kLoginInfoDataLoginName];
    self.weiBoNo = [aDecoder decodeObjectForKey:kLoginInfoDataWeiBoNo];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kLoginInfoDataId];
    self.phone = [aDecoder decodeObjectForKey:kLoginInfoDataPhone];
    self.remark = [aDecoder decodeObjectForKey:kLoginInfoDataRemark];
    self.regPushId = [aDecoder decodeObjectForKey:kLoginInfoDataRegPushId];
    self.isDeleted = [aDecoder decodeBoolForKey:kLoginInfoDataIsDeleted];
    self.userType = [aDecoder decodeObjectForKey:kLoginInfoDataUserType];
    self.weight = [aDecoder decodeObjectForKey:kLoginInfoDataWeight];
    self.imageUrl = [aDecoder decodeObjectForKey:kLoginInfoDataImageUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_qQ forKey:kLoginInfoDataQQ];
    [aCoder encodeObject:_passWord forKey:kLoginInfoDataPassWord];
    [aCoder encodeObject:_bloodType forKey:kLoginInfoDataBloodType];
    [aCoder encodeBool:_isVisible forKey:kLoginInfoDataIsVisible];
    [aCoder encodeObject:_addDate forKey:kLoginInfoDataAddDate];
    [aCoder encodeObject:_userName forKey:kLoginInfoDataUserName];
    [aCoder encodeObject:_isAllowFllow forKey:kLoginInfoDataIsAllowFllow];
    [aCoder encodeDouble:_sex forKey:kLoginInfoDataSex];
    [aCoder encodeObject:_userInfoIp forKey:kLoginInfoDataUserInfoIp];
    [aCoder encodeObject:_birthday forKey:kLoginInfoDataBirthday];
    [aCoder encodeObject:_portraitURL forKey:kLoginInfoDataPortraitURL];
    [aCoder encodeObject:_height forKey:kLoginInfoDataHeight];
    [aCoder encodeObject:_loginNameGrap forKey:kLoginInfoDataLoginNameGrap];
    [aCoder encodeObject:_loginName forKey:kLoginInfoDataLoginName];
    [aCoder encodeObject:_weiBoNo forKey:kLoginInfoDataWeiBoNo];
    [aCoder encodeObject:_dataIdentifier forKey:kLoginInfoDataId];
    [aCoder encodeObject:_phone forKey:kLoginInfoDataPhone];
    [aCoder encodeObject:_remark forKey:kLoginInfoDataRemark];
    [aCoder encodeObject:_regPushId forKey:kLoginInfoDataRegPushId];
    [aCoder encodeBool:_isDeleted forKey:kLoginInfoDataIsDeleted];
    [aCoder encodeObject:_userType forKey:kLoginInfoDataUserType];
    [aCoder encodeObject:_weight forKey:kLoginInfoDataWeight];
    [aCoder encodeObject:_imageUrl forKey:kLoginInfoDataImageUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginInfoData *copy = [[LoginInfoData alloc] init];
    
    if (copy) {

        copy.qQ = [self.qQ copyWithZone:zone];
        copy.passWord = [self.passWord copyWithZone:zone];
        copy.bloodType = [self.bloodType copyWithZone:zone];
        copy.isVisible = self.isVisible;
        copy.addDate = [self.addDate copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.isAllowFllow = [self.isAllowFllow copyWithZone:zone];
        copy.sex = self.sex;
        copy.userInfoIp = [self.userInfoIp copyWithZone:zone];
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
        copy.userType = [self.userType copyWithZone:zone];
        copy.weight = [self.weight copyWithZone:zone];
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
    }
    
    return copy;
}


@end
