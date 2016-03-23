//
//  TangniaoNewsData.m
//
//  Created by   on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "TangniaoNewsData.h"


#define kTangniaoNewsDataImageUrl  @"ImageUrl"
#define kTangniaoNewsDataAddDate  @"AddDate"
#define kTangniaoNewsDataFieldName  @"FieldName"
#define kTangniaoNewsDataAddTime  @"AddTime"
#define kTangniaoNewsDataInfoType  @"InfoType"
#define kTangniaoNewsDataId  @"Id"
#define kTangniaoNewsDataIsDeleted  @"IsDeleted"
#define kTangniaoNewsDataContent  @"Content"
#define kTangniaoNewsDataPageView  @"PageView"
#define kTangniaoNewsDataTitle  @"Title"
#define kTangniaoNewsDataFieldID  @"FieldID"


@interface TangniaoNewsData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TangniaoNewsData

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
            self.imageUrl = [self objectOrNilForKey:kTangniaoNewsDataImageUrl fromDictionary:dict];
            self.addDate = [self objectOrNilForKey:kTangniaoNewsDataAddDate fromDictionary:dict];
            self.fieldName = [self objectOrNilForKey:kTangniaoNewsDataFieldName fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kTangniaoNewsDataAddTime fromDictionary:dict];
            self.infoType = [self objectOrNilForKey:kTangniaoNewsDataInfoType fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kTangniaoNewsDataId fromDictionary:dict];
            self.isDeleted = [[self objectOrNilForKey:kTangniaoNewsDataIsDeleted fromDictionary:dict] boolValue];
            self.content = [self objectOrNilForKey:kTangniaoNewsDataContent fromDictionary:dict];
            self.pageView = [[self objectOrNilForKey:kTangniaoNewsDataPageView fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kTangniaoNewsDataTitle fromDictionary:dict];
            self.fieldID = [self objectOrNilForKey:kTangniaoNewsDataFieldID fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imageUrl forKey:kTangniaoNewsDataImageUrl];
    [mutableDict setValue:self.addDate forKey:kTangniaoNewsDataAddDate];
    [mutableDict setValue:self.fieldName forKey:kTangniaoNewsDataFieldName];
    [mutableDict setValue:self.addTime forKey:kTangniaoNewsDataAddTime];
    [mutableDict setValue:self.infoType forKey:kTangniaoNewsDataInfoType];
    [mutableDict setValue:self.dataIdentifier forKey:kTangniaoNewsDataId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDeleted] forKey:kTangniaoNewsDataIsDeleted];
    [mutableDict setValue:self.content forKey:kTangniaoNewsDataContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageView] forKey:kTangniaoNewsDataPageView];
    [mutableDict setValue:self.title forKey:kTangniaoNewsDataTitle];
    [mutableDict setValue:self.fieldID forKey:kTangniaoNewsDataFieldID];

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

    self.imageUrl = [aDecoder decodeObjectForKey:kTangniaoNewsDataImageUrl];
    self.addDate = [aDecoder decodeObjectForKey:kTangniaoNewsDataAddDate];
    self.fieldName = [aDecoder decodeObjectForKey:kTangniaoNewsDataFieldName];
    self.addTime = [aDecoder decodeObjectForKey:kTangniaoNewsDataAddTime];
    self.infoType = [aDecoder decodeObjectForKey:kTangniaoNewsDataInfoType];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kTangniaoNewsDataId];
    self.isDeleted = [aDecoder decodeBoolForKey:kTangniaoNewsDataIsDeleted];
    self.content = [aDecoder decodeObjectForKey:kTangniaoNewsDataContent];
    self.pageView = [aDecoder decodeDoubleForKey:kTangniaoNewsDataPageView];
    self.title = [aDecoder decodeObjectForKey:kTangniaoNewsDataTitle];
    self.fieldID = [aDecoder decodeObjectForKey:kTangniaoNewsDataFieldID];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imageUrl forKey:kTangniaoNewsDataImageUrl];
    [aCoder encodeObject:_addDate forKey:kTangniaoNewsDataAddDate];
    [aCoder encodeObject:_fieldName forKey:kTangniaoNewsDataFieldName];
    [aCoder encodeObject:_addTime forKey:kTangniaoNewsDataAddTime];
    [aCoder encodeObject:_infoType forKey:kTangniaoNewsDataInfoType];
    [aCoder encodeObject:_dataIdentifier forKey:kTangniaoNewsDataId];
    [aCoder encodeBool:_isDeleted forKey:kTangniaoNewsDataIsDeleted];
    [aCoder encodeObject:_content forKey:kTangniaoNewsDataContent];
    [aCoder encodeDouble:_pageView forKey:kTangniaoNewsDataPageView];
    [aCoder encodeObject:_title forKey:kTangniaoNewsDataTitle];
    [aCoder encodeObject:_fieldID forKey:kTangniaoNewsDataFieldID];
}

- (id)copyWithZone:(NSZone *)zone
{
    TangniaoNewsData *copy = [[TangniaoNewsData alloc] init];
    
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
