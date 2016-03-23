//
//  KnowledgeData.m
//
//  Created by   on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "KnowledgeData.h"


#define kKnowledgeDataContent  @"Content"
#define kKnowledgeDataId  @"Id"
#define kKnowledgeDataUserId  @"UserId"
#define kKnowledgeDataIsReply  @"IsReply"
#define kKnowledgeDataRemark  @"Remark"
#define kKnowledgeDataPhone  @"Phone"
#define kKnowledgeDataUserName  @"UserName"
#define kKnowledgeDataAddDateFormat  @"AddDateFormat"
#define kKnowledgeDataAddDate  @"AddDate"
#define kKnowledgeDataReply  @"Reply"
#define kKnowledgeDataTypeName  @"TypeName"
#define kKnowledgeDataIsDeleted  @"IsDeleted"
#define kKnowledgeDataIsShow  @"IsShow"

@interface KnowledgeData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation KnowledgeData

@synthesize content = _content;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize userId = _userId;
@synthesize isReply = _isReply;
@synthesize remark = _remark;
@synthesize phone = _phone;
@synthesize userName = _userName;
@synthesize addDateFormat = _addDateFormat;
@synthesize addDate = _addDate;
@synthesize reply = _reply;
@synthesize typeName = _typeName;
@synthesize isDeleted = _isDeleted;
@synthesize isShow = _isShow;

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
            self.content = [self objectOrNilForKey:kKnowledgeDataContent fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kKnowledgeDataId fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kKnowledgeDataUserId fromDictionary:dict];
            self.isReply = [[self objectOrNilForKey:kKnowledgeDataIsReply fromDictionary:dict] boolValue];
            self.remark = [self objectOrNilForKey:kKnowledgeDataRemark fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kKnowledgeDataPhone fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kKnowledgeDataUserName fromDictionary:dict];
            self.addDateFormat = [self objectOrNilForKey:kKnowledgeDataAddDateFormat fromDictionary:dict];
            self.addDate = [self objectOrNilForKey:kKnowledgeDataAddDate fromDictionary:dict];
            self.reply = [self objectOrNilForKey:kKnowledgeDataReply fromDictionary:dict];
            self.typeName = [[self objectOrNilForKey:kKnowledgeDataTypeName fromDictionary:dict] doubleValue];
            self.isDeleted = [[self objectOrNilForKey:kKnowledgeDataIsDeleted fromDictionary:dict] boolValue];
            self.isShow = [[self objectOrNilForKey:kKnowledgeDataIsShow fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.content forKey:kKnowledgeDataContent];
    [mutableDict setValue:self.dataIdentifier forKey:kKnowledgeDataId];
    [mutableDict setValue:self.userId forKey:kKnowledgeDataUserId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isReply] forKey:kKnowledgeDataIsReply];
    [mutableDict setValue:self.remark forKey:kKnowledgeDataRemark];
    [mutableDict setValue:self.phone forKey:kKnowledgeDataPhone];
    [mutableDict setValue:self.userName forKey:kKnowledgeDataUserName];
    [mutableDict setValue:self.addDateFormat forKey:kKnowledgeDataAddDateFormat];
    [mutableDict setValue:self.addDate forKey:kKnowledgeDataAddDate];
    [mutableDict setValue:self.reply forKey:kKnowledgeDataReply];
    [mutableDict setValue:[NSNumber numberWithDouble:self.typeName] forKey:kKnowledgeDataTypeName];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDeleted] forKey:kKnowledgeDataIsDeleted];
    [mutableDict setValue:[NSNumber numberWithBool:self.isShow] forKey:kKnowledgeDataIsShow];

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

    self.content = [aDecoder decodeObjectForKey:kKnowledgeDataContent];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kKnowledgeDataId];
    self.userId = [aDecoder decodeObjectForKey:kKnowledgeDataUserId];
    self.isReply = [aDecoder decodeBoolForKey:kKnowledgeDataIsReply];
    self.remark = [aDecoder decodeObjectForKey:kKnowledgeDataRemark];
    self.phone = [aDecoder decodeObjectForKey:kKnowledgeDataPhone];
    self.userName = [aDecoder decodeObjectForKey:kKnowledgeDataUserName];
    self.addDateFormat = [aDecoder decodeObjectForKey:kKnowledgeDataAddDateFormat];
    self.addDate = [aDecoder decodeObjectForKey:kKnowledgeDataAddDate];
    self.reply = [aDecoder decodeObjectForKey:kKnowledgeDataReply];
    self.typeName = [aDecoder decodeDoubleForKey:kKnowledgeDataTypeName];
    self.isDeleted = [aDecoder decodeBoolForKey:kKnowledgeDataIsDeleted];
    self.isShow = [aDecoder decodeBoolForKey:kKnowledgeDataIsShow];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_content forKey:kKnowledgeDataContent];
    [aCoder encodeObject:_dataIdentifier forKey:kKnowledgeDataId];
    [aCoder encodeObject:_userId forKey:kKnowledgeDataUserId];
    [aCoder encodeBool:_isReply forKey:kKnowledgeDataIsReply];
    [aCoder encodeObject:_remark forKey:kKnowledgeDataRemark];
    [aCoder encodeObject:_phone forKey:kKnowledgeDataPhone];
    [aCoder encodeObject:_userName forKey:kKnowledgeDataUserName];
    [aCoder encodeObject:_addDateFormat forKey:kKnowledgeDataAddDateFormat];
    [aCoder encodeObject:_addDate forKey:kKnowledgeDataAddDate];
    [aCoder encodeObject:_reply forKey:kKnowledgeDataReply];
    [aCoder encodeDouble:_typeName forKey:kKnowledgeDataTypeName];
    [aCoder encodeBool:_isDeleted forKey:kKnowledgeDataIsDeleted];
    [aCoder encodeBool:_isDeleted forKey:kKnowledgeDataIsShow];
}

- (id)copyWithZone:(NSZone *)zone
{
    KnowledgeData *copy = [[KnowledgeData alloc] init];
    
    if (copy) {

        copy.content = [self.content copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.isReply = self.isReply;
        copy.remark = [self.remark copyWithZone:zone];
        copy.phone = [self.phone copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.addDateFormat = [self.addDateFormat copyWithZone:zone];
        copy.addDate = [self.addDate copyWithZone:zone];
        copy.reply = [self.reply copyWithZone:zone];
        copy.typeName = self.typeName;
        copy.isDeleted = self.isDeleted;
        copy.isShow = self.isShow;
    }
    
    return copy;
}


@end
