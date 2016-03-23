//
//  LoginInfoModel.m
//
//  Created by   on 15/4/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginInfoModel.h"
#import "LoginInfoData.h"


#define kLoginInfoModelStatus  @"status"
#define kLoginInfoModelData  @"data"
#define kLoginInfoModelMsg  @"msg"


@interface LoginInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginInfoModel

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
            self.status = [[self objectOrNilForKey:kLoginInfoModelStatus fromDictionary:dict] doubleValue];
            self.data = [LoginInfoData modelObjectWithDictionary:[dict objectForKey:kLoginInfoModelData]];
            self.msg = [self objectOrNilForKey:kLoginInfoModelMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kLoginInfoModelStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kLoginInfoModelData];
    [mutableDict setValue:self.msg forKey:kLoginInfoModelMsg];

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

    self.status = [aDecoder decodeDoubleForKey:kLoginInfoModelStatus];
    self.data = [aDecoder decodeObjectForKey:kLoginInfoModelData];
    self.msg = [aDecoder decodeObjectForKey:kLoginInfoModelMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kLoginInfoModelStatus];
    [aCoder encodeObject:_data forKey:kLoginInfoModelData];
    [aCoder encodeObject:_msg forKey:kLoginInfoModelMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginInfoModel *copy = [[LoginInfoModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
