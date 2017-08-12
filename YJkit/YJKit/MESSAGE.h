//
//  MESSAGE.h
//  YJKit
//
//  Created by 袁杰 on 17/1/21.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  消息
 */
@interface MESSAGE : NSObject
/*!
 *  发送消息
 *
 *  @param message 消息名称
 *  @param  params  参数字典
 *  @parma targer   对象
 */
+ (void)send:(NSString*)message params:(NSDictionary*)params target:(id)target;
/*!
 *  接受消息
 *
 *  @param message  消息名称
 *  @param callback 返回参数字典
 *  @param  target  对象
 */

+ (void)receive:(NSString*)message callback:(void (^)(NSDictionary* params))callback target:(id)target;
@end
