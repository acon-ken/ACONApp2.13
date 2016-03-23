//
//  GetGlucoseSetData.h
//
//  Created by   on 14/12/30
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GetGlucoseSetData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double min;
@property (nonatomic, strong) NSString *addDate;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) double max;
@property (nonatomic, assign) BOOL isDeleted;
@property (nonatomic, strong) NSString *dataIdentifier;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
