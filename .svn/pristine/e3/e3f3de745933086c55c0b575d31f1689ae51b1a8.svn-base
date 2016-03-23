//
//  CheckWbModel.m
//
//  Created by   on 15/4/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CheckWbModel.h"
#import "CheckWbData.h"


#define kCheckWbModelStatus  @"status"
#define kCheckWbModelData  @"data"
#define kCheckWbModelMsg  @"msg"


@interface CheckWbModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CheckWbModel

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
            self.status = [[self objectOrNilForKey:kCheckWbModelStatus fromDictionary:dict] doubleValue];
            self.data = [CheckWbData modelObjectWithDictionary:[dict objectForKey:kCheckWbModelData]];
            self.msg = [self objectOrNilForKey:kCheckWbModelMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kCheckWbModelStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kCheckWbModelData];
    [mutableDict setValue:self.msg forKey:kCheckWbModelMsg];

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

    self.status = [aDecoder decodeDoubleForKey:kCheckWbModelStatus];
    self.data = [aDecoder decodeObjectForKey:kCheckWbModelData];
    self.msg = [aDecoder decodeObjectForKey:kCheckWbModelMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kCheckWbModelStatus];
    [aCoder encodeObject:_data forKey:kCheckWbModelData];
    [aCoder encodeObject:_msg forKey:kCheckWbModelMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    CheckWbModel *copy = [[CheckWbModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
