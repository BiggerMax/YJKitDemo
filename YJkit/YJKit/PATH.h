//
//  PATH.h
//  YJKit
//
//  Created by 袁杰 on 16/12/27.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 *  文件路径
 */
@interface PATH : NSObject

/*!
 *  输出文件名
 *  @param path 文件路径
 *  return 文件名
 */
+(NSString*)name:(NSString *)path;

/*!
 *  输出文件夹名
 *  @param path 文件路径
 *  return 文件夹名
 */
+(NSString*)folder:(NSString *)path;

/*!
 *  输出文件扩展名名
 *  @param path 文件路径
 *  return 文件扩展名
 */
+(NSString*)ext:(NSString *)path;
@end
