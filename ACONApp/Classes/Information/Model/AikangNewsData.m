//
//  AikangNewsData.m
//
//  Created by   on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "AikangNewsData.h"


#define kAikangNewsDataImageUrl  @"ImageUrl"
#define kAikangNewsDataAddDate  @"AddDate"
#define kAikangNewsDataFieldName  @"FieldName"
#define kAikangNewsDataAddTime  @"AddTime"
#define kAikangNewsDataInfoType  @"InfoType"
#define kAikangNewsDataId  @"Id"
#define kAikangNewsDataIsDeleted  @"IsDeleted"
#define kAikangNewsDataContent  @"Content"
#define kAikangNewsDataPageView  @"PageView"
#define kAikangNewsDataTitle  @"Title"
#define kAikangNewsDataFieldID  @"FieldID"


@interface AikangNewsData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AikangNewsData

@synthesize imageUrl = _imageUrl;
@synthesize addDate = _addDate;
@synthesize fieldName = _fieldName;
@synthesize addTime = _addTime;
@synthesize infoType = _infoType;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize isDeleted = _isDeleted;
@synthesize content = _content;
@synthesize pageView = _pageView;
@synthesize title = _title;
@synthesize fieldID = _fieldID;


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
            self.imageUrl = [self objectOrNilForKey:kAikangNewsDataImageUrl fromDictionary:dict];
            self.addDate = [self objectOrNilForKey:kAikangNewsDataAddDate fromDictionary:dict];
            self.fieldName = [self objectOrNilForKey:kAikangNewsDataFieldName fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kAikangNewsDataAddTime fromDictionary:dict];
            self.infoType = [self objectOrNilForKey:kAikangNewsDataInfoType fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kAikangNewsDataId fromDictionary:dict];
            self.isDeleted = [[self objectOrNilForKey:kAikangNewsDataIsDeleted fromDictionary:dict] boolValue];
            self.content = [self objectOrNilForKey:kAikangNewsDataContent fromDictionary:dict];
            self.pageView = [[self objectOrNilForKey:kAikangNewsDataPageView fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kAikangNewsDataTitle fromDictionary:dict];
            self.fieldID = [self objectOrNilForKey:kAikangNewsDataFieldID fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imageUrl forKey:kAikangNewsDataImageUrl];
    [mutableDict setValue:self.addDate forKey:kAikangNewsDataAddDate];
    [mutableDict setValue:self.fieldName forKey:kAikangNewsDataFieldName];
    [mutableDict setValue:self.addTime forKey:kAikangNewsDataAddTime];
    [mutableDict setValue:self.infoType forKey:kAikangNewsDataInfoType];
    [mutableDict setValue:self.dataIdentifier forKey:kAikangNewsDataId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDeleted] forKey:kAikangNewsDataIsDeleted];
    [mutableDict setValue:self.content forKey:kAikangNewsDataContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageView] forKey:kAikangNewsDataPageView];
    [mutableDict setValue:self.title forKey:kAikangNewsDataTitle];
    [mutableDict setValue:self.fieldID forKey:kAikangNewsDataFieldID];

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

    self.imageUrl = [aDecoder decodeObjectForKey:kAikangNewsDataImageUrl];
    self.addDate = [aDecoder decodeObjectForKey:kAikangNewsDataAddDate];
    self.fieldName = [aDecoder decodeObjectForKey:kAikangNewsDataFieldName];
    self.addTime = [aDecoder decodeObjectForKey:kAikangNewsDataAddTime];
    self.infoType = [aDecoder decodeObjectForKey:kAikangNewsDataInfoType];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kAikangNewsDataId];
    self.isDeleted = [aDecoder decodeBoolForKey:kAikangNewsDataIsDeleted];
    self.content = [aDecoder decodeObjectForKey:kAikangNewsDataContent];
    self.pageView = [aDecoder decodeDoubleForKey:kAikangNewsDataPageView];
    self.title = [aDecoder decodeObjectForKey:kAikangNewsDataTitle];
    self.fieldID = [aDecoder decodeObjectForKey:kAikangNewsDataFieldID];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imageUrl forKey:kAikangNewsDataImageUrl];
    [aCoder encodeObject:_addDate forKey:kAikangNewsDataAddDate];
    [aCoder encodeObject:_fieldName forKey:kAikangNewsDataFieldName];
    [aCoder encodeObject:_addTime forKey:kAikangNewsDataAddTime];
    [aCoder encodeObject:_infoType forKey:kAikangNewsDataInfoType];
    [aCoder encodeObject:_dataIdentifier forKey:kAikangNewsDataId];
    [aCoder encodeBool:_isDeleted forKey:kAikangNewsDataIsDeleted];
    [aCoder encodeObject:_content forKey:kAikangNewsDataContent];
    [aCoder encodeDouble:_pageView forKey:kAikangNewsDataPageView];
    [aCoder encodeObject:_title forKey:kAikangNewsDataTitle];
    [aCoder encodeObject:_fieldID forKey:kAikangNewsDataFieldID];
}

- (id)copyWithZone:(NSZone *)zone
{
    AikangNewsData *copy = [[AikangNewsData alloc] init];
    
    if (copy) {

        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.addDate = [self.addDate copyWithZone:zone];
        copy.fieldName = [self.fieldName copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.infoType = [self.infoType copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.isDeleted = self.isDeleted;
        copy.content = [self.content copyWithZone:zone];
        copy.pageView = self.pageView;
        copy.title = [self.title copyWithZone:zone];
        copy.fieldID = [self.fieldID copyWithZone:zone];
    }
    
    return copy;
}


@end
