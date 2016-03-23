//
//  HasAboutinfomationData.m
//
//  Created by   on 14/12/17
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "HasAboutinfomationData.h"


#define kHasAboutinfomationDataUserId  @"UserId"
#define kHasAboutinfomationDataMsgId  @"MsgId"
#define kHasAboutinfomationDataPhotoUrl  @"PhotoUrl"
#define kHasAboutinfomationDataPhone  @"Phone"
#define kHasAboutinfomationDataLoginName  @"LoginName"
#define kHasAboutinfomationDataFollowId  @"FollowId"
#define kHasAboutinfomationDataUserName  @"UserName"


@interface HasAboutinfomationData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HasAboutinfomationData

@synthesize userId = _userId;
@synthesize msgId = _msgId;
@synthesize photoUrl = _photoUrl;
@synthesize phone = _phone;
@synthesize loginName = _loginName;
@synthesize followId = _followId;
@synthesize userName = _userName;


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
            self.userId = [self objectOrNilForKey:kHasAboutinfomationDataUserId fromDictionary:dict];
            self.msgId = [self objectOrNilForKey:kHasAboutinfomationDataMsgId fromDictionary:dict];
            self.photoUrl = [self objectOrNilForKey:kHasAboutinfomationDataPhotoUrl fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kHasAboutinfomationDataPhone fromDictionary:dict];
            self.loginName = [self objectOrNilForKey:kHasAboutinfomationDataLoginName fromDictionary:dict];
            self.followId = [self objectOrNilForKey:kHasAboutinfomationDataFollowId fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kHasAboutinfomationDataUserName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userId forKey:kHasAboutinfomationDataUserId];
    [mutableDict setValue:self.msgId forKey:kHasAboutinfomationDataMsgId];
    [mutableDict setValue:self.photoUrl forKey:kHasAboutinfomationDataPhotoUrl];
    [mutableDict setValue:self.phone forKey:kHasAboutinfomationDataPhone];
    [mutableDict setValue:self.loginName forKey:kHasAboutinfomationDataLoginName];
    [mutableDict setValue:self.followId forKey:kHasAboutinfomationDataFollowId];
    [mutableDict setValue:self.userName forKey:kHasAboutinfomationDataUserName];

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

    self.userId = [aDecoder decodeObjectForKey:kHasAboutinfomationDataUserId];
    self.msgId = [aDecoder decodeObjectForKey:kHasAboutinfomationDataMsgId];
    self.photoUrl = [aDecoder decodeObjectForKey:kHasAboutinfomationDataPhotoUrl];
    self.phone = [aDecoder decodeObjectForKey:kHasAboutinfomationDataPhone];
    self.loginName = [aDecoder decodeObjectForKey:kHasAboutinfomationDataLoginName];
    self.followId = [aDecoder decodeObjectForKey:kHasAboutinfomationDataFollowId];
    self.userName = [aDecoder decodeObjectForKey:kHasAboutinfomationDataUserName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userId forKey:kHasAboutinfomationDataUserId];
    [aCoder encodeObject:_msgId forKey:kHasAboutinfomationDataMsgId];
    [aCoder encodeObject:_photoUrl forKey:kHasAboutinfomationDataPhotoUrl];
    [aCoder encodeObject:_phone forKey:kHasAboutinfomationDataPhone];
    [aCoder encodeObject:_loginName forKey:kHasAboutinfomationDataLoginName];
    [aCoder encodeObject:_followId forKey:kHasAboutinfomationDataFollowId];
    [aCoder encodeObject:_userName forKey:kHasAboutinfomationDataUserName];
}

- (id)copyWithZone:(NSZone *)zone
{
    HasAboutinfomationData *copy = [[HasAboutinfomationData alloc] init];
    
    if (copy) {

        copy.userId = [self.userId copyWithZone:zone];
        copy.msgId = [self.msgId copyWithZone:zone];
        copy.photoUrl = [self.photoUrl copyWithZone:zone];
        copy.phone = [self.phone copyWithZone:zone];
        copy.loginName = [self.loginName copyWithZone:zone];
        copy.followId = [self.followId copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
    }
    
    return copy;
}


@end
