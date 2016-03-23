//
//  PieChartInfo.m
//
//  Created by   on 14/12/26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "PieChartInfo.h"
#import "PieChartModel.h"


#define kPieChartInfoStatus  @"status"
#define kPieChartInfoData  @"data"
#define kPieChartInfoMsg  @"msg"


@interface PieChartInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PieChartInfo

@synthesize status = _status;
@synthesize data = _data;
@synthesize msg = _msg;


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
            self.status = [[self objectOrNilForKey:kPieChartInfoStatus fromDictionary:dict] doubleValue];
            self.data = [PieChartModel modelObjectWithDictionary:[dict objectForKey:kPieChartInfoData]];
            self.msg = [self objectOrNilForKey:kPieChartInfoMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kPieChartInfoStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kPieChartInfoData];
    [mutableDict setValue:self.msg forKey:kPieChartInfoMsg];

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

    self.status = [aDecoder decodeDoubleForKey:kPieChartInfoStatus];
    self.data = [aDecoder decodeObjectForKey:kPieChartInfoData];
    self.msg = [aDecoder decodeObjectForKey:kPieChartInfoMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kPieChartInfoStatus];
    [aCoder encodeObject:_data forKey:kPieChartInfoData];
    [aCoder encodeObject:_msg forKey:kPieChartInfoMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    PieChartInfo *copy = [[PieChartInfo alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
