//
//  ConnectAikangData.h
//
//  Created by   on 14/12/19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ConnectAikangData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *addDate;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) BOOL isDeleted;
@property (nonatomic, assign) id addDateStr;
@property (nonatomic, strong) NSString *suppName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
