//
//  ServiceTermModel.m
//
//  Created by   on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ServiceTermModel.h"
#import "ServiceTermData.h"


#define kServiceTermModelStatus  @"status"
#define kServiceTermModelData  @"data"
#define kServiceTermModelMsg  @"msg"
#define kServiceTermModelTotal  @"total"


@interface ServiceTermModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServiceTermModel

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
            self.status = [[self objectOrNilForKey:kServiceTermModelStatus fromDictionary:dict] doubleValue];
    NSObject *receivedServiceTermData = [dict objectForKey:kServiceTermModelData];
    NSMutableArray *parsedServiceTermData = [NSMutableArray array];
    if ([receivedServiceTermData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServiceTermData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServiceTermData addObject:[ServiceTermData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServiceTermData isKindOfClass:[NSDictionary class]]) {
       [parsedServiceTermData addObject:[ServiceTermData modelObjectWithDictionary:(NSDictionary *)receivedServiceTermData]];
    }

    self.data = [NSArray arrayWithArray:parsedServiceTermData];
            self.msg = [self objectOrNilForKey:kServiceTermModelMsg fromDictionary:dict];
            self.total = [[self objectOrNilForKey:kServiceTermModelTotal fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kServiceTermModelStatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kServiceTermModelData];
    [mutableDict setValue:self.msg forKey:kServiceTermModelMsg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kServiceTermModelTotal];

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

    self.status = [aDecoder decodeDoubleForKey:kServiceTermModelStatus];
    self.data = [aDecoder decodeObjectForKey:kServiceTermModelData];
    self.msg = [aDecoder decodeObjectForKey:kServiceTermModelMsg];
    self.total = [aDecoder decodeDoubleForKey:kServiceTermModelTotal];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kServiceTermModelStatus];
    [aCoder encodeObject:_data forKey:kServiceTermModelData];
    [aCoder encodeObject:_msg forKey:kServiceTermModelMsg];
    [aCoder encodeDouble:_total forKey:kServiceTermModelTotal];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServiceTermModel *copy = [[ServiceTermModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
        copy.total = self.total;
    }
    
    return copy;
}


@end
