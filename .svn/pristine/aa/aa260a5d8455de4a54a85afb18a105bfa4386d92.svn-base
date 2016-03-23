//
//  Data.h
//
//  Created by   on 14/12/9
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DataListModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double measureValue;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *measureTimeFormat;
@property (nonatomic, assign) id remark;
@property (nonatomic, assign) id phone;
@property (nonatomic, assign) id userName;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *addDate;
@property (nonatomic, strong) NSString *measureTime;
@property (nonatomic, assign) id result;
@property (nonatomic, strong) NSString *measureTimeT;
@property (nonatomic, assign) BOOL isDeleted;
@property (nonatomic, strong) NSString *inputType;
@property (nonatomic, strong) NSString *periodType;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
