//
//  ArchiveAccessFile.h
//  WisdomCommunity
//
//  Created by chunfeng on 14/11/10.
//  Copyright (c) 2014年 chunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArchiveAccessFile : NSObject
/**
 *  数据归档
 *
 *  @param json 归档数据
 *  @param file 归档文件名
 */
+ (void)ArchiveSuccessData:(id)json fileName:(NSString *)file;

/**
 *  数据解档
 *
 *  @param file 解档文件名
 *
 *  @return 接档数据
 */
+ (NSDictionary *)UnarchivedSuccessFileName:(NSString *)file;
/**
 *  删除归档文件
 *
 *  @param file 删除归档文件名
 */
+ (void)DeleteArchiveFileName:(NSString *)file;

@end
