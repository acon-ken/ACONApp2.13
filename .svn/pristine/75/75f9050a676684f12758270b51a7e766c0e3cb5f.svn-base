//
//  OtherLoginModel.h
//
//  Created by   on 14/12/27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OtherLoginData;

@interface OtherLoginModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double status;
@property (nonatomic, strong) OtherLoginData *data;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
