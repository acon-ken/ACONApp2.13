//
//  BloodGlucoseManageInfo.m
//
//  Created by   on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "BloodGlucoseManageInfo.h"
#import "BloodGlucoseManageModel.h"


#define kBloodGlucoseManageInfoStatus  @"status"
#define kBloodGlucoseManageInfoData  @"data"
#define kBloodGlucoseManageInfoMsg  @"msg"


@interface BloodGlucoseManageInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BloodGlucoseManageInfo

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
            self.status = [[self objectOrNilForKey:kBloodGlucoseManageInfoStatus fromDictionary:dict] doubleValue];
            self.data = [BloodGlucoseManageModel modelObjectWithDictionary:[dict objectForKey:kBloodGlucoseManageInfoData]];
            self.msg = [self objectOrNilForKey:kBloodGlucoseManageInfoMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kBloodGlucoseManageInfoStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kBloodGlucoseManageInfoData];
    [mutableDict setValue:self.msg forKey:kBloodGlucoseManageInfoMsg];

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

    self.status = [aDecoder decodeDoubleForKey:kBloodGlucoseManageInfoStatus];
    self.data = [aDecoder decodeObjectForKey:kBloodGlucoseManageInfoData];
    self.msg = [aDecoder decodeObjectForKey:kBloodGlucoseManageInfoMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kBloodGlucoseManageInfoStatus];
    [aCoder encodeObject:_data forKey:kBloodGlucoseManageInfoData];
    [aCoder encodeObject:_msg forKey:kBloodGlucoseManageInfoMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    BloodGlucoseManageInfo *copy = [[BloodGlucoseManageInfo alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
