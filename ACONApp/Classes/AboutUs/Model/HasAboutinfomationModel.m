//
//  HasAboutinfomationModel.m
//
//  Created by   on 14/12/17
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "HasAboutinfomationModel.h"
#import "HasAboutinfomationData.h"


#define kHasAboutinfomationModelStatus  @"status"
#define kHasAboutinfomationModelData  @"data"
#define kHasAboutinfomationModelMsg  @"msg"


@interface HasAboutinfomationModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HasAboutinfomationModel

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
            self.status = [[self objectOrNilForKey:kHasAboutinfomationModelStatus fromDictionary:dict] doubleValue];
    NSObject *receivedHasAboutinfomationData = [dict objectForKey:kHasAboutinfomationModelData];
    NSMutableArray *parsedHasAboutinfomationData = [NSMutableArray array];
    if ([receivedHasAboutinfomationData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHasAboutinfomationData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHasAboutinfomationData addObject:[HasAboutinfomationData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHasAboutinfomationData isKindOfClass:[NSDictionary class]]) {
       [parsedHasAboutinfomationData addObject:[HasAboutinfomationData modelObjectWithDictionary:(NSDictionary *)receivedHasAboutinfomationData]];
    }

    self.data = [NSArray arrayWithArray:parsedHasAboutinfomationData];
            self.msg = [self objectOrNilForKey:kHasAboutinfomationModelMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kHasAboutinfomationModelStatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kHasAboutinfomationModelData];
    [mutableDict setValue:self.msg forKey:kHasAboutinfomationModelMsg];

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

    self.status = [aDecoder decodeDoubleForKey:kHasAboutinfomationModelStatus];
    self.data = [aDecoder decodeObjectForKey:kHasAboutinfomationModelData];
    self.msg = [aDecoder decodeObjectForKey:kHasAboutinfomationModelMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kHasAboutinfomationModelStatus];
    [aCoder encodeObject:_data forKey:kHasAboutinfomationModelData];
    [aCoder encodeObject:_msg forKey:kHasAboutinfomationModelMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    HasAboutinfomationModel *copy = [[HasAboutinfomationModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
