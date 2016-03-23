//
//  ArchiveAccessFile.m
//  WisdomCommunity
//
//  Created by chunfeng on 14/11/10.
//  Copyright (c) 2014年 chunfeng. All rights reserved.
//

#import "ArchiveAccessFile.h"
#import "ArchivePath.h"

@implementation ArchiveAccessFile

+ (void)ArchiveSuccessData:(id)json fileName:(NSString *)file{
    // 归档路径
    NSString *str = [ArchivePath ArchivePath:file];
    if ([NSKeyedArchiver archiveRootObject:json toFile:str]) {
        ZWLog(@"归档成功");
    }
}


+ (NSDictionary *)UnarchivedSuccessFileName:(NSString *)file{
    // 归档路径
    NSString *str = [ArchivePath ArchivePath:file];
    
    //判断归档文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSMutableDictionary *dict;
    if ([defaultManager isDeletableFileAtPath:str]) {
        
        dict = [NSKeyedUnarchiver unarchiveObjectWithFile:str];
        return dict;
    }
    return dict;
    
}

+ (void)DeleteArchiveFileName:(NSString *)file{
    
    // 归档路径
    NSString *str = [ArchivePath ArchivePath:file];
    
    //删除归档文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    
    if ([defaultManager isDeletableFileAtPath:str]) {
        
        [defaultManager removeItemAtPath:str error:nil];
    }

}

@end
