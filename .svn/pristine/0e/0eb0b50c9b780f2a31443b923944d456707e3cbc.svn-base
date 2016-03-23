//
//  checkQQModel.m
//
//  Created by   on 15/4/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "checkQQModel.h"
#import "checkQQData.h"


#define kcheckQQModelStatus  @"status"
#define kcheckQQModelData  @"data"
#define kcheckQQModelMsg  @"msg"


@interface checkQQModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation checkQQModel

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
            self.status = [[self objectOrNilForKey:kcheckQQModelStatus fromDictionary:dict] doubleValue];
            self.data = [checkQQData modelObjectWithDictionary:[dict objectForKey:kcheckQQModelData]];
            self.msg = [self objectOrNilForKey:kcheckQQModelMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kcheckQQModelStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kcheckQQModelData];
    [mutableDict setValue:self.msg forKey:kcheckQQModelMsg];

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

    self.status = [aDecoder decodeDoubleForKey:kcheckQQModelStatus];
    self.data = [aDecoder decodeObjectForKey:kcheckQQModelData];
    self.msg = [aDecoder decodeObjectForKey:kcheckQQModelMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kcheckQQModelStatus];
    [aCoder encodeObject:_data forKey:kcheckQQModelData];
    [aCoder encodeObject:_msg forKey:kcheckQQModelMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    checkQQModel *copy = [[checkQQModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
