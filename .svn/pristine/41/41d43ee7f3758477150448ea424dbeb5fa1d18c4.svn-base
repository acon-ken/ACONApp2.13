//
//  SysteminformationModel.h
//
//  Created by   on 14/12/16
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SysteminformationModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
