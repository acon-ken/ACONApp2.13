//
//  Data.m
//
//  Created by   on 15/1/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UpdateVersionData.h"


NSString *const kDataAddDate = @"AddDate";
NSString *const kDataRemark = @"Remark";
NSString *const kDataVersionsURL = @"VersionsURL";
NSString *const kDataId = @"Id";
NSString *const kDataIsDeleted = @"IsDeleted";
NSString *const kDataContent = @"Content";
NSString *const kDataVersionsNo = @"VersionsNo";
NSString *const kDataAddDateStr = @"AddDateStr";
NSString *const kDataVersionType = @"VersionType";
NSString *const kDataTypeStr = @"TypeStr";


@interface UpdateVersionData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UpdateVersionData

@synthesize addDate = _addDate;
@synthesize remark = _remark;
@synthesize versionsURL = _versionsURL;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize isDeleted = _isDeleted;
@synthesize content = _content;
@synthesize versionsNo = _versionsNo;
@synthesize addDateStr = _addDateStr;
@synthesize versionType = _versionType;
@synthesize typeStr = _typeStr;


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
            self.addDate = [self objectOrNilForKey:kDataAddDate fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kDataRemark fromDictionary:dict];
            self.versionsURL = [self objectOrNilForKey:kDataVersionsURL fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kDataId fromDictionary:dict];
            self.isDeleted = [[self objectOrNilForKey:kDataIsDeleted fromDictionary:dict] boolValue];
            self.content = [self objectOrNilForKey:kDataContent fromDictionary:dict];
            self.versionsNo = [self objectOrNilForKey:kDataVersionsNo fromDictionary:dict];
            self.addDateStr = [self objectOrNilForKey:kDataAddDateStr fromDictionary:dict];
            self.versionType = [[self objectOrNilForKey:kDataVersionType fromDictionary:dict] doubleValue];
            self.typeStr = [self objectOrNilForKey:kDataTypeStr fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.addDate forKey:kDataAddDate];
    [mutableDict setValue:self.remark forKey:kDataRemark];
    [mutableDict setValue:self.versionsURL forKey:kDataVersionsURL];
    [mutableDict setValue:self.dataIdentifier forKey:kDataId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDeleted] forKey:kDataIsDeleted];
    [mutableDict setValue:self.content forKey:kDataContent];
    [mutableDict setValue:self.versionsNo forKey:kDataVersionsNo];
    [mutableDict setValue:self.addDateStr forKey:kDataAddDateStr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.versionType] forKey:kDataVersionType];
    [mutableDict setValue:self.typeStr forKey:kDataTypeStr];

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

    self.addDate = [aDecoder decodeObjectForKey:kDataAddDate];
    self.remark = [aDecoder decodeObjectForKey:kDataRemark];
    self.versionsURL = [aDecoder decodeObjectForKey:kDataVersionsURL];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kDataId];
    self.isDeleted = [aDecoder decodeBoolForKey:kDataIsDeleted];
    self.content = [aDecoder decodeObjectForKey:kDataContent];
    self.versionsNo = [aDecoder decodeObjectForKey:kDataVersionsNo];
    self.addDateStr = [aDecoder decodeObjectForKey:kDataAddDateStr];
    self.versionType = [aDecoder decodeDoubleForKey:kDataVersionType];
    self.typeStr = [aDecoder decodeObjectForKey:kDataTypeStr];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_addDate forKey:kDataAddDate];
    [aCoder encodeObject:_remark forKey:kDataRemark];
    [aCoder encodeObject:_versionsURL forKey:kDataVersionsURL];
    [aCoder encodeObject:_dataIdentifier forKey:kDataId];
    [aCoder encodeBool:_isDeleted forKey:kDataIsDeleted];
    [aCoder encodeObject:_content forKey:kDataContent];
    [aCoder encodeObject:_versionsNo forKey:kDataVersionsNo];
    [aCoder encodeObject:_addDateStr forKey:kDataAddDateStr];
    [aCoder encodeDouble:_versionType forKey:kDataVersionType];
    [aCoder encodeObject:_typeStr forKey:kDataTypeStr];
}

- (id)copyWithZone:(NSZone *)zone
{
    UpdateVersionData *copy = [[UpdateVersionData alloc] init];
    
    if (copy) {

        copy.addDate = [self.addDate copyWithZone:zone];
        copy.remark = [self.remark copyWithZone:zone];
        copy.versionsURL = [self.versionsURL copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.isDeleted = self.isDeleted;
        copy.content = [self.content copyWithZone:zone];
        copy.versionsNo = [self.versionsNo copyWithZone:zone];
        copy.addDateStr = [self.addDateStr copyWithZone:zone];
        copy.versionType = self.versionType;
        copy.typeStr = [self.typeStr copyWithZone:zone];
    }
    
    return copy;
}


@end
