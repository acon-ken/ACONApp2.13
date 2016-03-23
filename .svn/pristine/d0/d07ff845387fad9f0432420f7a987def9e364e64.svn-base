//
//  GetGlucoseSetData.m
//
//  Created by   on 14/12/30
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "GetGlucoseSetData.h"


#define kGetGlucoseSetDataMin  @"min"
#define kGetGlucoseSetDataAddDate  @"AddDate"
#define kGetGlucoseSetDataUserId  @"UserId"
#define kGetGlucoseSetDataMax  @"max"
#define kGetGlucoseSetDataIsDeleted  @"IsDeleted"
#define kGetGlucoseSetDataId  @"Id"


@interface GetGlucoseSetData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetGlucoseSetData

@synthesize min = _min;
@synthesize addDate = _addDate;
@synthesize userId = _userId;
@synthesize max = _max;
@synthesize isDeleted = _isDeleted;
@synthesize dataIdentifier = _dataIdentifier;


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
            self.min = [[self objectOrNilForKey:kGetGlucoseSetDataMin fromDictionary:dict] doubleValue];
            self.addDate = [self objectOrNilForKey:kGetGlucoseSetDataAddDate fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kGetGlucoseSetDataUserId fromDictionary:dict];
            self.max = [[self objectOrNilForKey:kGetGlucoseSetDataMax fromDictionary:dict] doubleValue];
            self.isDeleted = [[self objectOrNilForKey:kGetGlucoseSetDataIsDeleted fromDictionary:dict] boolValue];
            self.dataIdentifier = [self objectOrNilForKey:kGetGlucoseSetDataId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.min] forKey:kGetGlucoseSetDataMin];
    [mutableDict setValue:self.addDate forKey:kGetGlucoseSetDataAddDate];
    [mutableDict setValue:self.userId forKey:kGetGlucoseSetDataUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.max] forKey:kGetGlucoseSetDataMax];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDeleted] forKey:kGetGlucoseSetDataIsDeleted];
    [mutableDict setValue:self.dataIdentifier forKey:kGetGlucoseSetDataId];

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

    self.min = [aDecoder decodeDoubleForKey:kGetGlucoseSetDataMin];
    self.addDate = [aDecoder decodeObjectForKey:kGetGlucoseSetDataAddDate];
    self.userId = [aDecoder decodeObjectForKey:kGetGlucoseSetDataUserId];
    self.max = [aDecoder decodeDoubleForKey:kGetGlucoseSetDataMax];
    self.isDeleted = [aDecoder decodeBoolForKey:kGetGlucoseSetDataIsDeleted];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kGetGlucoseSetDataId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_min forKey:kGetGlucoseSetDataMin];
    [aCoder encodeObject:_addDate forKey:kGetGlucoseSetDataAddDate];
    [aCoder encodeObject:_userId forKey:kGetGlucoseSetDataUserId];
    [aCoder encodeDouble:_max forKey:kGetGlucoseSetDataMax];
    [aCoder encodeBool:_isDeleted forKey:kGetGlucoseSetDataIsDeleted];
    [aCoder encodeObject:_dataIdentifier forKey:kGetGlucoseSetDataId];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetGlucoseSetData *copy = [[GetGlucoseSetData alloc] init];
    
    if (copy) {

        copy.min = self.min;
        copy.addDate = [self.addDate copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.max = self.max;
        copy.isDeleted = self.isDeleted;
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
    }
    
    return copy;
}


@end
