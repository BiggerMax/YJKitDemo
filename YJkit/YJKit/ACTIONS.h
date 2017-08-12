//
//  ACTIONS.h
//  YJKit
//
//  Created by 袁杰 on 17/1/2.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 *  操作表
 */
@interface ACTIONS : NSObject

/*!
 *  操作表
 *  @param title 标题
 *  @param actions 操作数组
 *  @param  okCallback 返回下标
 *  @param  cancelCallback cancelCallback
 */

+(void)sheet:(NSString*)title actions:(NSArray*)actions index:(void(^)(int index))okCallback cancelCallback:(void(^)())cancelCallback;
@end
