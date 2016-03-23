//
//  Data.m
//
//  Created by   on 14/12/26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "PieChartModel.h"


#define kDataHightVal1  @"HightVal1"
#define kDataRegularVal2  @"RegularVal2"
#define kDataLowerVal3  @"LowerVal3"
#define kDataRegularVal3  @"RegularVal3"
#define kDataRegularVal4  @"RegularVal4"
#define kDataHightValAll  @"HightValAll"
#define kDataRegularValAll  @"RegularValAll"
#define kDataLowerValAll  @"LowerValAll"
#define kDataLowerVal4  @"LowerVal4"
#define kDataHightVal2  @"HightVal2"
#define kDataLowerVal1  @"LowerVal1"
#define kDataHightVal3  @"HightVal3"
#define kDataLowerVal2  @"LowerVal2"
#define kDataHightVal4  @"HightVal4"
#define kDataRegularVal1  @"RegularVal1"


@interface PieChartModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PieChartModel

@synthesize hightVal1 = _hightVal1;
@synthesize regularVal2 = _regularVal2;
@synthesize lowerVal3 = _lowerVal3;
@synthesize regularVal3 = _regularVal3;
@synthesize regularVal4 = _regularVal4;
@synthesize hightValAll = _hightValAll;
@synthesize regularValAll = _regularValAll;
@synthesize lowerValAll = _lowerValAll;
@synthesize lowerVal4 = _lowerVal4;
@synthesize hightVal2 = _hightVal2;
@synthesize lowerVal1 = _lowerVal1;
@synthesize hightVal3 = _hightVal3;
@synthesize lowerVal2 = _lowerVal2;
@synthesize hightVal4 = _hightVal4;
@synthesize regularVal1 = _regularVal1;


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
            self.hightVal1 = [self objectOrNilForKey:kDataHightVal1 fromDictionary:dict];
            self.regularVal2 = [self objectOrNilForKey:kDataRegularVal2 fromDictionary:dict];
            self.lowerVal3 = [self objectOrNilForKey:kDataLowerVal3 fromDictionary:dict];
            self.regularVal3 = [self objectOrNilForKey:kDataRegularVal3 fromDictionary:dict];
            self.regularVal4 = [self objectOrNilForKey:kDataRegularVal4 fromDictionary:dict];
            self.hightValAll = [self objectOrNilForKey:kDataHightValAll fromDictionary:dict];
            self.regularValAll = [self objectOrNilForKey:kDataRegularValAll fromDictionary:dict];
            self.lowerValAll = [self objectOrNilForKey:kDataLowerValAll fromDictionary:dict];
            self.lowerVal4 = [self objectOrNilForKey:kDataLowerVal4 fromDictionary:dict];
            self.hightVal2 = [self objectOrNilForKey:kDataHightVal2 fromDictionary:dict];
            self.lowerVal1 = [self objectOrNilForKey:kDataLowerVal1 fromDictionary:dict];
            self.hightVal3 = [self objectOrNilForKey:kDataHightVal3 fromDictionary:dict];
            self.lowerVal2 = [self objectOrNilForKey:kDataLowerVal2 fromDictionary:dict];
            self.hightVal4 = [self objectOrNilForKey:kDataHightVal4 fromDictionary:dict];
            self.regularVal1 = [self objectOrNilForKey:kDataRegularVal1 fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.hightVal1 forKey:kDataHightVal1];
    [mutableDict setValue:self.regularVal2 forKey:kDataRegularVal2];
    [mutableDict setValue:self.lowerVal3 forKey:kDataLowerVal3];
    [mutableDict setValue:self.regularVal3 forKey:kDataRegularVal3];
    [mutableDict setValue:self.regularVal4 forKey:kDataRegularVal4];
    [mutableDict setValue:self.hightValAll forKey:kDataHightValAll];
    [mutableDict setValue:self.regularValAll forKey:kDataRegularValAll];
    [mutableDict setValue:self.lowerValAll forKey:kDataLowerValAll];
    [mutableDict setValue:self.lowerVal4 forKey:kDataLowerVal4];
    [mutableDict setValue:self.hightVal2 forKey:kDataHightVal2];
    [mutableDict setValue:self.lowerVal1 forKey:kDataLowerVal1];
    [mutableDict setValue:self.hightVal3 forKey:kDataHightVal3];
    [mutableDict setValue:self.lowerVal2 forKey:kDataLowerVal2];
    [mutableDict setValue:self.hightVal4 forKey:kDataHightVal4];
    [mutableDict setValue:self.regularVal1 forKey:kDataRegularVal1];

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

    self.hightVal1 = [aDecoder decodeObjectForKey:kDataHightVal1];
    self.regularVal2 = [aDecoder decodeObjectForKey:kDataRegularVal2];
    self.lowerVal3 = [aDecoder decodeObjectForKey:kDataLowerVal3];
    self.regularVal3 = [aDecoder decodeObjectForKey:kDataRegularVal3];
    self.regularVal4 = [aDecoder decodeObjectForKey:kDataRegularVal4];
    self.hightValAll = [aDecoder decodeObjectForKey:kDataHightValAll];
    self.regularValAll = [aDecoder decodeObjectForKey:kDataRegularValAll];
    self.lowerValAll = [aDecoder decodeObjectForKey:kDataLowerValAll];
    self.lowerVal4 = [aDecoder decodeObjectForKey:kDataLowerVal4];
    self.hightVal2 = [aDecoder decodeObjectForKey:kDataHightVal2];
    self.lowerVal1 = [aDecoder decodeObjectForKey:kDataLowerVal1];
    self.hightVal3 = [aDecoder decodeObjectForKey:kDataHightVal3];
    self.lowerVal2 = [aDecoder decodeObjectForKey:kDataLowerVal2];
    self.hightVal4 = [aDecoder decodeObjectForKey:kDataHightVal4];
    self.regularVal1 = [aDecoder decodeObjectForKey:kDataRegularVal1];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_hightVal1 forKey:kDataHightVal1];
    [aCoder encodeObject:_regularVal2 forKey:kDataRegularVal2];
    [aCoder encodeObject:_lowerVal3 forKey:kDataLowerVal3];
    [aCoder encodeObject:_regularVal3 forKey:kDataRegularVal3];
    [aCoder encodeObject:_regularVal4 forKey:kDataRegularVal4];
    [aCoder encodeObject:_hightValAll forKey:kDataHightValAll];
    [aCoder encodeObject:_regularValAll forKey:kDataRegularValAll];
    [aCoder encodeObject:_lowerValAll forKey:kDataLowerValAll];
    [aCoder encodeObject:_lowerVal4 forKey:kDataLowerVal4];
    [aCoder encodeObject:_hightVal2 forKey:kDataHightVal2];
    [aCoder encodeObject:_lowerVal1 forKey:kDataLowerVal1];
    [aCoder encodeObject:_hightVal3 forKey:kDataHightVal3];
    [aCoder encodeObject:_lowerVal2 forKey:kDataLowerVal2];
    [aCoder encodeObject:_hightVal4 forKey:kDataHightVal4];
    [aCoder encodeObject:_regularVal1 forKey:kDataRegularVal1];
}

- (id)copyWithZone:(NSZone *)zone
{
    PieChartModel *copy = [[PieChartModel alloc] init];
    
    if (copy) {

        copy.hightVal1 = [self.hightVal1 copyWithZone:zone];
        copy.regularVal2 = [self.regularVal2 copyWithZone:zone];
        copy.lowerVal3 = [self.lowerVal3 copyWithZone:zone];
        copy.regularVal3 = [self.regularVal3 copyWithZone:zone];
        copy.regularVal4 = [self.regularVal4 copyWithZone:zone];
        copy.hightValAll = [self.hightValAll copyWithZone:zone];
        copy.regularValAll = [self.regularValAll copyWithZone:zone];
        copy.lowerValAll = [self.lowerValAll copyWithZone:zone];
        copy.lowerVal4 = [self.lowerVal4 copyWithZone:zone];
        copy.hightVal2 = [self.hightVal2 copyWithZone:zone];
        copy.lowerVal1 = [self.lowerVal1 copyWithZone:zone];
        copy.hightVal3 = [self.hightVal3 copyWithZone:zone];
        copy.lowerVal2 = [self.lowerVal2 copyWithZone:zone];
        copy.hightVal4 = [self.hightVal4 copyWithZone:zone];
        copy.regularVal1 = [self.regularVal1 copyWithZone:zone];
    }
    
    return copy;
}


@end
