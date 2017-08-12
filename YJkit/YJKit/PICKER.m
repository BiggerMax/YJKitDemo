//
//  PICKER.m
//  YJKit
//
//  Created by 袁杰 on 17/1/2.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import "PICKER.h"
#import "UIViewController+YJKit.h"
#import "DIALOG.h"
#import "Macro.h"

static PICKER *m_Instance = nil;

@interface PICKER ()
@property (nonatomic, copy) DatePickerCallback datePickerCallback;

@property (nonatomic, copy) PickerCallback pickerCallback;
@property (nonatomic,strong) SimplePickerView*simplePickerView;
@property (nonatomic,strong) DatePicker*datePicker;
@end
@implementation PICKER
+ (id)shareInstance{
    if (isNull(m_Instance)) {
        m_Instance = [[PICKER alloc] init];
    }
    return m_Instance;
}
+(void)picker:(NSString *)title values:(NSArray *)values okCallback:(void (^)(NSInteger index))okCallback cancel:(void(^)())cancelCallback{
    if (m_Instance==nil) {
        [PICKER shareInstance];
    }
    if ((m_Instance.pickerCallback = okCallback)) {
        m_Instance.simplePickerView = [[SimplePickerView alloc]initWithTitle:title view:[[UIApplication sharedApplication].delegate window] array:values delegate:m_Instance];
        
        [m_Instance.simplePickerView pushDatePicker];
    }
    else{
        cancelCallback();
        return;
    }
}

+(void)timePicker:(NSString *)title time:(NSString *)time okCallback:(void (^)(NSString *))okCallback cancel:(void(^)())cancelCallback{
    if (m_Instance==nil) {
        [PICKER shareInstance];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:time];
    if ((m_Instance.datePickerCallback = okCallback)) {
        m_Instance.datePicker = [[DatePicker alloc]initWithTitle:title dateAndTime:timeDate viewOfDelegate:[[UIApplication sharedApplication].delegate window ] delegate:m_Instance];
        m_Instance.datePicker.theTypeOfDatePicker = 1;
        [m_Instance.datePicker pushDatePicker];
    }
    else{
        cancelCallback();
        return;
    }
}

+(void)datePicker:(NSString *)title date:(NSString *)date okCallback:(void (^)(NSString *))okCallback cancel:(void(^)())cancelCallback{
    if (m_Instance==nil) {
        [PICKER shareInstance];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateDate = [dateFormatter dateFromString:date];
    if ((m_Instance.datePickerCallback = okCallback)) {
        m_Instance.datePicker = [[DatePicker alloc]initWithTitle:title dateAndTime:dateDate viewOfDelegate:[[UIApplication sharedApplication].delegate window ] delegate:m_Instance];
        m_Instance.datePicker.theTypeOfDatePicker = 2;
        [m_Instance.datePicker pushDatePicker];
    }
    else{
        cancelCallback();
        return;
    }
    ;
}

+(void)dateTimePicker:(NSString *)title datetime:(NSString *)datetime okCallback:(void (^)(NSString *))okCallback cancel:(void(^)())cancelCallback{
    if (m_Instance==nil) {
        [PICKER shareInstance];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeAndDate = [dateFormatter dateFromString:datetime];
    if ((m_Instance.datePickerCallback = okCallback)) {
        m_Instance.datePicker = [[DatePicker alloc]initWithTitle:title dateAndTime:timeAndDate viewOfDelegate:[[UIApplication sharedApplication].delegate window] delegate:m_Instance];
        m_Instance.datePicker.theTypeOfDatePicker = 3;
        [m_Instance.datePicker pushDatePicker];
    }
    else{
        cancelCallback();
        return;
    }
    ;
}
-(void)DatePickerDidConfirm:(NSString *)confirmString
{
    _datePickerCallback(confirmString);
}
-(void)PickerDidConfirm:(NSInteger)index
{
    _pickerCallback(index);
}
@end
