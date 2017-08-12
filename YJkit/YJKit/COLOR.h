//
//  COLOR.h
//  YJKit
//
//  Created by 袁杰 on 17/1/21.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*!
 *  颜色转换
 */

@interface COLOR : NSObject
/*!
 *  16进制转颜色
 *
 *  @param str 16进制颜色
 *
 *  @return UIcolor
 */
+(UIColor*)fromString:(NSString*)str;
/*!
 *  颜色转16进制
 *
 *  @param color UIcolor
 *
 *  @return 字符串
 */
+(NSString*)toString:(UIColor*)color;
/*!
 *  颜色转RGB
 *
 *  @param color UIcolor
 *
 *  @return 字符串
 */

+(NSString *)toRGB:(UIColor*)color;
/*!
 *  颜色转RGBA
 *
 *  @param color UIcolor
 *
 *  @return 字符串
 */
+(NSString*)toRGBA:(UIColor*)color;
@end
