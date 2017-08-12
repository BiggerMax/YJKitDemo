//
//  ACTIONS.m
//  YJKit
//
//  Created by 袁杰 on 17/1/2.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import "ACTIONS.h"
#import "DIALOG.h"
#import "Macro.h"
#import "UIViewController+YJKit.h"
static ACTIONS *m_Instance = nil;

typedef void (^ActionSheetCallback)(int);

@interface ACTIONS ()<UIActionSheetDelegate,UIAlertViewDelegate>
@property (nonatomic, copy) ActionSheetCallback actionSheetCallback;
@end
@implementation ACTIONS
+ (id)shareInstance{
    if (isNull(m_Instance)) {
        m_Instance = [[ACTIONS alloc] init];
    }
    return m_Instance;
}
+(void)sheet:(NSString *)title actions:(NSArray *)actions index:(void (^)(int index))okCallback cancelCallback:(void (^)())cancelCallback{
    UIViewController* viewController = [UIViewController current];
    ACTIONS* ACTION = [self shareInstance];
    ACTION.actionSheetCallback = okCallback;
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:title
                                                            delegate:ACTION
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:nil];
    
    for (NSString* titleString in actions) {
        [actionSheet addButtonWithTitle:titleString];
    }
    [actionSheet showInView:viewController.navigationController.navigationBar];
    cancelCallback();
}
@end
