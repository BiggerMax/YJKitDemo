//
//  RES.h
//  YJKit
//
//  Created by 袁杰 on 17/1/2.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*!
 *  本地化加载
 */
@interface RES : NSObject
/*!
 *  加载本地化
 *  @param  key   键
 *  @return  返回字符串
 */
+(NSString*)loadLocalize:(NSString*)key;
/*!
 *  加载图像
 *  @param  key   键
 *  @return  返回图像
 */
+(UIImage *)loadImage:(NSString*)key;

@end
