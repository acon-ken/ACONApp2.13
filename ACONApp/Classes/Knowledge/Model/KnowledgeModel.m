//
//  KnowledgeModel.m
//
//  Created by   on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "KnowledgeModel.h"
#import "KnowledgeData.h"


#define kKnowledgeModelStatus  @"status"
#define kKnowledgeModelData  @"data"
#define kKnowledgeModelMsg  @"msg"
#define kKnowledgeModelTotal  @"total"


@interface KnowledgeModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation KnowledgeModel

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
            self.status = [[self objectOrNilForKey:kKnowledgeModelStatus fromDictionary:dict] doubleValue];
    NSObject *receivedKnowledgeData = [dict objectForKey:kKnowledgeModelData];
    NSMutableArray *parsedKnowledgeData = [NSMutableArray array];
    if ([receivedKnowledgeData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedKnowledgeData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedKnowledgeData addObject:[KnowledgeData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedKnowledgeData isKindOfClass:[NSDictionary class]]) {
       [parsedKnowledgeData addObject:[KnowledgeData modelObjectWithDictionary:(NSDictionary *)receivedKnowledgeData]];
    }

    self.data = [NSArray arrayWithArray:parsedKnowledgeData];
            self.msg = [self objectOrNilForKey:kKnowledgeModelMsg fromDictionary:dict];
            self.total = [[self objectOrNilForKey:kKnowledgeModelTotal fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kKnowledgeModelStatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kKnowledgeModelData];
    [mutableDict setValue:self.msg forKey:kKnowledgeModelMsg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kKnowledgeModelTotal];

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

    self.status = [aDecoder decodeDoubleForKey:kKnowledgeModelStatus];
    self.data = [aDecoder decodeObjectForKey:kKnowledgeModelData];
    self.msg = [aDecoder decodeObjectForKey:kKnowledgeModelMsg];
    self.total = [aDecoder decodeDoubleForKey:kKnowledgeModelTotal];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kKnowledgeModelStatus];
    [aCoder encodeObject:_data forKey:kKnowledgeModelData];
    [aCoder encodeObject:_msg forKey:kKnowledgeModelMsg];
    [aCoder encodeDouble:_total forKey:kKnowledgeModelTotal];
}

- (id)copyWithZone:(NSZone *)zone
{
    KnowledgeModel *copy = [[KnowledgeModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
        copy.total = self.total;
    }
    
    return copy;
}


@end
