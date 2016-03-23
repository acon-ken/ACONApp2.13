//
//  UserManageModel.m
//
//  Created by   on 14/12/9
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "UserManageModel.h"
#import "UserManageData.h"


#define kUserManageModelStatus  @"status"
#define kUserManageModelData  @"data"
#define kUserManageModelMsg  @"msg"


@interface UserManageModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserManageModel

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
            self.status = [[self objectOrNilForKey:kUserManageModelStatus fromDictionary:dict] doubleValue];
            self.data = [UserManageData modelObjectWithDictionary:[dict objectForKey:kUserManageModelData]];
            self.msg = [self objectOrNilForKey:kUserManageModelMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kUserManageModelStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kUserManageModelData];
    [mutableDict setValue:self.msg forKey:kUserManageModelMsg];

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

    self.status = [aDecoder decodeDoubleForKey:kUserManageModelStatus];
    self.data = [aDecoder decodeObjectForKey:kUserManageModelData];
    self.msg = [aDecoder decodeObjectForKey:kUserManageModelMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kUserManageModelStatus];
    [aCoder encodeObject:_data forKey:kUserManageModelData];
    [aCoder encodeObject:_msg forKey:kUserManageModelMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserManageModel *copy = [[UserManageModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
