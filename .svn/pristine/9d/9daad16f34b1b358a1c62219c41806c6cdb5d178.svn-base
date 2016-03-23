//
//  GetGlucoseSetModel.m
//
//  Created by   on 14/12/30
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "GetGlucoseSetModel.h"
#import "GetGlucoseSetData.h"


#define kGetGlucoseSetModelStatus  @"status"
#define kGetGlucoseSetModelData  @"data"
#define kGetGlucoseSetModelMsg  @"msg"


@interface GetGlucoseSetModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetGlucoseSetModel

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
            self.status = [[self objectOrNilForKey:kGetGlucoseSetModelStatus fromDictionary:dict] doubleValue];
            self.data = [GetGlucoseSetData modelObjectWithDictionary:[dict objectForKey:kGetGlucoseSetModelData]];
            self.msg = [self objectOrNilForKey:kGetGlucoseSetModelMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kGetGlucoseSetModelStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kGetGlucoseSetModelData];
    [mutableDict setValue:self.msg forKey:kGetGlucoseSetModelMsg];

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

    self.status = [aDecoder decodeDoubleForKey:kGetGlucoseSetModelStatus];
    self.data = [aDecoder decodeObjectForKey:kGetGlucoseSetModelData];
    self.msg = [aDecoder decodeObjectForKey:kGetGlucoseSetModelMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kGetGlucoseSetModelStatus];
    [aCoder encodeObject:_data forKey:kGetGlucoseSetModelData];
    [aCoder encodeObject:_msg forKey:kGetGlucoseSetModelMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetGlucoseSetModel *copy = [[GetGlucoseSetModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
