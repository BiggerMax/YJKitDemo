//
//  SimplePickerView.h
//  YJKit
//
//  Created by 袁杰 on 17/1/2.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SimplePickerViewDelegate <NSObject>

-(void)PickerDidConfirm:(NSInteger )index;

@end
@interface SimplePickerView : NSObject<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIView *_view;
    UIPickerView *_picker;
    UIView *_pickerview;
    UIView *_background;
    UIButton *_headButton;
    UIButton *_confirmButton;
    UIButton *_cancelButton;
    UINavigationBar *_navagationbar;
}
@property (nonatomic,weak) id <SimplePickerViewDelegate> delegate;
-(id)initWithTitle:(NSString*)title view:(UIView*)view array:(NSArray*)array delegate:(id<SimplePickerViewDelegate>)delegate;
-(void)pushDatePicker;
-(void)poDatePicker;
@end
