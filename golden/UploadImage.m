//
//  UploadImage.m
//  golden
//
//  Created by 张立 on 15/5/5.
//  Copyright (c) 2015年 张立. All rights reserved.
//


#import "UploadImage.h"

@implementation UploadImage : NSObject 

//图片上传
-(void)uploadPhoto:(UIImage*)image RequestUrl:(NSString *)url UserId:(NSString *)userId{
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *URL = url;
    NSMutableURLRequest *request =[[AFHTTPRequestSerializer serializer]
                                   multipartFormRequestWithMethod:@"POST"
                                   URLString:URL
                                   parameters:@{@"fileName":@"xxxx.png"}
                                   constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                   {
                                       [formData appendPartWithFileData:imageData
                                                                   name:@"file"
                                                               fileName:@"fileName"
                                                               mimeType:@"image/png"];
                                   }
                                   error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//接收text/pain形式的返回值
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
        else {
            NSLog(@"%@", responseObject);
        }
    }];
    [uploadTask resume];
}
@end