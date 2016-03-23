//
//  AboutAikangModel.m
//
//  Created by   on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "AboutAikangModel.h"
#import "AboutAikangData.h"


#define kAboutAikangModelStatus  @"status"
#define kAboutAikangModelData  @"data"
#define kAboutAikangModelMsg  @"msg"
#define kAboutAikangModelTotal  @"total"


@interface AboutAikangModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AboutAikangModel

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
            self.status = [[self objectOrNilForKey:kAboutAikangModelStatus fromDictionary:dict] doubleValue];
    NSObject *receivedAboutAikangData = [dict objectForKey:kAboutAikangModelData];
    NSMutableArray *parsedAboutAikangData = [NSMutableArray array];
    if ([receivedAboutAikangData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedAboutAikangData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedAboutAikangData addObject:[AboutAikangData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedAboutAikangData isKindOfClass:[NSDictionary class]]) {
       [parsedAboutAikangData addObject:[AboutAikangData modelObjectWithDictionary:(NSDictionary *)receivedAboutAikangData]];
    }

    self.data = [NSArray arrayWithArray:parsedAboutAikangData];
            self.msg = [self objectOrNilForKey:kAboutAikangModelMsg fromDictionary:dict];
            self.total = [[self objectOrNilForKey:kAboutAikangModelTotal fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kAboutAikangModelStatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kAboutAikangModelData];
    [mutableDict setValue:self.msg forKey:kAboutAikangModelMsg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kAboutAikangModelTotal];

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

    self.status = [aDecoder decodeDoubleForKey:kAboutAikangModelStatus];
    self.data = [aDecoder decodeObjectForKey:kAboutAikangModelData];
    self.msg = [aDecoder decodeObjectForKey:kAboutAikangModelMsg];
    self.total = [aDecoder decodeDoubleForKey:kAboutAikangModelTotal];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kAboutAikangModelStatus];
    [aCoder encodeObject:_data forKey:kAboutAikangModelData];
    [aCoder encodeObject:_msg forKey:kAboutAikangModelMsg];
    [aCoder encodeDouble:_total forKey:kAboutAikangModelTotal];
}

- (id)copyWithZone:(NSZone *)zone
{
    AboutAikangModel *copy = [[AboutAikangModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
        copy.total = self.total;
    }
    
    return copy;
}


@end
