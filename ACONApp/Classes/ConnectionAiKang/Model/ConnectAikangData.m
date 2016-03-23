//
//  ConnectAikangData.m
//
//  Created by   on 14/12/19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ConnectAikangData.h"


#define kConnectAikangDataImageUrl  @"ImageUrl"
#define kConnectAikangDataAddDate  @"AddDate"
#define kConnectAikangDataId  @"Id"
#define kConnectAikangDataPhone  @"Phone"
#define kConnectAikangDataAddress  @"Address"
#define kConnectAikangDataContent  @"Content"
#define kConnectAikangDataIsDeleted  @"IsDeleted"
#define kConnectAikangDataAddDateStr  @"AddDateStr"
#define kConnectAikangDataSuppName  @"SuppName"


@interface ConnectAikangData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ConnectAikangData

@synthesize imageUrl = _imageUrl;
@synthesize addDate = _addDate;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize phone = _phone;
@synthesize address = _address;
@synthesize content = _content;
@synthesize isDeleted = _isDeleted;
@synthesize addDateStr = _addDateStr;
@synthesize suppName = _suppName;


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
            self.imageUrl = [self objectOrNilForKey:kConnectAikangDataImageUrl fromDictionary:dict];
            self.addDate = [self objectOrNilForKey:kConnectAikangDataAddDate fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kConnectAikangDataId fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kConnectAikangDataPhone fromDictionary:dict];
            self.address = [self objectOrNilForKey:kConnectAikangDataAddress fromDictionary:dict];
            self.content = [self objectOrNilForKey:kConnectAikangDataContent fromDictionary:dict];
            self.isDeleted = [[self objectOrNilForKey:kConnectAikangDataIsDeleted fromDictionary:dict] boolValue];
            self.addDateStr = [self objectOrNilForKey:kConnectAikangDataAddDateStr fromDictionary:dict];
            self.suppName = [self objectOrNilForKey:kConnectAikangDataSuppName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imageUrl forKey:kConnectAikangDataImageUrl];
    [mutableDict setValue:self.addDate forKey:kConnectAikangDataAddDate];
    [mutableDict setValue:self.dataIdentifier forKey:kConnectAikangDataId];
    [mutableDict setValue:self.phone forKey:kConnectAikangDataPhone];
    [mutableDict setValue:self.address forKey:kConnectAikangDataAddress];
    [mutableDict setValue:self.content forKey:kConnectAikangDataContent];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDeleted] forKey:kConnectAikangDataIsDeleted];
    [mutableDict setValue:self.addDateStr forKey:kConnectAikangDataAddDateStr];
    [mutableDict setValue:self.suppName forKey:kConnectAikangDataSuppName];

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

    self.imageUrl = [aDecoder decodeObjectForKey:kConnectAikangDataImageUrl];
    self.addDate = [aDecoder decodeObjectForKey:kConnectAikangDataAddDate];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kConnectAikangDataId];
    self.phone = [aDecoder decodeObjectForKey:kConnectAikangDataPhone];
    self.address = [aDecoder decodeObjectForKey:kConnectAikangDataAddress];
    self.content = [aDecoder decodeObjectForKey:kConnectAikangDataContent];
    self.isDeleted = [aDecoder decodeBoolForKey:kConnectAikangDataIsDeleted];
    self.addDateStr = [aDecoder decodeObjectForKey:kConnectAikangDataAddDateStr];
    self.suppName = [aDecoder decodeObjectForKey:kConnectAikangDataSuppName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imageUrl forKey:kConnectAikangDataImageUrl];
    [aCoder encodeObject:_addDate forKey:kConnectAikangDataAddDate];
    [aCoder encodeObject:_dataIdentifier forKey:kConnectAikangDataId];
    [aCoder encodeObject:_phone forKey:kConnectAikangDataPhone];
    [aCoder encodeObject:_address forKey:kConnectAikangDataAddress];
    [aCoder encodeObject:_content forKey:kConnectAikangDataContent];
    [aCoder encodeBool:_isDeleted forKey:kConnectAikangDataIsDeleted];
    [aCoder encodeObject:_addDateStr forKey:kConnectAikangDataAddDateStr];
    [aCoder encodeObject:_suppName forKey:kConnectAikangDataSuppName];
}

- (id)copyWithZone:(NSZone *)zone
{
    ConnectAikangData *copy = [[ConnectAikangData alloc] init];
    
    if (copy) {

        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.addDate = [self.addDate copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.phone = [self.phone copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.isDeleted = self.isDeleted;
        copy.addDateStr = [self.addDateStr copyWithZone:zone];
        copy.suppName = [self.suppName copyWithZone:zone];
    }
    
    return copy;
}


@end
