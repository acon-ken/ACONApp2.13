//
//  DataListInfo.m
//
//  Created by   on 14/12/9
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "DataListInfo.h"
#import "DataListModel.h"


#define kDataListInfoStatus  @"status"
#define kDataListInfoData  @"data"
#define kDataListInfoMsg  @"msg"
#define kDataListInfoTotal  @"total"


@interface DataListInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DataListInfo

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
            self.status = [[self objectOrNilForKey:kDataListInfoStatus fromDictionary:dict] doubleValue];
    NSObject *receivedData = [dict objectForKey:kDataListInfoData];
    NSMutableArray *parsedData = [NSMutableArray array];
    if ([receivedData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedData addObject:[DataListModel modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedData isKindOfClass:[NSDictionary class]]) {
       [parsedData addObject:[DataListModel modelObjectWithDictionary:(NSDictionary *)receivedData]];
    }

    self.data = [NSArray arrayWithArray:parsedData];
            self.msg = [self objectOrNilForKey:kDataListInfoMsg fromDictionary:dict];
            self.total = [[self objectOrNilForKey:kDataListInfoTotal fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kDataListInfoStatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kDataListInfoData];
    [mutableDict setValue:self.msg forKey:kDataListInfoMsg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kDataListInfoTotal];

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

    self.status = [aDecoder decodeDoubleForKey:kDataListInfoStatus];
    self.data = [aDecoder decodeObjectForKey:kDataListInfoData];
    self.msg = [aDecoder decodeObjectForKey:kDataListInfoMsg];
    self.total = [aDecoder decodeDoubleForKey:kDataListInfoTotal];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kDataListInfoStatus];
    [aCoder encodeObject:_data forKey:kDataListInfoData];
    [aCoder encodeObject:_msg forKey:kDataListInfoMsg];
    [aCoder encodeDouble:_total forKey:kDataListInfoTotal];
}

- (id)copyWithZone:(NSZone *)zone
{
    DataListInfo *copy = [[DataListInfo alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
        copy.total = self.total;
    }
    
    return copy;
}


@end
