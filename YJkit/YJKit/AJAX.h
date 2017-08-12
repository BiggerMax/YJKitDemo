//
//  AJAX.h
//  YJKit
//
//  Created by 袁杰 on 17/1/2.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJKit.h"
/*!
 请求方式
 */
typedef enum {
    AJAXModeGet,
    AJAXModePost,
    AJAXModePut,
    AJAXModeDelete
}AJAXMode;
/** 网络请求*/
@interface AJAX : NSObject
/*!
 *  返回响应者
 *  @param url       地址
 *  @param params    参数
 *  @param successCallback  请求完成的回调
 *  @param failureCallbck   请求失败回调
 *  @param mode      请求方式
 */
+ (void)get:(NSString *)url
                    params:(NSDictionary *)params
                  callback:(void (^)(BOOL isError,NSHTTPURLResponse* response, NSData* data))successCallback
                  callback:(void(^)(NSError *error))failureCallbck
                    mode:(AJAXMode)mode;
/*!
 *  无返回
 *  @param url       地址
 *  @param params    参数
 *  @param successCallback  请求完成的回调
 *  @param failureCallbck   请求失败回调
 *  @param mode      请求方式
 */
+ (void)getVoid:(NSString*)url
         params:(NSDictionary*)params
              successCallback:(void(^)(BOOL isError))successCallback
             failureCallbck:(void(^)(NSError *error))failureCallbck
                mode:(AJAXMode)mode;

/*!
 *  返回二进制
 *  @param url       地址
 *  @param params    参数
 *  @param successCallback  请求完成的回调
 *  @param failureCallbck   请求失败回调
 *  @param mode      请求方式
 */
+ (void)getData:(NSString*)url
         params:(NSDictionary*)params
       successCallback:(void(^)(NSData *data))successCallback
        failureCallbck:(void(^)(NSError *error))failureCallbck
           mode:(AJAXMode)mode;

/*!
 *  返回字符串
 *  @param url       地址
 *  @param params    参数
 *  @param successCallback  请求完成的回调
 *  @param failureCallbck   请求失败回调
 *  @param mode      请求方式
 */
+ (void)getString:(NSString*)url
         params:(NSDictionary*)params
successCallback:(void(^)(NSString *string))successCallback
 failureCallbck:(void(^)(NSError *error))failureCallbck
           mode:(AJAXMode)mode;
/*!
 *  返回JSON
 *  @param url       地址
 *  @param params    参数
 *  @param successCallback  请求完成的回调
 *  @param failureCallbck   请求失败回调
 *  @param mode      请求方式
 */
+ (void)getJSON:(NSString*)url
         params:(NSDictionary*)params
successCallback:(void(^)(NSDictionary* json))successCallback
 failureCallbck:(void(^)(NSError *error))failureCallbck
           mode:(AJAXMode)mode;

/*!
 *  返回图片
 *  @param url       地址
 *  @param params    参数
 *  @param successCallback  请求完成的回调
 *  @param failureCallbck   请求失败回调
 *  @param mode      请求方式
 */
+ (void)getImage:(NSString*)url
          params:(NSDictionary*)params
 successCallback:(void(^)(UIImage *image))successCallback
  failureCallbck:(void(^)(NSError *error))failureCallbck
            mode:(AJAXMode)mode;
/*!
 *  返回XML
 *  @param url       地址
 *  @param params    参数
 *  @param successCallback  请求完成的回调
 *  @param failureCallbck   请求失败回调
 *  @param mode      请求方式
 */
+ (void)getXML:(NSString*)url
          params:(NSDictionary*)params
 successCallback:(void(^)(GDataXMLDocument *xml))successCallback
  failureCallbck:(void(^)(NSError *error))failureCallbck
            mode:(AJAXMode)mode;
/*!
 *  返回base64
 *  @param url       地址
 *  @param params    参数
 *  @param successCallback  请求完成的回调
 *  @param failureCallbck   请求失败回调
 *  @param mode      请求方式
 */
+ (void)getBase64:(NSString*)url
        params:(NSDictionary*)params
  successCallback:(void(^)(NSString* base64))successCallback
   failureCallbck:(void(^)(NSError *error))failureCallbck
          mode:(AJAXMode)mode;
/*!
 *  返回比特数组
 *  @param url       地址
 *  @param params    参数
 *  @param successCallback  请求完成的回调
 *  @param failureCallbck   请求失败回调
 *
 */
+ (void)getBytes:(NSString*)url
           params:(NSDictionary*)params
  successCallback:(void(^)(Bytes* bytes))successCallback
   failureCallbck:(void(^)(NSError *error))failureCallbck
            mode:(AJAXMode)mode;
/*!
 *  返回比特数组
 *  @param url       地址
 *  @param params    参数
 *  @param successCallback  上传完成的回调
 *  @param failureCallbck   上传失败回调
 *
 */
+ (void)upload:(NSString *)url
        params:(NSDictionary *)params
          mode:(AJAXMode)mode
    successCallback:(void (^)(NSDictionary* json))successCallback
    failureCallbck:(void (^)(NSError *error))failureCallbck;


@end
