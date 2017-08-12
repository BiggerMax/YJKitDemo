//
//  STRING.h
//  YJKit
//
//  Created by 袁杰 on 16/12/27.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*!
 *  字符串
 */
@interface STRING : NSObject

/*!
 *  判断是否为空
 *
 *  @param str 字符串
 *
 *  @return 判断结果
 */
+ (BOOL)isEmpty:(NSString*)str;


/*!
 * 输出子串首个位置的下标
 *  @param string       字符串
 *  @param str 字串
 *  @return 下标
 */
+(NSInteger)indexOf:(NSString*)string str:(NSString*)str;

/*!
 * 输出子串尾个位置的下标
 *  @param string       字符串
 *  @param str 字串
 *  @return 下标
 */
+(NSInteger)lastIndexOf:(NSString *)string str:(NSString*)str;

/*!
 *  判断是否开始于子串
 *  @param string  字符串
 *  @param str 字串
 *  @return 结果
 */
+(BOOL)startWith:(NSString *)string str:(NSString*)str;

/*!
 *  判断是否开始于子串
 *  @param string   字符串
 *  @param str 字串
 *  @return 结果
 */
+(BOOL)endWith:(NSString *)string str:(NSString*)str;

/*!
 *  首字母大写
 *  @param string  字符串
 *
 *  @return 字符串
 */
+(NSString *)firstUpper:(NSString*)string;

/*!
 *  字符串占领尺寸
 *  @param  string  字符串
 *  @param  fontSize    字体大小
 *  @return 尺寸
 */
+(CGSize)size:(NSString *)string fontSize:(CGFloat)fontSize;

@end
