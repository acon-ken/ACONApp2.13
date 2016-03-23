//
//  Data.h
//
//  Created by HYM  on 14/12/27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LineChartInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *periodType;
@property (nonatomic, strong) NSString *measureValueFormat;
@property (nonatomic, strong) NSString *periodTypeNote;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *measureTimeFormat;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *addDate;
@property (nonatomic, strong) NSString *measureTime;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *measureTimeT;
@property (nonatomic, assign) BOOL isDeleted;
@property (nonatomic, strong) NSString *inputType;
@property (nonatomic, strong) NSString *measureValueNote;
@property (nonatomic, assign) double measureValue;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
