//
//  AboutAikangData.m
//
//  Created by   on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "AboutAikangData.h"


#define kAboutAikangDataImageUrl  @"ImageUrl"
#define kAboutAikangDataAddDate  @"AddDate"
#define kAboutAikangDataFieldName  @"FieldName"
#define kAboutAikangDataAddTime  @"AddTime"
#define kAboutAikangDataInfoType  @"InfoType"
#define kAboutAikangDataId  @"Id"
#define kAboutAikangDataIsDeleted  @"IsDeleted"
#define kAboutAikangDataContent  @"Content"
#define kAboutAikangDataPageView  @"PageView"
#define kAboutAikangDataTitle  @"Title"
#define kAboutAikangDataFieldID  @"FieldID"


@interface AboutAikangData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AboutAikangData

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
            self.imageUrl = [self objectOrNilForKey:kAboutAikangDataImageUrl fromDictionary:dict];
            self.addDate = [self objectOrNilForKey:kAboutAikangDataAddDate fromDictionary:dict];
            self.fieldName = [self objectOrNilForKey:kAboutAikangDataFieldName fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kAboutAikangDataAddTime fromDictionary:dict];
            self.infoType = [self objectOrNilForKey:kAboutAikangDataInfoType fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kAboutAikangDataId fromDictionary:dict];
            self.isDeleted = [[self objectOrNilForKey:kAboutAikangDataIsDeleted fromDictionary:dict] boolValue];
            self.content = [self objectOrNilForKey:kAboutAikangDataContent fromDictionary:dict];
            self.pageView = [[self objectOrNilForKey:kAboutAikangDataPageView fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kAboutAikangDataTitle fromDictionary:dict];
            self.fieldID = [self objectOrNilForKey:kAboutAikangDataFieldID fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imageUrl forKey:kAboutAikangDataImageUrl];
    [mutableDict setValue:self.addDate forKey:kAboutAikangDataAddDate];
    [mutableDict setValue:self.fieldName forKey:kAboutAikangDataFieldName];
    [mutableDict setValue:self.addTime forKey:kAboutAikangDataAddTime];
    [mutableDict setValue:self.infoType forKey:kAboutAikangDataInfoType];
    [mutableDict setValue:self.dataIdentifier forKey:kAboutAikangDataId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDeleted] forKey:kAboutAikangDataIsDeleted];
    [mutableDict setValue:self.content forKey:kAboutAikangDataContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageView] forKey:kAboutAikangDataPageView];
    [mutableDict setValue:self.title forKey:kAboutAikangDataTitle];
    [mutableDict setValue:self.fieldID forKey:kAboutAikangDataFieldID];

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

    self.imageUrl = [aDecoder decodeObjectForKey:kAboutAikangDataImageUrl];
    self.addDate = [aDecoder decodeObjectForKey:kAboutAikangDataAddDate];
    self.fieldName = [aDecoder decodeObjectForKey:kAboutAikangDataFieldName];
    self.addTime = [aDecoder decodeObjectForKey:kAboutAikangDataAddTime];
    self.infoType = [aDecoder decodeObjectForKey:kAboutAikangDataInfoType];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kAboutAikangDataId];
    self.isDeleted = [aDecoder decodeBoolForKey:kAboutAikangDataIsDeleted];
    self.content = [aDecoder decodeObjectForKey:kAboutAikangDataContent];
    self.pageView = [aDecoder decodeDoubleForKey:kAboutAikangDataPageView];
    self.title = [aDecoder decodeObjectForKey:kAboutAikangDataTitle];
    self.fieldID = [aDecoder decodeObjectForKey:kAboutAikangDataFieldID];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imageUrl forKey:kAboutAikangDataImageUrl];
    [aCoder encodeObject:_addDate forKey:kAboutAikangDataAddDate];
    [aCoder encodeObject:_fieldName forKey:kAboutAikangDataFieldName];
    [aCoder encodeObject:_addTime forKey:kAboutAikangDataAddTime];
    [aCoder encodeObject:_infoType forKey:kAboutAikangDataInfoType];
    [aCoder encodeObject:_dataIdentifier forKey:kAboutAikangDataId];
    [aCoder encodeBool:_isDeleted forKey:kAboutAikangDataIsDeleted];
    [aCoder encodeObject:_content forKey:kAboutAikangDataContent];
    [aCoder encodeDouble:_pageView forKey:kAboutAikangDataPageView];
    [aCoder encodeObject:_title forKey:kAboutAikangDataTitle];
    [aCoder encodeObject:_fieldID forKey:kAboutAikangDataFieldID];
}

- (id)copyWithZone:(NSZone *)zone
{
    AboutAikangData *copy = [[AboutAikangData alloc] init];
    
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
