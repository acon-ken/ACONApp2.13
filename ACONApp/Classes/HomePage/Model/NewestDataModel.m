//
//  BaseClass.m
//
//  Created by   on 15/2/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NewestDataModel.h"
#import "NewestData.h"


#define kBaseClassStatus  @"status"
#define kBaseClassMsg  @"msg"
#define kBaseClassData  @"data"


@interface NewestDataModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NewestDataModel

@synthesize status = _status;
@synthesize msg = _msg;
@synthesize data = _data;


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
            self.msg = [self objectOrNilForKey:kBaseClassMsg fromDictionary:dict];
            self.data = [NewestData modelObjectWithDictionary:[dict objectForKey:kBaseClassData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kBaseClassStatus];
    [mutableDict setValue:self.msg forKey:kBaseClassMsg];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kBaseClassData];

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
    self.msg = [aDecoder decodeObjectForKey:kBaseClassMsg];
    self.data = [aDecoder decodeObjectForKey:kBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kBaseClassStatus];
    [aCoder encodeObject:_msg forKey:kBaseClassMsg];
    [aCoder encodeObject:_data forKey:kBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    NewestDataModel *copy = [[NewestDataModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.msg = [self.msg copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
