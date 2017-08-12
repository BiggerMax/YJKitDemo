//
//  WEB.h
//  YJKit
//
//  Created by 袁杰 on 17/1/1.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*!
 *  网页
 */
@interface WEB : NSObject<UIWebViewDelegate>
/*!
 *  加载网页
 *  @param  url 地址
 *  @param  params  参数
 *  @param  webView 网页控件
 */
+ (void)loadUrl:(NSString*)url params:(NSDictionary*)params webView:(UIWebView*)webView;
@end
