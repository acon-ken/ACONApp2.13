//
//  SysteminformationData.h
//
//  Created by   on 14/12/16
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SysteminformationData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userNameSend;
@property (nonatomic, assign) double msgStatus;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *userIdSend;
@property (nonatomic, assign) BOOL isRead;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, strong) NSString *requestDate;
@property (nonatomic, strong) NSString *userIdRecive;
@property (nonatomic, strong) NSString *msgContent;
@property (nonatomic, strong) NSString *addDate;
@property (nonatomic, assign) id phoneReceive;
@property (nonatomic, assign) id pushIdRecive;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
