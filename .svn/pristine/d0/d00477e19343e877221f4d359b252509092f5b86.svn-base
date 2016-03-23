//
//  Data.m
//
//  Created by   on 15/2/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NewestData.h"


#define kDataMeasureValue  @"MeasureValue"
#define kDataPeriodTypeNote  @"PeriodTypeNote"
#define kDataMeasureValueOld  @"MeasureValueOld"
#define kDataPeriodType  @"PeriodType"
#define kDataMeasureValueOldFormat  @"MeasureValueOldFormat"
#define kDataMeasureTime  @"MeasureTime"
#define kDataAddDate  @"AddDate"
#define kDataMeasureTimeFormat  @"MeasureTimeFormat"
#define kDataUserName  @"UserName"
#define kDataMeasureTimeT  @"MeasureTimeT"
#define kDataMeterId  @"MeterId"
#define kDataInputType  @"InputType"
#define kDataId  @"Id"
#define kDataPhone  @"Phone"
#define kDataUnit  @"Unit"
#define kDataRemark  @"Remark"
#define kDataResult  @"Result"
#define kDataMeasureValueNote  @"MeasureValueNote"
#define kDataUserId  @"UserId"
#define kDataIsDeleted  @"IsDeleted"
#define kDataMark  @"Mark"
#define kDataMeasureValueFormat  @"MeasureValueFormat"


@interface NewestData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NewestData

@synthesize measureValue = _measureValue;
@synthesize periodTypeNote = _periodTypeNote;
@synthesize measureValueOld = _measureValueOld;
@synthesize periodType = _periodType;
@synthesize measureValueOldFormat = _measureValueOldFormat;
@synthesize measureTime = _measureTime;
@synthesize addDate = _addDate;
@synthesize measureTimeFormat = _measureTimeFormat;
@synthesize userName = _userName;
@synthesize measureTimeT = _measureTimeT;
@synthesize meterId = _meterId;
@synthesize inputType = _inputType;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize phone = _phone;
@synthesize unit = _unit;
@synthesize remark = _remark;
@synthesize result = _result;
@synthesize measureValueNote = _measureValueNote;
@synthesize userId = _userId;
@synthesize isDeleted = _isDeleted;
@synthesize mark = _mark;
@synthesize measureValueFormat = _measureValueFormat;


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
            self.measureValue = [[self objectOrNilForKey:kDataMeasureValue fromDictionary:dict] doubleValue];
            self.periodTypeNote = [self objectOrNilForKey:kDataPeriodTypeNote fromDictionary:dict];
            self.measureValueOld = [[self objectOrNilForKey:kDataMeasureValueOld fromDictionary:dict] doubleValue];
            self.periodType = [self objectOrNilForKey:kDataPeriodType fromDictionary:dict];
            self.measureValueOldFormat = [self objectOrNilForKey:kDataMeasureValueOldFormat fromDictionary:dict];
            self.measureTime = [self objectOrNilForKey:kDataMeasureTime fromDictionary:dict];
            self.addDate = [self objectOrNilForKey:kDataAddDate fromDictionary:dict];
            self.measureTimeFormat = [self objectOrNilForKey:kDataMeasureTimeFormat fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kDataUserName fromDictionary:dict];
            self.measureTimeT = [self objectOrNilForKey:kDataMeasureTimeT fromDictionary:dict];
            self.meterId = [self objectOrNilForKey:kDataMeterId fromDictionary:dict];
            self.inputType = [self objectOrNilForKey:kDataInputType fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kDataId fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kDataPhone fromDictionary:dict];
            self.unit = [self objectOrNilForKey:kDataUnit fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kDataRemark fromDictionary:dict];
            self.result = [self objectOrNilForKey:kDataResult fromDictionary:dict];
            self.measureValueNote = [self objectOrNilForKey:kDataMeasureValueNote fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kDataUserId fromDictionary:dict];
            self.isDeleted = [[self objectOrNilForKey:kDataIsDeleted fromDictionary:dict] boolValue];
            self.mark = [self objectOrNilForKey:kDataMark fromDictionary:dict];
            self.measureValueFormat = [self objectOrNilForKey:kDataMeasureValueFormat fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.measureValue] forKey:kDataMeasureValue];
    [mutableDict setValue:self.periodTypeNote forKey:kDataPeriodTypeNote];
    [mutableDict setValue:[NSNumber numberWithDouble:self.measureValueOld] forKey:kDataMeasureValueOld];
    [mutableDict setValue:self.periodType forKey:kDataPeriodType];
    [mutableDict setValue:self.measureValueOldFormat forKey:kDataMeasureValueOldFormat];
    [mutableDict setValue:self.measureTime forKey:kDataMeasureTime];
    [mutableDict setValue:self.addDate forKey:kDataAddDate];
    [mutableDict setValue:self.measureTimeFormat forKey:kDataMeasureTimeFormat];
    [mutableDict setValue:self.userName forKey:kDataUserName];
    [mutableDict setValue:self.measureTimeT forKey:kDataMeasureTimeT];
    [mutableDict setValue:self.meterId forKey:kDataMeterId];
    [mutableDict setValue:self.inputType forKey:kDataInputType];
    [mutableDict setValue:self.dataIdentifier forKey:kDataId];
    [mutableDict setValue:self.phone forKey:kDataPhone];
    [mutableDict setValue:self.unit forKey:kDataUnit];
    [mutableDict setValue:self.remark forKey:kDataRemark];
    [mutableDict setValue:self.result forKey:kDataResult];
    [mutableDict setValue:self.measureValueNote forKey:kDataMeasureValueNote];
    [mutableDict setValue:self.userId forKey:kDataUserId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDeleted] forKey:kDataIsDeleted];
    [mutableDict setValue:self.mark forKey:kDataMark];
    [mutableDict setValue:self.measureValueFormat forKey:kDataMeasureValueFormat];

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

    self.measureValue = [aDecoder decodeDoubleForKey:kDataMeasureValue];
    self.periodTypeNote = [aDecoder decodeObjectForKey:kDataPeriodTypeNote];
    self.measureValueOld = [aDecoder decodeDoubleForKey:kDataMeasureValueOld];
    self.periodType = [aDecoder decodeObjectForKey:kDataPeriodType];
    self.measureValueOldFormat = [aDecoder decodeObjectForKey:kDataMeasureValueOldFormat];
    self.measureTime = [aDecoder decodeObjectForKey:kDataMeasureTime];
    self.addDate = [aDecoder decodeObjectForKey:kDataAddDate];
    self.measureTimeFormat = [aDecoder decodeObjectForKey:kDataMeasureTimeFormat];
    self.userName = [aDecoder decodeObjectForKey:kDataUserName];
    self.measureTimeT = [aDecoder decodeObjectForKey:kDataMeasureTimeT];
    self.meterId = [aDecoder decodeObjectForKey:kDataMeterId];
    self.inputType = [aDecoder decodeObjectForKey:kDataInputType];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kDataId];
    self.phone = [aDecoder decodeObjectForKey:kDataPhone];
    self.unit = [aDecoder decodeObjectForKey:kDataUnit];
    self.remark = [aDecoder decodeObjectForKey:kDataRemark];
    self.result = [aDecoder decodeObjectForKey:kDataResult];
    self.measureValueNote = [aDecoder decodeObjectForKey:kDataMeasureValueNote];
    self.userId = [aDecoder decodeObjectForKey:kDataUserId];
    self.isDeleted = [aDecoder decodeBoolForKey:kDataIsDeleted];
    self.mark = [aDecoder decodeObjectForKey:kDataMark];
    self.measureValueFormat = [aDecoder decodeObjectForKey:kDataMeasureValueFormat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_measureValue forKey:kDataMeasureValue];
    [aCoder encodeObject:_periodTypeNote forKey:kDataPeriodTypeNote];
    [aCoder encodeDouble:_measureValueOld forKey:kDataMeasureValueOld];
    [aCoder encodeObject:_periodType forKey:kDataPeriodType];
    [aCoder encodeObject:_measureValueOldFormat forKey:kDataMeasureValueOldFormat];
    [aCoder encodeObject:_measureTime forKey:kDataMeasureTime];
    [aCoder encodeObject:_addDate forKey:kDataAddDate];
    [aCoder encodeObject:_measureTimeFormat forKey:kDataMeasureTimeFormat];
    [aCoder encodeObject:_userName forKey:kDataUserName];
    [aCoder encodeObject:_measureTimeT forKey:kDataMeasureTimeT];
    [aCoder encodeObject:_meterId forKey:kDataMeterId];
    [aCoder encodeObject:_inputType forKey:kDataInputType];
    [aCoder encodeObject:_dataIdentifier forKey:kDataId];
    [aCoder encodeObject:_phone forKey:kDataPhone];
    [aCoder encodeObject:_unit forKey:kDataUnit];
    [aCoder encodeObject:_remark forKey:kDataRemark];
    [aCoder encodeObject:_result forKey:kDataResult];
    [aCoder encodeObject:_measureValueNote forKey:kDataMeasureValueNote];
    [aCoder encodeObject:_userId forKey:kDataUserId];
    [aCoder encodeBool:_isDeleted forKey:kDataIsDeleted];
    [aCoder encodeObject:_mark forKey:kDataMark];
    [aCoder encodeObject:_measureValueFormat forKey:kDataMeasureValueFormat];
}

- (id)copyWithZone:(NSZone *)zone
{
    NewestData *copy = [[NewestData alloc] init];
    
    if (copy) {

        copy.measureValue = self.measureValue;
        copy.periodTypeNote = [self.periodTypeNote copyWithZone:zone];
        copy.measureValueOld = self.measureValueOld;
        copy.periodType = [self.periodType copyWithZone:zone];
        copy.measureValueOldFormat = [self.measureValueOldFormat copyWithZone:zone];
        copy.measureTime = [self.measureTime copyWithZone:zone];
        copy.addDate = [self.addDate copyWithZone:zone];
        copy.measureTimeFormat = [self.measureTimeFormat copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.measureTimeT = [self.measureTimeT copyWithZone:zone];
        copy.meterId = [self.meterId copyWithZone:zone];
        copy.inputType = [self.inputType copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.phone = [self.phone copyWithZone:zone];
        copy.unit = [self.unit copyWithZone:zone];
        copy.remark = [self.remark copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.measureValueNote = [self.measureValueNote copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.isDeleted = self.isDeleted;
        copy.mark = [self.mark copyWithZone:zone];
        copy.measureValueFormat = [self.measureValueFormat copyWithZone:zone];
    }
    
    return copy;
}


@end
