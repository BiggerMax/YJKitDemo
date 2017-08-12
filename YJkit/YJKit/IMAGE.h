//
//  IMAGE.h
//  YJKit
//
//  Created by 袁杰 on 17/1/1.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*!
 *  图像处理
 */
@interface IMAGE : NSObject
/*!
 *  纯色图片
 *  @param image  图像
 *  @param  color   颜色
 *  @return 图像
 */
+(UIImage *)singgleColor:(UIImage*)image color:(UIColor*)color;
/*!
 *  裁剪图片
 *  @param image  图像
 *  @param  rect   区域
 *  @return 图像
 */
+(UIImage*)clip:(UIImage*)image rect:(CGRect)rect;
/*!
 *  图片缩放
 *  @param image  图像
 *  @param  size   尺寸
 *  @return 图像
 */
+(UIImage*)scale:(UIImage*)image size:(CGSize)size;
/*!
 *  镂空文字
 *  @param string  字符串
 *  @param  font   字体
 *  @param  size    尺寸
 *  @return 图像
 */
+(UIImage *)clearText:(NSString *)string font:(UIFont *)font size:(CGSize)size;

/*!
 *  镂空图片
 *  @param image  图像
 *  @param  color   颜色
 *  @param  size    尺寸
 *  @return 图像
 */
+(UIImage *)clearImage:(UIImage *)image color:(UIColor *)color size:(CGSize)size;
@end
