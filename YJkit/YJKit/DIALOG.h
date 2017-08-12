//
//  DIALOG.h
//  YJKit
//
//  Created by 袁杰 on 16/12/31.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*!
 *  对话框
 */
@interface DIALOG : NSObject<UIAlertViewDelegate, UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSString *text;
    UIButton *contentView;
    CGFloat  duration;
}

/*!
 *  消息框
 *
 *  @param title 消息
 *  @param  callback callback
 */
+ (void)alert:(NSString*)title
     callback:(void (^)(void))callback;
/*!
 *  消息框
 *
 *  @param title 标题
 *  @param  okCallback 确认callback
 *  @param  cancelCallback 取消callback
 */
+ (void)confirm:(NSString*)title
        okCallback:(void (^)(BOOL isOK))okCallback
         cancelCallback:(void(^)())cancelCallback;
/*!
 *  选项列表
 *  @param viewController viewcontroller
 *  @param title 标题
 *  @param  options 内容
 *  @param cancelCallback 取消callback
 *
 */
+ (void)optionlist:(UIViewController*)viewController
             title:(NSString*)title
            options:(NSArray *)options
            cancel:(void (^)())cancelCallback;
/*!
 *  单选列表
 *  @param viewController viewcontroller
 *  @param title 标题
 *  @param  options 内容
 *  @param  okCallback 返回下标
 *  @param cancelCallback 取消callback
 *
 */
+ (void)radiolist:(UIViewController*)viewController title:(NSString*)title
          options:(NSArray *)options
       okCallback:(void(^)(int index))okCallback
           cancel:(void (^)(void))cancelCallback;
/*!
 *  多选列表
 *  @param viewController viewcontroller
 *  @param title 标题
 *  @param  options 内容
 *  @param  okCallback 返回下标
 *  @param cancelCallback 取消callback
 *
 */
+ (void)checklist:(UIViewController*)viewController title:(NSString*)title
           options:(NSArray *)options
       okCallback:(void(^)(NSArray* index))okCallback
            cancel:(void (^)(void))cancelCallback;

/*!
 *  输入框
 *  @param title 标题
 *  @param placeHolder 占位符
 *  @param  keyboardType 键盘类型
 *  @param  okCallback 成功callBack
 *  @param  cancelCallback  取消callBack
 */
+ (void)input:(NSString *)title
      placeHolder:(NSString*)placeHolder
         type:(UIKeyboardType)keyboardType
     callback:(void (^) (BOOL isOk,NSString * string))okCallback
cancelCallBack:(void(^)())cancelCallback;
/*!
 *  提示框
 *
 *  @param title 消息
 */
+ (void)toast:(NSString*)title;

//+(void)showAlert:(NSString *)title message:(NSString *)message leftButton:(NSString *)leftButton rightButton:(NSString *)rightButton DIALOG:(DIALOG *)DIALOG;
//+ (void)warning:(NSString*)message
//      isSilence:(BOOL)isSilence
//       callback:(void (^)(void))callback;

@end
