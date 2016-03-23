//
//  ArchivePath.m
//  WisdomCommunity
//
//  Created by chunfeng on 14/11/6.
//  Copyright (c) 2014年 chunfeng. All rights reserved.
//

#import "ArchivePath.h"

@implementation ArchivePath

+ (NSString *)ArchivePath:(NSString *)str{
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentDirectory = [paths objectAtIndex:0];
    
            NSString *userPath = [documentDirectory stringByAppendingPathComponent:str];
    
    return userPath;
    //paths： ios下Document路径，Document为ios中可读写的文件夹
    //userPath： 记住密码路径，在Document中。
    
}

@end
