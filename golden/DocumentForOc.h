//
//  DocumentForOc.h
//  golden
//
//  Created by 张立 on 15/5/7.
//  Copyright (c) 2015年 张立. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DocumentForOc : NSObject
- (float)fileSizeForDir:(NSString*)path;
- (void)deletefileForDir:(NSString*)path;
@end
