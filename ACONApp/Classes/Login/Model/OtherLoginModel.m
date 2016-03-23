//
//  OtherLoginModel.m
//
//  Created by   on 14/12/27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "OtherLoginModel.h"
#import "OtherLoginData.h"


#define kOtherLoginModelStatus  @"status"
#define kOtherLoginModelData  @"data"
#define kOtherLoginModelMsg  @"msg"


@interface OtherLoginModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OtherLoginModel

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
            self.status = [[self objectOrNilForKey:kOtherLoginModelStatus fromDictionary:dict] doubleValue];
            self.data = [OtherLoginData modelObjectWithDictionary:[dict objectForKey:kOtherLoginModelData]];
            self.msg = [self objectOrNilForKey:kOtherLoginModelMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kOtherLoginModelStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kOtherLoginModelData];
    [mutableDict setValue:self.msg forKey:kOtherLoginModelMsg];

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

    self.status = [aDecoder decodeDoubleForKey:kOtherLoginModelStatus];
    self.data = [aDecoder decodeObjectForKey:kOtherLoginModelData];
    self.msg = [aDecoder decodeObjectForKey:kOtherLoginModelMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kOtherLoginModelStatus];
    [aCoder encodeObject:_data forKey:kOtherLoginModelData];
    [aCoder encodeObject:_msg forKey:kOtherLoginModelMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    OtherLoginModel *copy = [[OtherLoginModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
