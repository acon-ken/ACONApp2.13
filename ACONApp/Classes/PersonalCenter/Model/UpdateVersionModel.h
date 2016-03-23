//
//  UpdateVersionModel.h
//
//  Created by   on 15/1/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UpdateVersionData;

@interface UpdateVersionModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double status;
@property (nonatomic, strong) UpdateVersionData *data;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
