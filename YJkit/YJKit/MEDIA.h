//
//  MEDIA.h
//  YJKit
//
//  Created by 袁杰 on 17/1/1.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*!
 *  回调返回图片
 *
 *  @param image image
 */
typedef void (^okCallback)(UIImage *image);
/*!
 *  取消回调
 */
typedef void (^cancelCallback)(void);
/*!
 *  回调返回url
 *
 *  @param path path
 */
typedef void (^VideoCallback) (NSURL *path);
/*!
 *  拍照、录像、相册
 */
@interface MEDIA : NSObject
/*!
 *  打开相机
 *  @param viewController   视图控制器
 *  @param okCallback 返回图片
 *  @param  cancelCallback  cancelCallback
 */
+(void)openCamera:(UIViewController*)viewController okCallback:(okCallback)okCallback cancelCallback:(cancelCallback)cancelCallback;
/*!
 *  打开录像
 *  @param okCallback 返回录像url
 *  @param  cancelCallback  cancelCallback
 */
+(void)openRecord:(VideoCallback)okCallback cancelCallback:(cancelCallback)cancelCallback;
/*!
 *  打开相册
 *  @param viewController   视图控制器
 *  @param okCallback 返回图片
 *  @param  cancelCallback  cancelCallback
 */
+(void)openLibrary:(UIViewController*)viewController okCallback:(okCallback)okCallback cancelCallback:(cancelCallback)cancelCallback;
@end
