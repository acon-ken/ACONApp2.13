//
//  BaseClass.h
//
//  Created by HYM  on 14/12/27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LineChartModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, assign) double total;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
