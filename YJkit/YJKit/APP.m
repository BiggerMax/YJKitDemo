//
//  APP.m
//  YJKit
//
//  Created by ZhangJin on 2016/12/27.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import "APP.h"
#import <SafariServices/SafariServices.h>
#import "Macro.h"
#import <MessageUI/MessageUI.h>

@interface APP()

@end

@implementation APP
+ (NSString*)getID
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return infoDict[(NSString*)kCFBundleIdentifierKey];
}
+(BOOL)goUrl:(NSString *)url{
    return ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]]);
}
+(BOOL)openUrl:(NSString *)url viewController:(UIViewController<SFSafariViewControllerDelegate> *)viewController{
    Class webView = (NSClassFromString(@"SFSafariViewController"));
    if (webView != nil) {
        SFSafariViewController *sfViewControllr = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
        [viewController presentViewController:sfViewControllr animated:YES completion:^{
            
        }];
        return true;
    }
    return false;
    
}
+(BOOL)goPhone:(NSNumber *)number{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",number];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

+(BOOL)goMail:(NSString *)email subject:(NSString*)subject body:(NSString*)body{
    NSString *str = [NSString stringWithFormat:@"mailto:%@?cc=bar@example.com&subject=%@&body=%@",email,subject,body];
    NSURL* url = [NSURL URLWithString:str];
    return [[UIApplication sharedApplication] openURL:url];
}

+(BOOL)goSMS:(NSString *)message number:(NSString *)number{
    NSString *str = [NSString stringWithFormat:@"sms:%@&body=%@",number,message];
    NSURL* url = [NSURL URLWithString:str];
    return [[UIApplication sharedApplication] openURL:url];

}

+(BOOL)openPhone:(NSString *)number{
    if(isNull(number)){
        return NO;
    }
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
    {
        return NO;
    }
    NSString* str = [NSString stringWithFormat:@"telprompt:%@", number];
    NSURL* url = [NSURL URLWithString:str];

    return [[UIApplication sharedApplication] openURL:url];
}

+(BOOL)openSMS:(NSString *)sms number:(NSString *)number viewController:(UIViewController<MFMessageComposeViewControllerDelegate> *)viewController{
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = viewController;
            picker.recipients = @[number];
            picker.body = sms;
            viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [viewController presentViewController:picker animated:YES completion:nil];
            return true;
        }
        else {
            NSLog(@"[YJKit-DEVICE-sendSMS]:DEVICE does not have text messaging capabilities.");
            //设备没有短信功能
            return false;
        }
    }
    else {
        NSLog(@"[YJKit-DEVICE-sendSMS]:iOS4.0 above is supported within the program to send text messages.");
        // iOS版本过低,iOS4.0以上才支持程序内发送短信
        return false;
    }

}

+(BOOL)openMail:(NSString *)mail subject:(NSString *)subject body:(NSString *)body viewController:(UIViewController<MFMailComposeViewControllerDelegate> *)viewController{
    Class emailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (emailClass != nil) {
        MFMailComposeViewController* mailVC = [[MFMailComposeViewController alloc] init];
        mailVC.mailComposeDelegate = viewController;
        [mailVC setToRecipients:[NSArray arrayWithObject:mail]];
        [mailVC setSubject:subject];
        [mailVC setMessageBody:body isHTML:NO];
        [viewController presentViewController:mailVC animated:YES completion:nil];
        return true;
    }else{
        return false;
    }
}

@end
