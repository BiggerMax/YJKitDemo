//
//  OS.h
//  YJKit
//
//  Created by 袁杰 on 17/1/2.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
*   操作系统信息
*/
@interface OS : NSObject
/*!
 * 获取平台
 *  @return 平台名
 */
+(NSString*)platform;
/*!
 * 获取版本号
 *  @return 版本号
 */
+(NSString*)version;
/*!
 * 获取内核版本
 *  @return 内核版本
 */
+(NSString*)Kernel;
@end
