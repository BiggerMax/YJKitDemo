//
//  NSString+YJKit.h
//  YJKit
//
//  Created by 袁杰 on 16/12/27.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (YJKit)
/*!
 *  判断字符串是否为空
 *
 *  @return 结果
 */
+ (BOOL)isEmpty:(NSString*)str;

/*!
 *  子字符串在父字符串中的位置(从哪里开始)
 *
 *  @param string 子字符串
 *
 *  @return 位置
 */
- (NSInteger)indexOf:(NSString *)string;

/*!
 *  子字符串在父字符串中的结束(从哪里结束)
 *
 *  @param string 子字符串
 *
 *  @return 位置
 */
-(NSInteger)lastIndexOf:(NSString *)string;
/*!
 *  判断字符串中是否包含所传入的字符串
 *
 *  @param string 字符串
 *
 *  @return 结果
 */
- (BOOL)startWith:(NSString *)string;

/*!
 *  判断字符串是否以当前传入的字符串为结束
 *
 *  @param string 字符串
 *
 *  @return 结果
 */
- (BOOL)endWith:(NSString *)string;

/*!
 *  计算字符串大小
 *
 *  @param size 大小
 *  @param font 字体大小
 *
 *  @return 返回结果
 */
- (CGSize)sizeWithSize:(CGSize)size font:(UIFont*)font;
- (NSString *)URLEncode;

- (NSString*)replace:(NSString *)target to:(NSString*)to;

- (BOOL)contains:(NSString *)string;
@end
