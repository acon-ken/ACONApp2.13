//
//  ArchivePath.h
//  WisdomCommunity
//
//  Created by chunfeng on 14/11/6.
//  Copyright (c) 2014年 chunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArchivePath : NSObject
/**
 *  拼接归档接档路径
 *
 *  @param str 归档接档文件名
 *
 *  @return 全路径
 */
+ (NSString *)ArchivePath:(NSString *)str;
@end
