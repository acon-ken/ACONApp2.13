//
//  KnowledgeData.h
//
//  Created by   on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface KnowledgeData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) BOOL isReply;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *addDateFormat;
@property (nonatomic, strong) NSString *addDate;
@property (nonatomic, strong) NSString *reply;
@property (nonatomic, assign) double typeName;
@property (nonatomic, assign) BOOL isDeleted;
@property (nonatomic, assign) BOOL isShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
