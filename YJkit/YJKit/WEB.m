//
//  WEB.m
//  YJKit
//
//  Created by 袁杰 on 17/1/1.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import "WEB.h"
#import "CONFIG.h"
#import "JSON.h"

@interface WEB()

@end
@implementation WEB
+ (void)loadUrl:(NSString*)url params:(NSDictionary*)params webView:(UIWebView *)webView
{
    NSURL* uri = [NSURL URLWithString:url];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:uri];
//    [request setValue:[CONFIG get:CONFIG_TOKEN] forHTTPHeaderField:@"COOKIE"];
    [request setValue:@"text/html" forHTTPHeaderField:@"content-type"];
    if(params){
        NSMutableData *data = [[NSMutableData alloc] init];
        [data appendData:[[JSON stringify:params] dataUsingEncoding:NSUTF8StringEncoding]];
        request.HTTPBody = data;
    }
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    webView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    [webView loadRequest:request];
    [view addSubview:webView];

}

@end
