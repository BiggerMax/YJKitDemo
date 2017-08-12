//
//  ARRAY.h
//  YJKit
//
//  Created by 袁杰 on 16/12/27.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"
/*!
 *  数组
 */
@interface ARRAY : NSObject


//+(NSInteger)indexOf:(NSArray *)array value:(id)value;
/*!
 *  查找项下标
 *  @param array    项
 *  @param  value   value
 *  @param  key key
 *  @return 下标
 */
+ (NSInteger)indexOf:(NSArray*)array value:(id)value key:(NSString*)key;

//+(BOOL)contain:(NSArray *)array value:(NSObject*)value;
/*!
 *  包含项下标
 *  @param array    项
 *  @param  value   value
 *  @param  key key
 *  @return 结果
 */
+(BOOL)contain:(NSArray *)array value:(NSObject*)value key:(NSString *)key;

//+(NSObject*)find:(NSArray *)array value:(NSObject*)value;
/*!
 *  查找项下标
 *  @param array    项
 *  @param  value   value
 *  @param  key key
 *  @return 对象
 */
+(NSObject *)find:(NSArray *)array value:(NSObject*)value key:(NSString *)key;



@end
