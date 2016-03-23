//
//  Data.h
//
//  Created by   on 15/2/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NewestData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double measureValue;
@property (nonatomic, assign) id periodTypeNote;
@property (nonatomic, assign) double measureValueOld;
@property (nonatomic, assign) id periodType;
@property (nonatomic, strong) NSString *measureValueOldFormat;
@property (nonatomic, strong) NSString *measureTime;
@property (nonatomic, strong) NSString *addDate;
@property (nonatomic, strong) NSString *measureTimeFormat;
@property (nonatomic, assign) id userName;
@property (nonatomic, assign) id measureTimeT;
@property (nonatomic, assign) id meterId;
@property (nonatomic, assign) id inputType;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, assign) id phone;
@property (nonatomic, assign) id unit;
@property (nonatomic, assign) id remark;
@property (nonatomic, assign) id result;
@property (nonatomic, assign) id measureValueNote;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) BOOL isDeleted;
@property (nonatomic, strong) NSString *mark;
@property (nonatomic, strong) NSString *measureValueFormat;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
