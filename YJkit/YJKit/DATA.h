//
//  DATA.h
//  YJKit
//
//  Created by 袁杰 on 16/12/27.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Bytes.h"
/*!
 *  数据类型转换
 */
@interface DATA : NSObject
/*!
 *  base64转bytes
 *  @param base64  大文件
 *  @param callback   返回bytes
 */
+(void)base642bytes:(NSString*)base64 callback:(void(^)(Bytes *bytes))callback;
/*!
 *  image转bytes
 *  @param image  图像
 *  @param callback   返回bytes
 */
+(void)image2bytes:(UIImage *)image callback:(void(^)(Bytes *bytes))callback;
/*!
 *  data转bytes
 *  @param data  二进制
 *  @param callback   返回bytes
 */
+(void)data2bytes:(NSData*)data callback:(void(^)(Bytes *bytes))callback;
/*!
 *  bytes转image
 *  @param bytes  bytes数组
 *  @param callback   返回图像
 */
+(void)bytes2Image:(Bytes*)bytes callback:(void(^)(UIImage *image))callback;
/*!
 *  bytes转base64
 *  @param bytes  bytes数组
 *  @param callback   返回大文件
 */
+(void)bytes2base64:(Bytes*)bytes callback:(void(^)(NSString *string))callback;
/*!
 *  bytes转data
 *  @param bytes  bytes数组
 *  @param callback   返回二进制
 */
+(void)bytes2data:(Bytes*)bytes callback:(void(^)(NSData *data))callback;
/*!
 *  base64转data
 *  @param base64  大文件
 *  @param callback   返回二进制
 */
+ (void)base642data: (NSString *)base64 callback:(void(^)(NSData *data))callback;
/*!
 *  data转base64
 *  @param data  二进制
 *  @param callback   返回大文件
 */
+(void)data2base64:(NSData *)data callback:(void(^)(NSString *string))callback;
/*!
 *  base64转image
 *  @param base64  大文件
 *  @param callback   返回图像
 */
+(void)base642Image:(NSString *)base64 callback:(void(^)(UIImage *image))callback;
/*!
 *  image转base64
 *  @param image  图像
 *  @param callback   返回大文件
 */
+(void)image2base64:(UIImage *)image callback:(void(^)(NSString *base64))callback;
/*!
 *  image转data
 *  @param image  图像
 *  @param callback   返回二进制
 */
+(void)image2data:(UIImage *)image callback:(void(^)(NSData *data))callback;
/*!
 *  data转image
 *  @param data  二进制
 *  @param callback   返回图像
 */
+(void)data2Image:(NSData *)data callback:(void(^)(UIImage *image))callback;
@end
