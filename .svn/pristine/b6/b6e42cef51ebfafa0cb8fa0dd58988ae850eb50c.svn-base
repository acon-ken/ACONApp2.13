//
//  ServiceTermData.m
//
//  Created by   on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ServiceTermData.h"


#define kServiceTermDataImageUrl  @"ImageUrl"
#define kServiceTermDataAddDate  @"AddDate"
#define kServiceTermDataFieldName  @"FieldName"
#define kServiceTermDataAddTime  @"AddTime"
#define kServiceTermDataInfoType  @"InfoType"
#define kServiceTermDataId  @"Id"
#define kServiceTermDataIsDeleted  @"IsDeleted"
#define kServiceTermDataContent  @"Content"
#define kServiceTermDataPageView  @"PageView"
#define kServiceTermDataTitle  @"Title"
#define kServiceTermDataFieldID  @"FieldID"


@interface ServiceTermData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServiceTermData

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
            self.imageUrl = [self objectOrNilForKey:kServiceTermDataImageUrl fromDictionary:dict];
            self.addDate = [self objectOrNilForKey:kServiceTermDataAddDate fromDictionary:dict];
            self.fieldName = [self objectOrNilForKey:kServiceTermDataFieldName fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kServiceTermDataAddTime fromDictionary:dict];
            self.infoType = [self objectOrNilForKey:kServiceTermDataInfoType fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kServiceTermDataId fromDictionary:dict];
            self.isDeleted = [[self objectOrNilForKey:kServiceTermDataIsDeleted fromDictionary:dict] boolValue];
            self.content = [self objectOrNilForKey:kServiceTermDataContent fromDictionary:dict];
            self.pageView = [[self objectOrNilForKey:kServiceTermDataPageView fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kServiceTermDataTitle fromDictionary:dict];
            self.fieldID = [self objectOrNilForKey:kServiceTermDataFieldID fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imageUrl forKey:kServiceTermDataImageUrl];
    [mutableDict setValue:self.addDate forKey:kServiceTermDataAddDate];
    [mutableDict setValue:self.fieldName forKey:kServiceTermDataFieldName];
    [mutableDict setValue:self.addTime forKey:kServiceTermDataAddTime];
    [mutableDict setValue:self.infoType forKey:kServiceTermDataInfoType];
    [mutableDict setValue:self.dataIdentifier forKey:kServiceTermDataId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDeleted] forKey:kServiceTermDataIsDeleted];
    [mutableDict setValue:self.content forKey:kServiceTermDataContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageView] forKey:kServiceTermDataPageView];
    [mutableDict setValue:self.title forKey:kServiceTermDataTitle];
    [mutableDict setValue:self.fieldID forKey:kServiceTermDataFieldID];

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

    self.imageUrl = [aDecoder decodeObjectForKey:kServiceTermDataImageUrl];
    self.addDate = [aDecoder decodeObjectForKey:kServiceTermDataAddDate];
    self.fieldName = [aDecoder decodeObjectForKey:kServiceTermDataFieldName];
    self.addTime = [aDecoder decodeObjectForKey:kServiceTermDataAddTime];
    self.infoType = [aDecoder decodeObjectForKey:kServiceTermDataInfoType];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kServiceTermDataId];
    self.isDeleted = [aDecoder decodeBoolForKey:kServiceTermDataIsDeleted];
    self.content = [aDecoder decodeObjectForKey:kServiceTermDataContent];
    self.pageView = [aDecoder decodeDoubleForKey:kServiceTermDataPageView];
    self.title = [aDecoder decodeObjectForKey:kServiceTermDataTitle];
    self.fieldID = [aDecoder decodeObjectForKey:kServiceTermDataFieldID];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imageUrl forKey:kServiceTermDataImageUrl];
    [aCoder encodeObject:_addDate forKey:kServiceTermDataAddDate];
    [aCoder encodeObject:_fieldName forKey:kServiceTermDataFieldName];
    [aCoder encodeObject:_addTime forKey:kServiceTermDataAddTime];
    [aCoder encodeObject:_infoType forKey:kServiceTermDataInfoType];
    [aCoder encodeObject:_dataIdentifier forKey:kServiceTermDataId];
    [aCoder encodeBool:_isDeleted forKey:kServiceTermDataIsDeleted];
    [aCoder encodeObject:_content forKey:kServiceTermDataContent];
    [aCoder encodeDouble:_pageView forKey:kServiceTermDataPageView];
    [aCoder encodeObject:_title forKey:kServiceTermDataTitle];
    [aCoder encodeObject:_fieldID forKey:kServiceTermDataFieldID];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServiceTermData *copy = [[ServiceTermData alloc] init];
    
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
