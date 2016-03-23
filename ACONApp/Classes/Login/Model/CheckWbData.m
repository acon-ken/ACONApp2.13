//
//  CheckWbData.m
//
//  Created by   on 15/4/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CheckWbData.h"


#define kCheckWbDataQQ  @"QQ"
#define kCheckWbDataPassWord  @"PassWord"
#define kCheckWbDataBloodType  @"BloodType"
#define kCheckWbDataIsVisible  @"IsVisible"
#define kCheckWbDataAddDate  @"AddDate"
#define kCheckWbDataUserName  @"UserName"
#define kCheckWbDataIsAllowFllow  @"IsAllowFllow"
#define kCheckWbDataSex  @"Sex"
#define kCheckWbDataUserInfoIp  @"UserInfoIp"
#define kCheckWbDataBirthday  @"Birthday"
#define kCheckWbDataPortraitURL  @"PortraitURL"
#define kCheckWbDataHeight  @"Height"
#define kCheckWbDataLoginNameGrap  @"LoginNameGrap"
#define kCheckWbDataLoginName  @"LoginName"
#define kCheckWbDataWeiBoNo  @"WeiBoNo"
#define kCheckWbDataId  @"Id"
#define kCheckWbDataPhone  @"Phone"
#define kCheckWbDataRemark  @"Remark"
#define kCheckWbDataRegPushId  @"RegPushId"
#define kCheckWbDataIsDeleted  @"IsDeleted"
#define kCheckWbDataUserType  @"UserType"
#define kCheckWbDataWeight  @"Weight"
#define kCheckWbDataImageUrl  @"ImageUrl"


@interface CheckWbData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CheckWbData

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
            self.qQ = [self objectOrNilForKey:kCheckWbDataQQ fromDictionary:dict];
            self.passWord = [self objectOrNilForKey:kCheckWbDataPassWord fromDictionary:dict];
            self.bloodType = [self objectOrNilForKey:kCheckWbDataBloodType fromDictionary:dict];
            self.isVisible = [[self objectOrNilForKey:kCheckWbDataIsVisible fromDictionary:dict] boolValue];
            self.addDate = [self objectOrNilForKey:kCheckWbDataAddDate fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kCheckWbDataUserName fromDictionary:dict];
            self.isAllowFllow = [[self objectOrNilForKey:kCheckWbDataIsAllowFllow fromDictionary:dict] boolValue];
            self.sex = [[self objectOrNilForKey:kCheckWbDataSex fromDictionary:dict] doubleValue];
            self.userInfoIp = [self objectOrNilForKey:kCheckWbDataUserInfoIp fromDictionary:dict];
            self.birthday = [self objectOrNilForKey:kCheckWbDataBirthday fromDictionary:dict];
            self.portraitURL = [self objectOrNilForKey:kCheckWbDataPortraitURL fromDictionary:dict];
            self.height = [self objectOrNilForKey:kCheckWbDataHeight fromDictionary:dict];
            self.loginNameGrap = [self objectOrNilForKey:kCheckWbDataLoginNameGrap fromDictionary:dict];
            self.loginName = [self objectOrNilForKey:kCheckWbDataLoginName fromDictionary:dict];
            self.weiBoNo = [self objectOrNilForKey:kCheckWbDataWeiBoNo fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kCheckWbDataId fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kCheckWbDataPhone fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kCheckWbDataRemark fromDictionary:dict];
            self.regPushId = [self objectOrNilForKey:kCheckWbDataRegPushId fromDictionary:dict];
            self.isDeleted = [[self objectOrNilForKey:kCheckWbDataIsDeleted fromDictionary:dict] boolValue];
            self.userType = [self objectOrNilForKey:kCheckWbDataUserType fromDictionary:dict];
            self.weight = [self objectOrNilForKey:kCheckWbDataWeight fromDictionary:dict];
            self.imageUrl = [self objectOrNilForKey:kCheckWbDataImageUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.qQ forKey:kCheckWbDataQQ];
    [mutableDict setValue:self.passWord forKey:kCheckWbDataPassWord];
    [mutableDict setValue:self.bloodType forKey:kCheckWbDataBloodType];
    [mutableDict setValue:[NSNumber numberWithBool:self.isVisible] forKey:kCheckWbDataIsVisible];
    [mutableDict setValue:self.addDate forKey:kCheckWbDataAddDate];
    [mutableDict setValue:self.userName forKey:kCheckWbDataUserName];
    [mutableDict setValue:[NSNumber numberWithBool:self.isAllowFllow] forKey:kCheckWbDataIsAllowFllow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sex] forKey:kCheckWbDataSex];
    [mutableDict setValue:self.userInfoIp forKey:kCheckWbDataUserInfoIp];
    [mutableDict setValue:self.birthday forKey:kCheckWbDataBirthday];
    [mutableDict setValue:self.portraitURL forKey:kCheckWbDataPortraitURL];
    [mutableDict setValue:self.height forKey:kCheckWbDataHeight];
    [mutableDict setValue:self.loginNameGrap forKey:kCheckWbDataLoginNameGrap];
    [mutableDict setValue:self.loginName forKey:kCheckWbDataLoginName];
    [mutableDict setValue:self.weiBoNo forKey:kCheckWbDataWeiBoNo];
    [mutableDict setValue:self.dataIdentifier forKey:kCheckWbDataId];
    [mutableDict setValue:self.phone forKey:kCheckWbDataPhone];
    [mutableDict setValue:self.remark forKey:kCheckWbDataRemark];
    [mutableDict setValue:self.regPushId forKey:kCheckWbDataRegPushId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDeleted] forKey:kCheckWbDataIsDeleted];
    [mutableDict setValue:self.userType forKey:kCheckWbDataUserType];
    [mutableDict setValue:self.weight forKey:kCheckWbDataWeight];
    [mutableDict setValue:self.imageUrl forKey:kCheckWbDataImageUrl];

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

    self.qQ = [aDecoder decodeObjectForKey:kCheckWbDataQQ];
    self.passWord = [aDecoder decodeObjectForKey:kCheckWbDataPassWord];
    self.bloodType = [aDecoder decodeObjectForKey:kCheckWbDataBloodType];
    self.isVisible = [aDecoder decodeBoolForKey:kCheckWbDataIsVisible];
    self.addDate = [aDecoder decodeObjectForKey:kCheckWbDataAddDate];
    self.userName = [aDecoder decodeObjectForKey:kCheckWbDataUserName];
    self.isAllowFllow = [aDecoder decodeBoolForKey:kCheckWbDataIsAllowFllow];
    self.sex = [aDecoder decodeDoubleForKey:kCheckWbDataSex];
    self.userInfoIp = [aDecoder decodeObjectForKey:kCheckWbDataUserInfoIp];
    self.birthday = [aDecoder decodeObjectForKey:kCheckWbDataBirthday];
    self.portraitURL = [aDecoder decodeObjectForKey:kCheckWbDataPortraitURL];
    self.height = [aDecoder decodeObjectForKey:kCheckWbDataHeight];
    self.loginNameGrap = [aDecoder decodeObjectForKey:kCheckWbDataLoginNameGrap];
    self.loginName = [aDecoder decodeObjectForKey:kCheckWbDataLoginName];
    self.weiBoNo = [aDecoder decodeObjectForKey:kCheckWbDataWeiBoNo];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kCheckWbDataId];
    self.phone = [aDecoder decodeObjectForKey:kCheckWbDataPhone];
    self.remark = [aDecoder decodeObjectForKey:kCheckWbDataRemark];
    self.regPushId = [aDecoder decodeObjectForKey:kCheckWbDataRegPushId];
    self.isDeleted = [aDecoder decodeBoolForKey:kCheckWbDataIsDeleted];
    self.userType = [aDecoder decodeObjectForKey:kCheckWbDataUserType];
    self.weight = [aDecoder decodeObjectForKey:kCheckWbDataWeight];
    self.imageUrl = [aDecoder decodeObjectForKey:kCheckWbDataImageUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_qQ forKey:kCheckWbDataQQ];
    [aCoder encodeObject:_passWord forKey:kCheckWbDataPassWord];
    [aCoder encodeObject:_bloodType forKey:kCheckWbDataBloodType];
    [aCoder encodeBool:_isVisible forKey:kCheckWbDataIsVisible];
    [aCoder encodeObject:_addDate forKey:kCheckWbDataAddDate];
    [aCoder encodeObject:_userName forKey:kCheckWbDataUserName];
    [aCoder encodeBool:_isAllowFllow forKey:kCheckWbDataIsAllowFllow];
    [aCoder encodeDouble:_sex forKey:kCheckWbDataSex];
    [aCoder encodeObject:_userInfoIp forKey:kCheckWbDataUserInfoIp];
    [aCoder encodeObject:_birthday forKey:kCheckWbDataBirthday];
    [aCoder encodeObject:_portraitURL forKey:kCheckWbDataPortraitURL];
    [aCoder encodeObject:_height forKey:kCheckWbDataHeight];
    [aCoder encodeObject:_loginNameGrap forKey:kCheckWbDataLoginNameGrap];
    [aCoder encodeObject:_loginName forKey:kCheckWbDataLoginName];
    [aCoder encodeObject:_weiBoNo forKey:kCheckWbDataWeiBoNo];
    [aCoder encodeObject:_dataIdentifier forKey:kCheckWbDataId];
    [aCoder encodeObject:_phone forKey:kCheckWbDataPhone];
    [aCoder encodeObject:_remark forKey:kCheckWbDataRemark];
    [aCoder encodeObject:_regPushId forKey:kCheckWbDataRegPushId];
    [aCoder encodeBool:_isDeleted forKey:kCheckWbDataIsDeleted];
    [aCoder encodeObject:_userType forKey:kCheckWbDataUserType];
    [aCoder encodeObject:_weight forKey:kCheckWbDataWeight];
    [aCoder encodeObject:_imageUrl forKey:kCheckWbDataImageUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    CheckWbData *copy = [[CheckWbData alloc] init];
    
    if (copy) {

        copy.qQ = [self.qQ copyWithZone:zone];
        copy.passWord = [self.passWord copyWithZone:zone];
        copy.bloodType = [self.bloodType copyWithZone:zone];
        copy.isVisible = self.isVisible;
        copy.addDate = [self.addDate copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.isAllowFllow = self.isAllowFllow;
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
