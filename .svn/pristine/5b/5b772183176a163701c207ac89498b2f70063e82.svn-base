//
//  BindingModel.m
//
//  Created by   on 14/12/27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "BindingModel.h"
#import "BindingData.h"


#define kBindingModelStatus  @"status"
#define kBindingModelData  @"data"
#define kBindingModelMsg  @"msg"


@interface BindingModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BindingModel

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
            self.status = [[self objectOrNilForKey:kBindingModelStatus fromDictionary:dict] doubleValue];
            self.data = [BindingData modelObjectWithDictionary:[dict objectForKey:kBindingModelData]];
            self.msg = [self objectOrNilForKey:kBindingModelMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kBindingModelStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kBindingModelData];
    [mutableDict setValue:self.msg forKey:kBindingModelMsg];

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

    self.status = [aDecoder decodeDoubleForKey:kBindingModelStatus];
    self.data = [aDecoder decodeObjectForKey:kBindingModelData];
    self.msg = [aDecoder decodeObjectForKey:kBindingModelMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kBindingModelStatus];
    [aCoder encodeObject:_data forKey:kBindingModelData];
    [aCoder encodeObject:_msg forKey:kBindingModelMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    BindingModel *copy = [[BindingModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
