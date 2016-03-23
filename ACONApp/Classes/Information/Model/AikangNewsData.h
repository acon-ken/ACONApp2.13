//
//  AikangNewsData.h
//
//  Created by   on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AikangNewsData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *addDate;
@property (nonatomic, assign) id fieldName;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *infoType;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, assign) BOOL isDeleted;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) double pageView;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *fieldID;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
