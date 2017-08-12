//
//  APP.h
//  YJKit
//
//  Created by ZhangJin on 2016/12/27.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <SafariServices/SafariServices.h>
/*!
 *  本程序
 */
@interface APP : NSObject
/*!
 *  返回appID
 */
+ (NSString*)getID;
/*!
 *  打开链接
 *  @param url 地址
 */
+ (BOOL)goUrl:(NSString*)url;
/*!
 *  打电话
 *  @param number 电话号码
 */
+ (BOOL)goPhone:(NSString*)number;
/*!
 *  发送短信
 *  @param message 短信内容
 *  @param number 电话号码
 */
+ (BOOL)goSMS:(NSString*)message
       number:(NSString*)number;
/*!
 *  发送邮件
 *  @param email 邮箱
 *  @param subject 主题
 *  @param body  正文
 */
+(BOOL)goMail:(NSString *)email
        subject:(NSString*)subject
         body:(NSString*)body;
/*!
 *  打开浏览器
 *  @param url  地址
 *  @param viewController viewController
 */
+(BOOL)openUrl:(NSString *)url viewController:(UIViewController<SFSafariViewControllerDelegate> *)viewController;
/*!
 *  打开电话
 *  @param number 号码
 */
+(BOOL)openPhone:(NSString*)number;
/*!
 *  打开短信
 *  @param sms  内容
 *  @param number 号码
 *  @param viewController viewController
 */
+(BOOL)openSMS:(NSString *)sms
        number:(NSString *)number
viewController:(UIViewController<MFMessageComposeViewControllerDelegate> *)viewController
;
/*!
 *  打开邮件
 *  @param mail 邮件地址
 *  @param subject 主题
 *  @param body  正文
 *  @param viewController viewcontroller
 */
+(BOOL)openMail:(NSString *)mail
          subject:(NSString *)subject
           body:(NSString*)body
 viewController:(UIViewController<MFMailComposeViewControllerDelegate> *)viewController;
@end
