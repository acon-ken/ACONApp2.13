//
//  SysteminformationData.m
//
//  Created by   on 14/12/16
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SysteminformationData.h"


#define kSysteminformationDataUserNameSend  @"UserNameSend"
#define kSysteminformationDataMsgStatus  @"MsgStatus"
#define kSysteminformationDataId  @"Id"
#define kSysteminformationDataUserIdSend  @"UserIdSend"
#define kSysteminformationDataIsRead  @"IsRead"
#define kSysteminformationDataIsDelete  @"IsDelete"
#define kSysteminformationDataRequestDate  @"RequestDate"
#define kSysteminformationDataUserIdRecive  @"UserIdRecive"
#define kSysteminformationDataMsgContent  @"MsgContent"
#define kSysteminformationDataAddDate  @"AddDate"
#define kSysteminformationDataPhoneReceive  @"PhoneReceive"
#define kSysteminformationDataPushIdRecive  @"PushIdRecive"


@interface SysteminformationData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SysteminformationData

@synthesize userNameSend = _userNameSend;
@synthesize msgStatus = _msgStatus;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize userIdSend = _userIdSend;
@synthesize isRead = _isRead;
@synthesize isDelete = _isDelete;
@synthesize requestDate = _requestDate;
@synthesize userIdRecive = _userIdRecive;
@synthesize msgContent = _msgContent;
@synthesize addDate = _addDate;
@synthesize phoneReceive = _phoneReceive;
@synthesize pushIdRecive = _pushIdRecive;


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
            self.userNameSend = [self objectOrNilForKey:kSysteminformationDataUserNameSend fromDictionary:dict];
            self.msgStatus = [[self objectOrNilForKey:kSysteminformationDataMsgStatus fromDictionary:dict] doubleValue];
            self.dataIdentifier = [self objectOrNilForKey:kSysteminformationDataId fromDictionary:dict];
            self.userIdSend = [self objectOrNilForKey:kSysteminformationDataUserIdSend fromDictionary:dict];
            self.isRead = [[self objectOrNilForKey:kSysteminformationDataIsRead fromDictionary:dict] boolValue];
            self.isDelete = [[self objectOrNilForKey:kSysteminformationDataIsDelete fromDictionary:dict] boolValue];
            self.requestDate = [self objectOrNilForKey:kSysteminformationDataRequestDate fromDictionary:dict];
            self.userIdRecive = [self objectOrNilForKey:kSysteminformationDataUserIdRecive fromDictionary:dict];
            self.msgContent = [self objectOrNilForKey:kSysteminformationDataMsgContent fromDictionary:dict];
            self.addDate = [self objectOrNilForKey:kSysteminformationDataAddDate fromDictionary:dict];
            self.phoneReceive = [self objectOrNilForKey:kSysteminformationDataPhoneReceive fromDictionary:dict];
            self.pushIdRecive = [self objectOrNilForKey:kSysteminformationDataPushIdRecive fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userNameSend forKey:kSysteminformationDataUserNameSend];
    [mutableDict setValue:[NSNumber numberWithDouble:self.msgStatus] forKey:kSysteminformationDataMsgStatus];
    [mutableDict setValue:self.dataIdentifier forKey:kSysteminformationDataId];
    [mutableDict setValue:self.userIdSend forKey:kSysteminformationDataUserIdSend];
    [mutableDict setValue:[NSNumber numberWithBool:self.isRead] forKey:kSysteminformationDataIsRead];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDelete] forKey:kSysteminformationDataIsDelete];
    [mutableDict setValue:self.requestDate forKey:kSysteminformationDataRequestDate];
    [mutableDict setValue:self.userIdRecive forKey:kSysteminformationDataUserIdRecive];
    [mutableDict setValue:self.msgContent forKey:kSysteminformationDataMsgContent];
    [mutableDict setValue:self.addDate forKey:kSysteminformationDataAddDate];
    [mutableDict setValue:self.phoneReceive forKey:kSysteminformationDataPhoneReceive];
    [mutableDict setValue:self.pushIdRecive forKey:kSysteminformationDataPushIdRecive];

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

    self.userNameSend = [aDecoder decodeObjectForKey:kSysteminformationDataUserNameSend];
    self.msgStatus = [aDecoder decodeDoubleForKey:kSysteminformationDataMsgStatus];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kSysteminformationDataId];
    self.userIdSend = [aDecoder decodeObjectForKey:kSysteminformationDataUserIdSend];
    self.isRead = [aDecoder decodeBoolForKey:kSysteminformationDataIsRead];
    self.isDelete = [aDecoder decodeBoolForKey:kSysteminformationDataIsDelete];
    self.requestDate = [aDecoder decodeObjectForKey:kSysteminformationDataRequestDate];
    self.userIdRecive = [aDecoder decodeObjectForKey:kSysteminformationDataUserIdRecive];
    self.msgContent = [aDecoder decodeObjectForKey:kSysteminformationDataMsgContent];
    self.addDate = [aDecoder decodeObjectForKey:kSysteminformationDataAddDate];
    self.phoneReceive = [aDecoder decodeObjectForKey:kSysteminformationDataPhoneReceive];
    self.pushIdRecive = [aDecoder decodeObjectForKey:kSysteminformationDataPushIdRecive];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userNameSend forKey:kSysteminformationDataUserNameSend];
    [aCoder encodeDouble:_msgStatus forKey:kSysteminformationDataMsgStatus];
    [aCoder encodeObject:_dataIdentifier forKey:kSysteminformationDataId];
    [aCoder encodeObject:_userIdSend forKey:kSysteminformationDataUserIdSend];
    [aCoder encodeBool:_isRead forKey:kSysteminformationDataIsRead];
    [aCoder encodeBool:_isDelete forKey:kSysteminformationDataIsDelete];
    [aCoder encodeObject:_requestDate forKey:kSysteminformationDataRequestDate];
    [aCoder encodeObject:_userIdRecive forKey:kSysteminformationDataUserIdRecive];
    [aCoder encodeObject:_msgContent forKey:kSysteminformationDataMsgContent];
    [aCoder encodeObject:_addDate forKey:kSysteminformationDataAddDate];
    [aCoder encodeObject:_phoneReceive forKey:kSysteminformationDataPhoneReceive];
    [aCoder encodeObject:_pushIdRecive forKey:kSysteminformationDataPushIdRecive];
}

- (id)copyWithZone:(NSZone *)zone
{
    SysteminformationData *copy = [[SysteminformationData alloc] init];
    
    if (copy) {

        copy.userNameSend = [self.userNameSend copyWithZone:zone];
        copy.msgStatus = self.msgStatus;
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.userIdSend = [self.userIdSend copyWithZone:zone];
        copy.isRead = self.isRead;
        copy.isDelete = self.isDelete;
        copy.requestDate = [self.requestDate copyWithZone:zone];
        copy.userIdRecive = [self.userIdRecive copyWithZone:zone];
        copy.msgContent = [self.msgContent copyWithZone:zone];
        copy.addDate = [self.addDate copyWithZone:zone];
        copy.phoneReceive = [self.phoneReceive copyWithZone:zone];
        copy.pushIdRecive = [self.pushIdRecive copyWithZone:zone];
    }
    
    return copy;
}


@end
