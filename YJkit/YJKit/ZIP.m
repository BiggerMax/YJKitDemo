//
//  ZIP.m
//  YJKit
//
//  Created by 袁杰 on 16/12/27.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import "ZIP.h"

@implementation ZIP

+(void)zip:(NSDictionary *)files
    successCallBack:(void (^)(NSFileManager *))SuccessCallBack failureCallBack:(void (^)(NSError *))FailureCallBack{
    
}

+(void)unzip:(NSData *)data
    succsessCallBack:(void (^)(NSDictionary *))SuccessCallBack failureCallBack:(void (^)(NSError *))FailureCallBack{
    
}
+ (void)zip:(NSString*)zip folder:(NSString*)folder
{
    //[SSZipArchive createZipFileAtPath:zip withContentsOfDirectory:folder];
}
+ (void)unzip:(NSString*)zip folder:(NSString*)folder
{
    //[SSZipArchive unzipFileAtPath:zip toDestination:folder];
}
@end
