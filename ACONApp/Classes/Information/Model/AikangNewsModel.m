//
//  AikangNewsModel.m
//
//  Created by   on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "AikangNewsModel.h"
#import "AikangNewsData.h"


#define kAikangNewsModelStatus  @"status"
#define kAikangNewsModelData  @"data"
#define kAikangNewsModelMsg  @"msg"
#define kAikangNewsModelTotal  @"total"


@interface AikangNewsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AikangNewsModel

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
            self.status = [[self objectOrNilForKey:kAikangNewsModelStatus fromDictionary:dict] doubleValue];
    NSObject *receivedAikangNewsData = [dict objectForKey:kAikangNewsModelData];
    NSMutableArray *parsedAikangNewsData = [NSMutableArray array];
    if ([receivedAikangNewsData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedAikangNewsData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedAikangNewsData addObject:[AikangNewsData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedAikangNewsData isKindOfClass:[NSDictionary class]]) {
       [parsedAikangNewsData addObject:[AikangNewsData modelObjectWithDictionary:(NSDictionary *)receivedAikangNewsData]];
    }

    self.data = [NSArray arrayWithArray:parsedAikangNewsData];
            self.msg = [self objectOrNilForKey:kAikangNewsModelMsg fromDictionary:dict];
            self.total = [[self objectOrNilForKey:kAikangNewsModelTotal fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kAikangNewsModelStatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kAikangNewsModelData];
    [mutableDict setValue:self.msg forKey:kAikangNewsModelMsg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kAikangNewsModelTotal];

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

    self.status = [aDecoder decodeDoubleForKey:kAikangNewsModelStatus];
    self.data = [aDecoder decodeObjectForKey:kAikangNewsModelData];
    self.msg = [aDecoder decodeObjectForKey:kAikangNewsModelMsg];
    self.total = [aDecoder decodeDoubleForKey:kAikangNewsModelTotal];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kAikangNewsModelStatus];
    [aCoder encodeObject:_data forKey:kAikangNewsModelData];
    [aCoder encodeObject:_msg forKey:kAikangNewsModelMsg];
    [aCoder encodeDouble:_total forKey:kAikangNewsModelTotal];
}

- (id)copyWithZone:(NSZone *)zone
{
    AikangNewsModel *copy = [[AikangNewsModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
        copy.total = self.total;
    }
    
    return copy;
}


@end
