//
//  checkQQData.m
//
//  Created by   on 15/4/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "checkQQData.h"


#define kcheckQQDataQQ  @"QQ"
#define kcheckQQDataPassWord  @"PassWord"
#define kcheckQQDataBloodType  @"BloodType"
#define kcheckQQDataIsVisible  @"IsVisible"
#define kcheckQQDataAddDate  @"AddDate"
#define kcheckQQDataUserName  @"UserName"
#define kcheckQQDataIsAllowFllow  @"IsAllowFllow"
#define kcheckQQDataSex  @"Sex"
#define kcheckQQDataUserInfoIp  @"UserInfoIp"
#define kcheckQQDataBirthday  @"Birthday"
#define kcheckQQDataPortraitURL  @"PortraitURL"
#define kcheckQQDataHeight  @"Height"
#define kcheckQQDataLoginNameGrap  @"LoginNameGrap"
#define kcheckQQDataLoginName  @"LoginName"
#define kcheckQQDataWeiBoNo  @"WeiBoNo"
#define kcheckQQDataId  @"Id"
#define kcheckQQDataPhone  @"Phone"
#define kcheckQQDataRemark  @"Remark"
#define kcheckQQDataRegPushId  @"RegPushId"
#define kcheckQQDataIsDeleted  @"IsDeleted"
#define kcheckQQDataUserType  @"UserType"
#define kcheckQQDataWeight  @"Weight"
#define kcheckQQDataImageUrl  @"ImageUrl"


@interface checkQQData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation checkQQData

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
            self.qQ = [self objectOrNilForKey:kcheckQQDataQQ fromDictionary:dict];
            self.passWord = [self objectOrNilForKey:kcheckQQDataPassWord fromDictionary:dict];
            self.bloodType = [self objectOrNilForKey:kcheckQQDataBloodType fromDictionary:dict];
            self.isVisible = [[self objectOrNilForKey:kcheckQQDataIsVisible fromDictionary:dict] boolValue];
            self.addDate = [self objectOrNilForKey:kcheckQQDataAddDate fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kcheckQQDataUserName fromDictionary:dict];
            self.isAllowFllow = [[self objectOrNilForKey:kcheckQQDataIsAllowFllow fromDictionary:dict] boolValue];
            self.sex = [[self objectOrNilForKey:kcheckQQDataSex fromDictionary:dict] doubleValue];
            self.userInfoIp = [self objectOrNilForKey:kcheckQQDataUserInfoIp fromDictionary:dict];
            self.birthday = [self objectOrNilForKey:kcheckQQDataBirthday fromDictionary:dict];
            self.portraitURL = [self objectOrNilForKey:kcheckQQDataPortraitURL fromDictionary:dict];
            self.height = [self objectOrNilForKey:kcheckQQDataHeight fromDictionary:dict];
            self.loginNameGrap = [self objectOrNilForKey:kcheckQQDataLoginNameGrap fromDictionary:dict];
            self.loginName = [self objectOrNilForKey:kcheckQQDataLoginName fromDictionary:dict];
            self.weiBoNo = [self objectOrNilForKey:kcheckQQDataWeiBoNo fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kcheckQQDataId fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kcheckQQDataPhone fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kcheckQQDataRemark fromDictionary:dict];
            self.regPushId = [self objectOrNilForKey:kcheckQQDataRegPushId fromDictionary:dict];
            self.isDeleted = [[self objectOrNilForKey:kcheckQQDataIsDeleted fromDictionary:dict] boolValue];
            self.userType = [self objectOrNilForKey:kcheckQQDataUserType fromDictionary:dict];
            self.weight = [self objectOrNilForKey:kcheckQQDataWeight fromDictionary:dict];
            self.imageUrl = [self objectOrNilForKey:kcheckQQDataImageUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.qQ forKey:kcheckQQDataQQ];
    [mutableDict setValue:self.passWord forKey:kcheckQQDataPassWord];
    [mutableDict setValue:self.bloodType forKey:kcheckQQDataBloodType];
    [mutableDict setValue:[NSNumber numberWithBool:self.isVisible] forKey:kcheckQQDataIsVisible];
    [mutableDict setValue:self.addDate forKey:kcheckQQDataAddDate];
    [mutableDict setValue:self.userName forKey:kcheckQQDataUserName];
    [mutableDict setValue:[NSNumber numberWithBool:self.isAllowFllow] forKey:kcheckQQDataIsAllowFllow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sex] forKey:kcheckQQDataSex];
    [mutableDict setValue:self.userInfoIp forKey:kcheckQQDataUserInfoIp];
    [mutableDict setValue:self.birthday forKey:kcheckQQDataBirthday];
    [mutableDict setValue:self.portraitURL forKey:kcheckQQDataPortraitURL];
    [mutableDict setValue:self.height forKey:kcheckQQDataHeight];
    [mutableDict setValue:self.loginNameGrap forKey:kcheckQQDataLoginNameGrap];
    [mutableDict setValue:self.loginName forKey:kcheckQQDataLoginName];
    [mutableDict setValue:self.weiBoNo forKey:kcheckQQDataWeiBoNo];
    [mutableDict setValue:self.dataIdentifier forKey:kcheckQQDataId];
    [mutableDict setValue:self.phone forKey:kcheckQQDataPhone];
    [mutableDict setValue:self.remark forKey:kcheckQQDataRemark];
    [mutableDict setValue:self.regPushId forKey:kcheckQQDataRegPushId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDeleted] forKey:kcheckQQDataIsDeleted];
    [mutableDict setValue:self.userType forKey:kcheckQQDataUserType];
    [mutableDict setValue:self.weight forKey:kcheckQQDataWeight];
    [mutableDict setValue:self.imageUrl forKey:kcheckQQDataImageUrl];

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

    self.qQ = [aDecoder decodeObjectForKey:kcheckQQDataQQ];
    self.passWord = [aDecoder decodeObjectForKey:kcheckQQDataPassWord];
    self.bloodType = [aDecoder decodeObjectForKey:kcheckQQDataBloodType];
    self.isVisible = [aDecoder decodeBoolForKey:kcheckQQDataIsVisible];
    self.addDate = [aDecoder decodeObjectForKey:kcheckQQDataAddDate];
    self.userName = [aDecoder decodeObjectForKey:kcheckQQDataUserName];
    self.isAllowFllow = [aDecoder decodeBoolForKey:kcheckQQDataIsAllowFllow];
    self.sex = [aDecoder decodeDoubleForKey:kcheckQQDataSex];
    self.userInfoIp = [aDecoder decodeObjectForKey:kcheckQQDataUserInfoIp];
    self.birthday = [aDecoder decodeObjectForKey:kcheckQQDataBirthday];
    self.portraitURL = [aDecoder decodeObjectForKey:kcheckQQDataPortraitURL];
    self.height = [aDecoder decodeObjectForKey:kcheckQQDataHeight];
    self.loginNameGrap = [aDecoder decodeObjectForKey:kcheckQQDataLoginNameGrap];
    self.loginName = [aDecoder decodeObjectForKey:kcheckQQDataLoginName];
    self.weiBoNo = [aDecoder decodeObjectForKey:kcheckQQDataWeiBoNo];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kcheckQQDataId];
    self.phone = [aDecoder decodeObjectForKey:kcheckQQDataPhone];
    self.remark = [aDecoder decodeObjectForKey:kcheckQQDataRemark];
    self.regPushId = [aDecoder decodeObjectForKey:kcheckQQDataRegPushId];
    self.isDeleted = [aDecoder decodeBoolForKey:kcheckQQDataIsDeleted];
    self.userType = [aDecoder decodeObjectForKey:kcheckQQDataUserType];
    self.weight = [aDecoder decodeObjectForKey:kcheckQQDataWeight];
    self.imageUrl = [aDecoder decodeObjectForKey:kcheckQQDataImageUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_qQ forKey:kcheckQQDataQQ];
    [aCoder encodeObject:_passWord forKey:kcheckQQDataPassWord];
    [aCoder encodeObject:_bloodType forKey:kcheckQQDataBloodType];
    [aCoder encodeBool:_isVisible forKey:kcheckQQDataIsVisible];
    [aCoder encodeObject:_addDate forKey:kcheckQQDataAddDate];
    [aCoder encodeObject:_userName forKey:kcheckQQDataUserName];
    [aCoder encodeBool:_isAllowFllow forKey:kcheckQQDataIsAllowFllow];
    [aCoder encodeDouble:_sex forKey:kcheckQQDataSex];
    [aCoder encodeObject:_userInfoIp forKey:kcheckQQDataUserInfoIp];
    [aCoder encodeObject:_birthday forKey:kcheckQQDataBirthday];
    [aCoder encodeObject:_portraitURL forKey:kcheckQQDataPortraitURL];
    [aCoder encodeObject:_height forKey:kcheckQQDataHeight];
    [aCoder encodeObject:_loginNameGrap forKey:kcheckQQDataLoginNameGrap];
    [aCoder encodeObject:_loginName forKey:kcheckQQDataLoginName];
    [aCoder encodeObject:_weiBoNo forKey:kcheckQQDataWeiBoNo];
    [aCoder encodeObject:_dataIdentifier forKey:kcheckQQDataId];
    [aCoder encodeObject:_phone forKey:kcheckQQDataPhone];
    [aCoder encodeObject:_remark forKey:kcheckQQDataRemark];
    [aCoder encodeObject:_regPushId forKey:kcheckQQDataRegPushId];
    [aCoder encodeBool:_isDeleted forKey:kcheckQQDataIsDeleted];
    [aCoder encodeObject:_userType forKey:kcheckQQDataUserType];
    [aCoder encodeObject:_weight forKey:kcheckQQDataWeight];
    [aCoder encodeObject:_imageUrl forKey:kcheckQQDataImageUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    checkQQData *copy = [[checkQQData alloc] init];
    
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
