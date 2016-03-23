//
//  SearchUserModel.m
//
//  Created by   on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SearchUserModel.h"
#import "SearchUserData.h"


#define kSearchUserModelStatus  @"status"
#define kSearchUserModelData  @"data"
#define kSearchUserModelMsg  @"msg"


@interface SearchUserModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SearchUserModel

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
            self.status = [[self objectOrNilForKey:kSearchUserModelStatus fromDictionary:dict] doubleValue];
    NSObject *receivedSearchUserData = [dict objectForKey:kSearchUserModelData];
    NSMutableArray *parsedSearchUserData = [NSMutableArray array];
    if ([receivedSearchUserData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSearchUserData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSearchUserData addObject:[SearchUserData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSearchUserData isKindOfClass:[NSDictionary class]]) {
       [parsedSearchUserData addObject:[SearchUserData modelObjectWithDictionary:(NSDictionary *)receivedSearchUserData]];
    }

    self.data = [NSArray arrayWithArray:parsedSearchUserData];
            self.msg = [self objectOrNilForKey:kSearchUserModelMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kSearchUserModelStatus];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kSearchUserModelData];
    [mutableDict setValue:self.msg forKey:kSearchUserModelMsg];

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

    self.status = [aDecoder decodeDoubleForKey:kSearchUserModelStatus];
    self.data = [aDecoder decodeObjectForKey:kSearchUserModelData];
    self.msg = [aDecoder decodeObjectForKey:kSearchUserModelMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kSearchUserModelStatus];
    [aCoder encodeObject:_data forKey:kSearchUserModelData];
    [aCoder encodeObject:_msg forKey:kSearchUserModelMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    SearchUserModel *copy = [[SearchUserModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
