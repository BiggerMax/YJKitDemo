//
//  ZIP.h
//  YJKit
//
//  Created by 袁杰 on 16/12/27.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SSZipArchive.h"
/*!
 *  文件压缩
 */
@interface ZIP : NSObject
/*!
 *  压缩
 *  @param  zip 文件路径
 *  @param  folder  沙盒路径
 */
+ (void)zip:(NSString*)zip folder:(NSString*)folder;
/*!
 *  解压
 *  @param  zip 文件路径
 *  @param  folder  沙盒路径
 */
+ (void)unzip:(NSString*)zip folder:(NSString*)folder;
///*!
// *  文件压缩
// *  @param SuccessCallBack  成功返回(压缩包)
// *  @param FailureCallBack 失败返回(错误信息)
// */
//+(void)zip:(NSDictionary *)files
//        successCallBack:(void(^)(NSFileManager *zip))SuccessCallBack
//        failureCallBack:(void(^)(NSError *error))
//            FailureCallBack;
//
///*!
// *  文件解压
// *  @param data 压缩包
// *  @param SuccessCallBack  成功返回(数据字典)
// *  @param FailureCallBack 失败返回(错误信息)
// */
//+(void)unzip:(NSData *)data
//        succsessCallBack:(void(^)(NSDictionary*dic))            SuccessCallBack
//            failureCallBack:(void(^)(NSError *error))
//                FailureCallBack;
//

@end
