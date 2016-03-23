//
//  UpdateVersionModel.m
//
//  Created by   on 15/1/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UpdateVersionModel.h"
#import "UpdateVersionData.h"


NSString *const kUpdateVersionModelStatus = @"status";
NSString *const kUpdateVersionModelData = @"data";
NSString *const kUpdateVersionModelMsg = @"msg";


@interface UpdateVersionModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UpdateVersionModel

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
            self.status = [[self objectOrNilForKey:kUpdateVersionModelStatus fromDictionary:dict] doubleValue];
            self.data = [UpdateVersionData modelObjectWithDictionary:[dict objectForKey:kUpdateVersionModelData]];
            self.msg = [self objectOrNilForKey:kUpdateVersionModelMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kUpdateVersionModelStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kUpdateVersionModelData];
    [mutableDict setValue:self.msg forKey:kUpdateVersionModelMsg];

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

    self.status = [aDecoder decodeDoubleForKey:kUpdateVersionModelStatus];
    self.data = [aDecoder decodeObjectForKey:kUpdateVersionModelData];
    self.msg = [aDecoder decodeObjectForKey:kUpdateVersionModelMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kUpdateVersionModelStatus];
    [aCoder encodeObject:_data forKey:kUpdateVersionModelData];
    [aCoder encodeObject:_msg forKey:kUpdateVersionModelMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    UpdateVersionModel *copy = [[UpdateVersionModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
