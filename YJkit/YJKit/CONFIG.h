//
//  CONFIG.h
//  YJKit
//
//  Created by 袁杰 on 16/12/27.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJKit.h"
#import "GDataXMLNode.h"
#import "Bytes.h"
/*!
 *  配置
 */
@interface CONFIG : NSObject
/*!
 *  设置配置
 *
 *  @param key   key
 *  @param value value
 */
+(void)set:(NSString *)key value:(id)value;
/*!
 *  获取配置
 *
 *  @param key key
 *
 *  @return 返回value
 */
+(id)get:(NSString *)key;
/*!
 *  设置字符串
 * @param key key
 * @param value value
 */
+(void)setString:(NSString *)key value:(id)value;
/*!
 *  获取字符串
 * @param key key
 * @return 返回string
 */
+(NSString *)getString:(NSString *)key;
/*!
 *  设置图像
 * @param key key
 * @param value value
 */
+(void)setImage:(NSString *)key value:(id)value;
/*!
 *  获取图像
 * @param key key
 * @return 返回image
 */
+(UIImage *)getImage:(NSString *)key;
/*!
 *  设置JSON
 * @param key key
 * @param value value
 */
+(void)setJSON:(NSString *)key value:(id)value;
/*!
 *  获取JSON
 * @param key key
 * @return 返回JSON
 */
+(id)getJSON:(NSString *)key;
/*!
 *  设置XML
 * @param key key
 * @param value value
 */
+(void)setXML:(NSString *)key value:(id)value;
/*!
 *  获取XML
 * @param key key
 * @return 返回XML
 */
+(GDataXMLDocument *)getXML:(NSString *)key;
/*!
 *  设置数据
 * @param key key
 * @param value value
 */
+(void)setData:(NSString *)key value:(id)value;
/*!
 *  获取数据
 * @param key key
 * @return 返回data
 */
+(NSData *)getData:(NSString *)key;
/*!
 *  设置比特数组
 * @param key key
 * @param value value
 */
+(void)setBytes:(NSString*)key value:(Bytes*)value;
/*!
 *  获取比特数组
 * @param key key
 * @return 返回bytes
 */
+(Bytes*)getBytes:(NSString*)key;
@end
