//
//  LBS.h
//  YJKit
//
//  Created by 袁杰 on 17/1/2.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define  CCLastLongitude @"CCLastLongitude"
#define  CCLastLatitude  @"CCLastLatitude"
/*!
 *  回调返回经纬度
 */
typedef void (^LocationBlock)(CLLocationCoordinate2D locationCorrrdinate);
/*!
 *  地理位置
 */
@interface LBS : NSObject<CLLocationManagerDelegate>
/*!
 *  获取地理位置
 *  @param  successCallback 返回地理位置信息
 *  @param  failureCallback 失败回调
 */
+(void)getLocation:(void(^)(CLLocationCoordinate2D locationCorrrdinate))successCallback failureCallback:(void(^)())failureCallback;
@end
