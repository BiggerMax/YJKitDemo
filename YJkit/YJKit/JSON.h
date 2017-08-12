//
//  JSON.h
//  YJKit
//
//  Created by 袁杰 on 16/12/27.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  JSON操作
 */
@interface JSON : NSObject

/*!
 *  JSON对象反序列化
 *  @param string 字符串
 *
 *  @return JSON对象
 */

+(id)parse:(NSString *)string;

/*!
 *  JSON对象序列化
 *
 *  @param json JSON对象
 *
 *  @return 字符串
 */
+(NSString *)stringify:(id)json;
/*!
 *  查找项
 *
 *  @param jsons JSON数组
 *  @param value value
 *  @param  key key
 *  @return 对象
 */
+(NSObject *)find:(NSArray *)jsons value:(id)value key:(NSString *)key;
/*!
 *  查找项下标
 *
 *  @param jsons JSON数组
 *  @param value value
 *  @param  key key
 *  @return 下标
 */
+(NSInteger)indexOf:(NSArray *)jsons value:(id)value key:(NSString *)key;
/*!
 *  包含项
 *
 *  @param jsons JSON数组
 *  @param value value
 *  @param  key key
 *  @return 结果
 */
+(BOOL)contain:(NSArray *)jsons value:(id)value key:(NSString *)key;
@end
