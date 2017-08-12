//
//  PICKER.h
//  YJKit
//
//  Created by 袁杰 on 17/1/2.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimplePickerView.h"
#import "DatePicker.h"
/*!
 *  picker回调
 *
 *  @param index 下标
 */
typedef void (^PickerCallback)(NSInteger index);
/*!
 *  日期回调
 *
 *  @param date 结果
 */
typedef void (^DatePickerCallback)(NSString *date);

/*!
 *  滚筒选择器
 */
@interface PICKER : NSObject<DatePickerDelegate,SimplePickerViewDelegate>
/*!
 *  滚筒选择器
 *
 *  @param title    标题
 *  @param values    数组
 *  @param  okCallback  返回下标
 *  @param  cancelCallback  取消
 */
+(void)picker:(NSString*)title values:(NSArray*)values okCallback:(void(^)(NSInteger index))okCallback cancel:(void(^)())cancelCallback;
/*!
 *  时间选择器
 *
 *  @param title    标题
 *  @param time    时间
 *  @param  okCallback  选择结果
 *  @param  cancelCallback  取消
 */
+(void)timePicker:(NSString*)title time:(NSString*)time okCallback:(void(^)(NSString* time))okCallback cancel:(void(^)())cancelCallback;
/*!
 *  日期选择器
 *
 *  @param title    标题
 *  @param date    日期
 *  @param  okCallback  选择结果
 *  @param  cancelCallback  取消
 */
+(void)datePicker:(NSString*)title date:(NSString*)date okCallback:(void(^)(NSString* date))okCallback cancel:(void(^)())cancelCallback;
/*!
 *  日期和时间选择器
 *
 *  @param title    标题
 *  @param datetime    日期和时间
 *  @param  okCallback  选择结果
 *  @param  cancelCallback  取消
 */
+(void)dateTimePicker:(NSString*)title datetime:(NSString*)datetime okCallback:(void(^)(NSString* dateAndTime))okCallback cancel:(void(^)())cancelCallback;
@end
