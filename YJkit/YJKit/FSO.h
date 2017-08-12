//
//  FSO.h
//  YJKit
//
//  Created by 袁杰 on 17/1/1.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XML.h"
#import "Bytes.h"

/*!
 *  文件操作
 */
@interface FSO : NSObject
/*!
 *  判断文件是否在沙盒Documents目录（或Documents的子目录）下
 *
 *  @param path 文件路径
 *
 *  @return 结果
 */
+ (BOOL)isExist:(NSString*)path;
/*!
 *  删除文件
 *
 *  @param path 文件路径
 *
 *  @return 结果
 */
+ (BOOL)deleteData:(NSString *)path;

//+ (NSObject *)loadDataFromPath:(NSString *)path;
//
/*!
 *  获取文件路径
 *
 *  @param fileName 文件名
 *  @return 文件路径
 */
+ (NSString*)getPathWithFileName:(NSString*)fileName;

+(void)save:(NSString*)path object:(NSObject *)object callback:(void(^)(void))callback;
/*!
 *  加载数据
 *
 *  @param path 文件路径
 *
 *  @param  callback    返回数据
 */
+(void)loadData:(NSString*)path callback:(void(^)(NSData *data))callback;
/*!
 *  保存数据
 *
 *  @param path 文件路径
 *  @param  data 数据
 *  @param  callback   callback
 */
+(void)saveData:(NSString*)path data:(NSData *)data callback:(void(^)(void))callback;
/*!
 *  加载字符串
 *
 *  @param path 文件路径
 *
 *  @param  callback    返回字符串
 */
+(void)loadString:(NSString*)path callback:(void(^)(NSString *string))callback;
/*!
 *  保存字符串
 *
 *  @param path 文件路径
 *  @param  string 字符串
 *  @param  callback   callback
 */
+(void)saveString:(NSString*)path string:(NSString *)string callback:(void(^)(void))callback;
/*!
 *  加载JSON
 *
 *  @param path 文件路径
 *
 *  @param  callback  返回JSON对象
 */
+(void)loadJSON:(NSString*)path callback:(void(^)(NSDictionary *json))callback;
/*!
 *  保存JSON
 *
 *  @param path 文件路径
 *  @param  json JSON对象
 *  @param  callback  callback
 */
+(void)saveJSON:(NSString*)path json:(NSDictionary *)json callback:(void(^)(void))callback;
/*!
 *  加载图像
 *
 *  @param path 文件路径
 *
 *  @param  callback    返回图像
 */
+(void)loadImage:(NSString*)path callback:(void(^)(UIImage *image))callback;
/*!
 *  保存图像
 *
 *  @param path 文件路径
 *  @param image 图像
 *  @param  callback callback
 */
+(void)saveImage:(NSString*)path image:(UIImage *)image callback:(void(^)(void))callback;
/*!
 *  加载XML
 *
 *  @param path 文件路径
 *  @param  callback callback
 */
+(void)loadXML:(NSString*)path callback:(void(^)(GDataXMLDocument *xml))callback;
/*!
 *  保存XML
 *
 *  @param path 文件路径
 *  @param xml  XML
 *  @param  callback callback
 */
+(void)saveXML:(NSString*)path xml:(GDataXMLDocument *)xml callback:(void(^)(void))callback;
/*!
 *  加载bytes
 *
 *  @param path 文件路径
 *
 *  @param  callback  返回bytes
 */
+(void)loadBytes:(NSString*)path callback:(void(^)(Bytes*))callback;
/*!
 *  加载bytes
 *
 *  @param path 文件路径
 *  @param  bytes   bytes
 *  @param  callback   callback
 */
+(void)saveBytes:(NSString*)path bytes:(Bytes*)bytes callback:(void(^)(void))callback;
@end
