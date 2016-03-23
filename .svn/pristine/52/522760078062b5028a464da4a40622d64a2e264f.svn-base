//
//  SearchUserData.m
//
//  Created by   on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SearchUserData.h"


#define kSearchUserDataQQ  @"QQ"
#define kSearchUserDataPassWord  @"PassWord"
#define kSearchUserDataBloodType  @"BloodType"
#define kSearchUserDataIsVisible  @"IsVisible"
#define kSearchUserDataAddDate  @"AddDate"
#define kSearchUserDataUserName  @"UserName"
#define kSearchUserDataIsAllowFllow  @"IsAllowFllow"
#define kSearchUserDataSex  @"Sex"
#define kSearchUserDataBirthday  @"Birthday"
#define kSearchUserDataPortraitURL  @"PortraitURL"
#define kSearchUserDataHeight  @"Height"
#define kSearchUserDataLoginNameGrap  @"LoginNameGrap"
#define kSearchUserDataLoginName  @"LoginName"
#define kSearchUserDataWeiBoNo  @"WeiBoNo"
#define kSearchUserDataId  @"Id"
#define kSearchUserDataPhone  @"Phone"
#define kSearchUserDataRemark  @"Remark"
#define kSearchUserDataRegPushId  @"RegPushId"
#define kSearchUserDataIsDeleted  @"IsDeleted"
#define kSearchUserDataWeight  @"Weight"


@interface SearchUserData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SearchUserData

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
            self.qQ = [self objectOrNilForKey:kSearchUserDataQQ fromDictionary:dict];
            self.passWord = [self objectOrNilForKey:kSearchUserDataPassWord fromDictionary:dict];
            self.bloodType = [self objectOrNilForKey:kSearchUserDataBloodType fromDictionary:dict];
            self.isVisible = [[self objectOrNilForKey:kSearchUserDataIsVisible fromDictionary:dict] boolValue];
            self.addDate = [self objectOrNilForKey:kSearchUserDataAddDate fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kSearchUserDataUserName fromDictionary:dict];
            self.isAllowFllow = [self objectOrNilForKey:kSearchUserDataIsAllowFllow fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kSearchUserDataSex fromDictionary:dict];
            self.birthday = [self objectOrNilForKey:kSearchUserDataBirthday fromDictionary:dict];
            self.portraitURL = [self objectOrNilForKey:kSearchUserDataPortraitURL fromDictionary:dict];
            self.height = [self objectOrNilForKey:kSearchUserDataHeight fromDictionary:dict];
            self.loginNameGrap = [self objectOrNilForKey:kSearchUserDataLoginNameGrap fromDictionary:dict];
            self.loginName = [self objectOrNilForKey:kSearchUserDataLoginName fromDictionary:dict];
            self.weiBoNo = [self objectOrNilForKey:kSearchUserDataWeiBoNo fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kSearchUserDataId fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kSearchUserDataPhone fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kSearchUserDataRemark fromDictionary:dict];
            self.regPushId = [self objectOrNilForKey:kSearchUserDataRegPushId fromDictionary:dict];
            self.isDeleted = [[self objectOrNilForKey:kSearchUserDataIsDeleted fromDictionary:dict] boolValue];
            self.weight = [self objectOrNilForKey:kSearchUserDataWeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.qQ forKey:kSearchUserDataQQ];
    [mutableDict setValue:self.passWord forKey:kSearchUserDataPassWord];
    [mutableDict setValue:self.bloodType forKey:kSearchUserDataBloodType];
    [mutableDict setValue:[NSNumber numberWithBool:self.isVisible] forKey:kSearchUserDataIsVisible];
    [mutableDict setValue:self.addDate forKey:kSearchUserDataAddDate];
    [mutableDict setValue:self.userName forKey:kSearchUserDataUserName];
    [mutableDict setValue:self.isAllowFllow forKey:kSearchUserDataIsAllowFllow];
    [mutableDict setValue:self.sex forKey:kSearchUserDataSex];
    [mutableDict setValue:self.birthday forKey:kSearchUserDataBirthday];
    [mutableDict setValue:self.portraitURL forKey:kSearchUserDataPortraitURL];
    [mutableDict setValue:self.height forKey:kSearchUserDataHeight];
    [mutableDict setValue:self.loginNameGrap forKey:kSearchUserDataLoginNameGrap];
    [mutableDict setValue:self.loginName forKey:kSearchUserDataLoginName];
    [mutableDict setValue:self.weiBoNo forKey:kSearchUserDataWeiBoNo];
    [mutableDict setValue:self.dataIdentifier forKey:kSearchUserDataId];
    [mutableDict setValue:self.phone forKey:kSearchUserDataPhone];
    [mutableDict setValue:self.remark forKey:kSearchUserDataRemark];
    [mutableDict setValue:self.regPushId forKey:kSearchUserDataRegPushId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDeleted] forKey:kSearchUserDataIsDeleted];
    [mutableDict setValue:self.weight forKey:kSearchUserDataWeight];

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

    self.qQ = [aDecoder decodeObjectForKey:kSearchUserDataQQ];
    self.passWord = [aDecoder decodeObjectForKey:kSearchUserDataPassWord];
    self.bloodType = [aDecoder decodeObjectForKey:kSearchUserDataBloodType];
    self.isVisible = [aDecoder decodeBoolForKey:kSearchUserDataIsVisible];
    self.addDate = [aDecoder decodeObjectForKey:kSearchUserDataAddDate];
    self.userName = [aDecoder decodeObjectForKey:kSearchUserDataUserName];
    self.isAllowFllow = [aDecoder decodeObjectForKey:kSearchUserDataIsAllowFllow];
    self.sex = [aDecoder decodeObjectForKey:kSearchUserDataSex];
    self.birthday = [aDecoder decodeObjectForKey:kSearchUserDataBirthday];
    self.portraitURL = [aDecoder decodeObjectForKey:kSearchUserDataPortraitURL];
    self.height = [aDecoder decodeObjectForKey:kSearchUserDataHeight];
    self.loginNameGrap = [aDecoder decodeObjectForKey:kSearchUserDataLoginNameGrap];
    self.loginName = [aDecoder decodeObjectForKey:kSearchUserDataLoginName];
    self.weiBoNo = [aDecoder decodeObjectForKey:kSearchUserDataWeiBoNo];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kSearchUserDataId];
    self.phone = [aDecoder decodeObjectForKey:kSearchUserDataPhone];
    self.remark = [aDecoder decodeObjectForKey:kSearchUserDataRemark];
    self.regPushId = [aDecoder decodeObjectForKey:kSearchUserDataRegPushId];
    self.isDeleted = [aDecoder decodeBoolForKey:kSearchUserDataIsDeleted];
    self.weight = [aDecoder decodeObjectForKey:kSearchUserDataWeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_qQ forKey:kSearchUserDataQQ];
    [aCoder encodeObject:_passWord forKey:kSearchUserDataPassWord];
    [aCoder encodeObject:_bloodType forKey:kSearchUserDataBloodType];
    [aCoder encodeBool:_isVisible forKey:kSearchUserDataIsVisible];
    [aCoder encodeObject:_addDate forKey:kSearchUserDataAddDate];
    [aCoder encodeObject:_userName forKey:kSearchUserDataUserName];
    [aCoder encodeObject:_isAllowFllow forKey:kSearchUserDataIsAllowFllow];
    [aCoder encodeObject:_sex forKey:kSearchUserDataSex];
    [aCoder encodeObject:_birthday forKey:kSearchUserDataBirthday];
    [aCoder encodeObject:_portraitURL forKey:kSearchUserDataPortraitURL];
    [aCoder encodeObject:_height forKey:kSearchUserDataHeight];
    [aCoder encodeObject:_loginNameGrap forKey:kSearchUserDataLoginNameGrap];
    [aCoder encodeObject:_loginName forKey:kSearchUserDataLoginName];
    [aCoder encodeObject:_weiBoNo forKey:kSearchUserDataWeiBoNo];
    [aCoder encodeObject:_dataIdentifier forKey:kSearchUserDataId];
    [aCoder encodeObject:_phone forKey:kSearchUserDataPhone];
    [aCoder encodeObject:_remark forKey:kSearchUserDataRemark];
    [aCoder encodeObject:_regPushId forKey:kSearchUserDataRegPushId];
    [aCoder encodeBool:_isDeleted forKey:kSearchUserDataIsDeleted];
    [aCoder encodeObject:_weight forKey:kSearchUserDataWeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    SearchUserData *copy = [[SearchUserData alloc] init];
    
    if (copy) {

        copy.qQ = [self.qQ copyWithZone:zone];
        copy.passWord = [self.passWord copyWithZone:zone];
        copy.bloodType = [self.bloodType copyWithZone:zone];
        copy.isVisible = self.isVisible;
        copy.addDate = [self.addDate copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.isAllowFllow = [self.isAllowFllow copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
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
