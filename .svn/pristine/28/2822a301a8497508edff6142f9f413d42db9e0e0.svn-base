//
//  Data.h
//
//  Created by   on 15/1/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UpdateVersionData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *addDate;
@property (nonatomic, assign) id remark;
@property (nonatomic, strong) NSString *versionsURL;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, assign) BOOL isDeleted;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *versionsNo;
@property (nonatomic, assign) id addDateStr;
@property (nonatomic, assign) double versionType;
@property (nonatomic, assign) id typeStr;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
