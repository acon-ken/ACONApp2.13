//
//  UserModel.m
//
//  Created by   on 14/12/3
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "UserModel.h"
#import "UserData.h"




#define kUserModelStatus  @"status"
#define kUserModelData  @"data"
#define kUserModelMsg  @"msg"


@interface UserModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserModel

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
            self.status = [[self objectOrNilForKey:kUserModelStatus fromDictionary:dict] doubleValue];
            self.data = [UserData modelObjectWithDictionary:[dict objectForKey:kUserModelData]];
            self.msg = [self objectOrNilForKey:kUserModelMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kUserModelStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kUserModelData];
    [mutableDict setValue:self.msg forKey:kUserModelMsg];

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

    self.status = [aDecoder decodeDoubleForKey:kUserModelStatus];
    self.data = [aDecoder decodeObjectForKey:kUserModelData];
    self.msg = [aDecoder decodeObjectForKey:kUserModelMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kUserModelStatus];
    [aCoder encodeObject:_data forKey:kUserModelData];
    [aCoder encodeObject:_msg forKey:kUserModelMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserModel *copy = [[UserModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
