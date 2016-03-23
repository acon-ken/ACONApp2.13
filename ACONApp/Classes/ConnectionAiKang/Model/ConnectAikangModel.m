//
//  ConnectAikangModel.m
//
//  Created by   on 14/12/19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ConnectAikangModel.h"
#import "ConnectAikangData.h"


#define kConnectAikangModelStatus  @"status"
#define kConnectAikangModelData  @"data"
#define kConnectAikangModelMsg  @"msg"
#define kConnectAikangModelTotal  @"total"


@interface ConnectAikangModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ConnectAikangModel

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
            self.status = [[self objectOrNilForKey:kConnectAikangModelStatus fromDictionary:dict] doubleValue];
    NSObject *receivedConnectAikangData = [dict objectForKey:kConnectAikangModelData];
    NSMutableArray *parsedConnectAikangData = [NSMutableArray array];
    if ([receivedConnectAikangData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedConnectAikangData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedConnectAikangData addObject:[ConnectAikangData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedConnectAikangData isKindOfClass:[NSDictionary class]]) {
       [parsedConnectAikangData addObject:[ConnectAikangData modelObjectWithDictionary:(NSDictionary *)receivedConnectAikangData]];
    }

    self.data = [NSArray arrayWithArray:parsedConnectAikangData];
            self.msg = [self objectOrNilForKey:kConnectAikangModelMsg fromDictionary:dict];
            self.total = [[self objectOrNilForKey:kConnectAikangModelTotal fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kConnectAikangModelStatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kConnectAikangModelData];
    [mutableDict setValue:self.msg forKey:kConnectAikangModelMsg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kConnectAikangModelTotal];

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

    self.status = [aDecoder decodeDoubleForKey:kConnectAikangModelStatus];
    self.data = [aDecoder decodeObjectForKey:kConnectAikangModelData];
    self.msg = [aDecoder decodeObjectForKey:kConnectAikangModelMsg];
    self.total = [aDecoder decodeDoubleForKey:kConnectAikangModelTotal];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kConnectAikangModelStatus];
    [aCoder encodeObject:_data forKey:kConnectAikangModelData];
    [aCoder encodeObject:_msg forKey:kConnectAikangModelMsg];
    [aCoder encodeDouble:_total forKey:kConnectAikangModelTotal];
}

- (id)copyWithZone:(NSZone *)zone
{
    ConnectAikangModel *copy = [[ConnectAikangModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
        copy.total = self.total;
    }
    
    return copy;
}


@end
