//
//  UploadImage.h
//  golden
//
//  Created by 张立 on 15/5/5.
//  Copyright (c) 2015年 张立. All rights reserved.
//

#import <UIkit/UIkit.h>
#import <AFNetworking/AFNetworking.h>
@interface UploadImage : NSObject
-(void)uploadPhoto:(UIImage*)image RequestUrl:(NSString *)url  UserId:(NSString *)userId;
@end