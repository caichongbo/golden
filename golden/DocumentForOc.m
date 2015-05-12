//
//  DocumentForOc.m
//  golden
//
//  Created by 张立 on 15/5/7.
//  Copyright (c) 2015年 张立. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DocumentForOc.h"
@implementation DocumentForOc : NSObject
//计算沙盒中下图片文件的总大小
- (float)fileSizeForDir:(NSString*)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float size =0;
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            if ([fullPath hasSuffix:@"png"]||[fullPath hasSuffix:@"jpg"]) {
                NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
                size+= fileAttributeDic.fileSize/ 1024.0/1024.0;
            }
        }
        else
        {
            [self fileSizeForDir:fullPath];
        }
    }
    return size;
}

//删除沙盒中的图片资源
- (void)deletefileForDir:(NSString*)path{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {   //计算图片所有图片大小
            if ([fullPath hasSuffix:@"png"]||[fullPath hasSuffix:@"jpg"]) {
                [fileManager removeItemAtPath:fullPath error:nil];
            }
        }
    }
}
@end