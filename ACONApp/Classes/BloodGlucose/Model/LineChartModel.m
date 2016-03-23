//
//  BaseClass.m
//
//  Created by HYM  on 14/12/27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "LineChartModel.h"
#import "LineChartInfo.h"


#define kBaseClassStatus  @"status"
#define kBaseClassData  @"data"
#define kBaseClassMsg  @"msg"
#define kBaseClassTotal  @"total"


@interface LineChartModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LineChartModel

@synthesize status = _status;
@synthesize data = _data;
@synthesize msg = _msg;
@synthesize total = _total;


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
            self.status = [[self objectOrNilForKey:kBaseClassStatus fromDictionary:dict] doubleValue];
    NSObject *receivedData = [dict objectForKey:kBaseClassData];
    NSMutableArray *parsedData = [NSMutableArray array];
    if ([receivedData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedData addObject:[LineChartInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedData isKindOfClass:[NSDictionary class]]) {
       [parsedData addObject:[LineChartInfo modelObjectWithDictionary:(NSDictionary *)receivedData]];
    }

    self.data = [NSArray arrayWithArray:parsedData];
            self.msg = [self objectOrNilForKey:kBaseClassMsg fromDictionary:dict];
            self.total = [[self objectOrNilForKey:kBaseClassTotal fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kBaseClassStatus];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kBaseClassData];
    [mutableDict setValue:self.msg forKey:kBaseClassMsg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kBaseClassTotal];

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

    self.status = [aDecoder decodeDoubleForKey:kBaseClassStatus];
    self.data = [aDecoder decodeObjectForKey:kBaseClassData];
    self.msg = [aDecoder decodeObjectForKey:kBaseClassMsg];
    self.total = [aDecoder decodeDoubleForKey:kBaseClassTotal];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kBaseClassStatus];
    [aCoder encodeObject:_data forKey:kBaseClassData];
    [aCoder encodeObject:_msg forKey:kBaseClassMsg];
    [aCoder encodeDouble:_total forKey:kBaseClassTotal];
}

- (id)copyWithZone:(NSZone *)zone
{
    LineChartModel *copy = [[LineChartModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
        copy.total = self.total;
    }
    
    return copy;
}


@end
