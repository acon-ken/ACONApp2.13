//
//  SysteminformationModel.m
//
//  Created by   on 14/12/16
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SysteminformationModel.h"
#import "SysteminformationData.h"


#define kSysteminformationModelStatus  @"status"
#define kSysteminformationModelData  @"data"
#define kSysteminformationModelMsg  @"msg"


@interface SysteminformationModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SysteminformationModel

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
            self.status = [[self objectOrNilForKey:kSysteminformationModelStatus fromDictionary:dict] doubleValue];
    NSObject *receivedSysteminformationData = [dict objectForKey:kSysteminformationModelData];
    NSMutableArray *parsedSysteminformationData = [NSMutableArray array];
    if ([receivedSysteminformationData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSysteminformationData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSysteminformationData addObject:[SysteminformationData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSysteminformationData isKindOfClass:[NSDictionary class]]) {
       [parsedSysteminformationData addObject:[SysteminformationData modelObjectWithDictionary:(NSDictionary *)receivedSysteminformationData]];
    }

    self.data = [NSArray arrayWithArray:parsedSysteminformationData];
            self.msg = [self objectOrNilForKey:kSysteminformationModelMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kSysteminformationModelStatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kSysteminformationModelData];
    [mutableDict setValue:self.msg forKey:kSysteminformationModelMsg];

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

    self.status = [aDecoder decodeDoubleForKey:kSysteminformationModelStatus];
    self.data = [aDecoder decodeObjectForKey:kSysteminformationModelData];
    self.msg = [aDecoder decodeObjectForKey:kSysteminformationModelMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kSysteminformationModelStatus];
    [aCoder encodeObject:_data forKey:kSysteminformationModelData];
    [aCoder encodeObject:_msg forKey:kSysteminformationModelMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    SysteminformationModel *copy = [[SysteminformationModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
