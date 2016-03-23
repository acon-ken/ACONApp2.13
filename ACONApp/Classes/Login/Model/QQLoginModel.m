//
//  QQLoginModel.m
//
//  Created by   on 15/1/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "QQLoginModel.h"
#import "QQLoginData.h"


#define kQQLoginModelStatus  @"status"
#define kQQLoginModelData  @"data"
#define kQQLoginModelMsg  @"msg"


@interface QQLoginModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QQLoginModel

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
            self.status = [[self objectOrNilForKey:kQQLoginModelStatus fromDictionary:dict] doubleValue];
            self.data = [QQLoginData modelObjectWithDictionary:[dict objectForKey:kQQLoginModelData]];
            self.msg = [self objectOrNilForKey:kQQLoginModelMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kQQLoginModelStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kQQLoginModelData];
    [mutableDict setValue:self.msg forKey:kQQLoginModelMsg];

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

    self.status = [aDecoder decodeDoubleForKey:kQQLoginModelStatus];
    self.data = [aDecoder decodeObjectForKey:kQQLoginModelData];
    self.msg = [aDecoder decodeObjectForKey:kQQLoginModelMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kQQLoginModelStatus];
    [aCoder encodeObject:_data forKey:kQQLoginModelData];
    [aCoder encodeObject:_msg forKey:kQQLoginModelMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    QQLoginModel *copy = [[QQLoginModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
