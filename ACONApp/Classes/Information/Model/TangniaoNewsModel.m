//
//  TangniaoNewsModel.m
//
//  Created by   on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "TangniaoNewsModel.h"
#import "TangniaoNewsData.h"


#define kTangniaoNewsModelStatus  @"status"
#define kTangniaoNewsModelData  @"data"
#define kTangniaoNewsModelMsg  @"msg"
#define kTangniaoNewsModelTotal  @"total"


@interface TangniaoNewsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TangniaoNewsModel

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
            self.status = [[self objectOrNilForKey:kTangniaoNewsModelStatus fromDictionary:dict] doubleValue];
    NSObject *receivedTangniaoNewsData = [dict objectForKey:kTangniaoNewsModelData];
    NSMutableArray *parsedTangniaoNewsData = [NSMutableArray array];
    if ([receivedTangniaoNewsData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTangniaoNewsData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTangniaoNewsData addObject:[TangniaoNewsData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTangniaoNewsData isKindOfClass:[NSDictionary class]]) {
       [parsedTangniaoNewsData addObject:[TangniaoNewsData modelObjectWithDictionary:(NSDictionary *)receivedTangniaoNewsData]];
    }

    self.data = [NSArray arrayWithArray:parsedTangniaoNewsData];
            self.msg = [self objectOrNilForKey:kTangniaoNewsModelMsg fromDictionary:dict];
            self.total = [[self objectOrNilForKey:kTangniaoNewsModelTotal fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kTangniaoNewsModelStatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kTangniaoNewsModelData];
    [mutableDict setValue:self.msg forKey:kTangniaoNewsModelMsg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kTangniaoNewsModelTotal];

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

    self.status = [aDecoder decodeDoubleForKey:kTangniaoNewsModelStatus];
    self.data = [aDecoder decodeObjectForKey:kTangniaoNewsModelData];
    self.msg = [aDecoder decodeObjectForKey:kTangniaoNewsModelMsg];
    self.total = [aDecoder decodeDoubleForKey:kTangniaoNewsModelTotal];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kTangniaoNewsModelStatus];
    [aCoder encodeObject:_data forKey:kTangniaoNewsModelData];
    [aCoder encodeObject:_msg forKey:kTangniaoNewsModelMsg];
    [aCoder encodeDouble:_total forKey:kTangniaoNewsModelTotal];
}

- (id)copyWithZone:(NSZone *)zone
{
    TangniaoNewsModel *copy = [[TangniaoNewsModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
        copy.total = self.total;
    }
    
    return copy;
}


@end
