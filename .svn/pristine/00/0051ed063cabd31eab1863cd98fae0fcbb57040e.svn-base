//
//  Data.m
//
//  Created by HYM  on 14/12/27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "LineChartInfo.h"


#define kDataPeriodType  @"PeriodType"
#define kDataMeasureValueFormat  @"MeasureValueFormat"
#define kDataPeriodTypeNote  @"PeriodTypeNote"
#define kDataId  @"Id"
#define kDataUserId  @"UserId"
#define kDataMeasureTimeFormat  @"MeasureTimeFormat"
#define kDataRemark  @"Remark"
#define kDataPhone  @"Phone"
#define kDataUserName  @"UserName"
#define kDataUnit  @"Unit"
#define kDataAddDate  @"AddDate"
#define kDataMeasureTime  @"MeasureTime"
#define kDataResult  @"Result"
#define kDataMeasureTimeT  @"MeasureTimeT"
#define kDataIsDeleted  @"IsDeleted"
#define kDataInputType  @"InputType"
#define kDataMeasureValueNote  @"MeasureValueNote"
#define kDataMeasureValue  @"MeasureValue"


@interface LineChartInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LineChartInfo

@synthesize periodType = _periodType;
@synthesize measureValueFormat = _measureValueFormat;
@synthesize periodTypeNote = _periodTypeNote;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize userId = _userId;
@synthesize measureTimeFormat = _measureTimeFormat;
@synthesize remark = _remark;
@synthesize phone = _phone;
@synthesize userName = _userName;
@synthesize unit = _unit;
@synthesize addDate = _addDate;
@synthesize measureTime = _measureTime;
@synthesize result = _result;
@synthesize measureTimeT = _measureTimeT;
@synthesize isDeleted = _isDeleted;
@synthesize inputType = _inputType;
@synthesize measureValueNote = _measureValueNote;
@synthesize measureValue = _measureValue;


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
            self.periodType = [self objectOrNilForKey:kDataPeriodType fromDictionary:dict];
            self.measureValueFormat = [self objectOrNilForKey:kDataMeasureValueFormat fromDictionary:dict];
            self.periodTypeNote = [self objectOrNilForKey:kDataPeriodTypeNote fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kDataId fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kDataUserId fromDictionary:dict];
            self.measureTimeFormat = [self objectOrNilForKey:kDataMeasureTimeFormat fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kDataRemark fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kDataPhone fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kDataUserName fromDictionary:dict];
            self.unit = [self objectOrNilForKey:kDataUnit fromDictionary:dict];
            self.addDate = [self objectOrNilForKey:kDataAddDate fromDictionary:dict];
            self.measureTime = [self objectOrNilForKey:kDataMeasureTime fromDictionary:dict];
            self.result = [self objectOrNilForKey:kDataResult fromDictionary:dict];
            self.measureTimeT = [self objectOrNilForKey:kDataMeasureTimeT fromDictionary:dict];
            self.isDeleted = [[self objectOrNilForKey:kDataIsDeleted fromDictionary:dict] boolValue];
            self.inputType = [self objectOrNilForKey:kDataInputType fromDictionary:dict];
            self.measureValueNote = [self objectOrNilForKey:kDataMeasureValueNote fromDictionary:dict];
            self.measureValue = [[self objectOrNilForKey:kDataMeasureValue fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.periodType forKey:kDataPeriodType];
    [mutableDict setValue:self.measureValueFormat forKey:kDataMeasureValueFormat];
    [mutableDict setValue:self.periodTypeNote forKey:kDataPeriodTypeNote];
    [mutableDict setValue:self.dataIdentifier forKey:kDataId];
    [mutableDict setValue:self.userId forKey:kDataUserId];
    [mutableDict setValue:self.measureTimeFormat forKey:kDataMeasureTimeFormat];
    [mutableDict setValue:self.remark forKey:kDataRemark];
    [mutableDict setValue:self.phone forKey:kDataPhone];
    [mutableDict setValue:self.userName forKey:kDataUserName];
    [mutableDict setValue:self.unit forKey:kDataUnit];
    [mutableDict setValue:self.addDate forKey:kDataAddDate];
    [mutableDict setValue:self.measureTime forKey:kDataMeasureTime];
    [mutableDict setValue:self.result forKey:kDataResult];
    [mutableDict setValue:self.measureTimeT forKey:kDataMeasureTimeT];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDeleted] forKey:kDataIsDeleted];
    [mutableDict setValue:self.inputType forKey:kDataInputType];
    [mutableDict setValue:self.measureValueNote forKey:kDataMeasureValueNote];
    [mutableDict setValue:[NSNumber numberWithDouble:self.measureValue] forKey:kDataMeasureValue];

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

    self.periodType = [aDecoder decodeObjectForKey:kDataPeriodType];
    self.measureValueFormat = [aDecoder decodeObjectForKey:kDataMeasureValueFormat];
    self.periodTypeNote = [aDecoder decodeObjectForKey:kDataPeriodTypeNote];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kDataId];
    self.userId = [aDecoder decodeObjectForKey:kDataUserId];
    self.measureTimeFormat = [aDecoder decodeObjectForKey:kDataMeasureTimeFormat];
    self.remark = [aDecoder decodeObjectForKey:kDataRemark];
    self.phone = [aDecoder decodeObjectForKey:kDataPhone];
    self.userName = [aDecoder decodeObjectForKey:kDataUserName];
    self.unit = [aDecoder decodeObjectForKey:kDataUnit];
    self.addDate = [aDecoder decodeObjectForKey:kDataAddDate];
    self.measureTime = [aDecoder decodeObjectForKey:kDataMeasureTime];
    self.result = [aDecoder decodeObjectForKey:kDataResult];
    self.measureTimeT = [aDecoder decodeObjectForKey:kDataMeasureTimeT];
    self.isDeleted = [aDecoder decodeBoolForKey:kDataIsDeleted];
    self.inputType = [aDecoder decodeObjectForKey:kDataInputType];
    self.measureValueNote = [aDecoder decodeObjectForKey:kDataMeasureValueNote];
    self.measureValue = [aDecoder decodeDoubleForKey:kDataMeasureValue];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_periodType forKey:kDataPeriodType];
    [aCoder encodeObject:_measureValueFormat forKey:kDataMeasureValueFormat];
    [aCoder encodeObject:_periodTypeNote forKey:kDataPeriodTypeNote];
    [aCoder encodeObject:_dataIdentifier forKey:kDataId];
    [aCoder encodeObject:_userId forKey:kDataUserId];
    [aCoder encodeObject:_measureTimeFormat forKey:kDataMeasureTimeFormat];
    [aCoder encodeObject:_remark forKey:kDataRemark];
    [aCoder encodeObject:_phone forKey:kDataPhone];
    [aCoder encodeObject:_userName forKey:kDataUserName];
    [aCoder encodeObject:_unit forKey:kDataUnit];
    [aCoder encodeObject:_addDate forKey:kDataAddDate];
    [aCoder encodeObject:_measureTime forKey:kDataMeasureTime];
    [aCoder encodeObject:_result forKey:kDataResult];
    [aCoder encodeObject:_measureTimeT forKey:kDataMeasureTimeT];
    [aCoder encodeBool:_isDeleted forKey:kDataIsDeleted];
    [aCoder encodeObject:_inputType forKey:kDataInputType];
    [aCoder encodeObject:_measureValueNote forKey:kDataMeasureValueNote];
    [aCoder encodeDouble:_measureValue forKey:kDataMeasureValue];
}

- (id)copyWithZone:(NSZone *)zone
{
    LineChartInfo *copy = [[LineChartInfo alloc] init];
    
    if (copy) {

        copy.periodType = [self.periodType copyWithZone:zone];
        copy.measureValueFormat = [self.measureValueFormat copyWithZone:zone];
        copy.periodTypeNote = [self.periodTypeNote copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.measureTimeFormat = [self.measureTimeFormat copyWithZone:zone];
        copy.remark = [self.remark copyWithZone:zone];
        copy.phone = [self.phone copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.unit = [self.unit copyWithZone:zone];
        copy.addDate = [self.addDate copyWithZone:zone];
        copy.measureTime = [self.measureTime copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.measureTimeT = [self.measureTimeT copyWithZone:zone];
        copy.isDeleted = self.isDeleted;
        copy.inputType = [self.inputType copyWithZone:zone];
        copy.measureValueNote = [self.measureValueNote copyWithZone:zone];
        copy.measureValue = self.measureValue;
    }
    
    return copy;
}


@end
