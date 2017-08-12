//
//  DIALOG.m
//  YJKit
//
//  Created by 袁杰 on 16/12/31.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import "DIALOG.h"
#import "Macro.h"
#import "UIViewController+YJKit.h"
#define DEFAULT_DISPLAY_DURATION 2.0f
#define cellID  @"cellid"
static DIALOG* m_Instance;
typedef NS_ENUM(NSUInteger, AlertViewType){
    /**
     * Alert视图
     */
    AlertViewTypeAlert,
    /**
     * Confirm视图
     */
    AlertViewTypeConfirm,
    /**
     * Input视图
     */
    AlertViewTypeInput
};
typedef void (^AlertViewCallback)(BOOL ok);
typedef void (^AlertCallback)(int);
typedef void (^InputCallback)(BOOL isOk,NSString *);

typedef void (^ActionSheetCallback)(int);
@interface DIALOG()<UIAlertViewDelegate, UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>

@property AlertViewType alertViewType;
@property (nonatomic, copy) AlertViewCallback alertViewCallback;
@property (nonatomic, copy) InputCallback inputCallback;
@property(nonatomic,copy) AlertCallback alertCallback;
@property (nonatomic, copy) ActionSheetCallback actionSheetCallback;

@property UITableView *alertTableView;
@property NSArray* options;
@property BOOL isRadio;
@property NSMutableArray *seletedIndexes;
@end
@implementation DIALOG

+(void)init{
    
}
+ (void)loading
{
    [LOADING show];
}
+ (void)done
{
    [LOADING hide];
}

+ (id)shareInstance{
    if (isNull(m_Instance)) {
        m_Instance = [[DIALOG alloc] init];
    }
    return m_Instance;
}
+ (void)warning:(NSString *)message
      isSilence:(BOOL)isSilence
       callback:(void (^)(void))callback
{
    NSLog(@"%@",message);
    if(isSilence){
        return;
    }
    DIALOG* m_Instance = [self shareInstance];
    m_Instance.alertViewCallback = ^(BOOL ok){
        if (notNull(callback)) {
            callback();
        }
    };
    [self showAlert:Nil message:message leftButton:@"我知道了" rightButton:Nil DIALOG:m_Instance];
}
+ (void)alert:(NSString *)message{
    [self alert:message callback:nil];
}
- (void)setDuration:(CGFloat) duration_{
    duration = duration_;
}

-(void)showAnimation{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    contentView.alpha = 1.0f;
    [UIView commitAnimations];
}
- (void)showFromBottomOffset:(CGFloat) bottom_{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    contentView.center = CGPointMake(window.center.x, window.frame.size.height-(bottom_ + contentView.frame.size.height/2));
    [window  addSubview:contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];
}
+(void)showAlert:(NSString *)title message:(NSString *)message leftButton:(NSString *)leftButton rightButton:(NSString *)rightButton DIALOG:(DIALOG *)DIALOG{
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:DIALOG
                      cancelButtonTitle:leftButton
                      otherButtonTitles:rightButton,Nil]
     show];
}

+(void)alert:(NSString *)title callback:(void (^)(void))callback{
    DIALOG* m_Instance = [DIALOG shareInstance];
    m_Instance.alertViewCallback = ^(BOOL ok){
        if (notNull(callback)) {
            callback();
        }
    };
    m_Instance.alertViewType = AlertViewTypeAlert;
    [self showAlert:Nil message:title leftButton:@"关闭" rightButton:Nil DIALOG:m_Instance];
}

+(void)toast:(NSString *)title{
    [self showWithText:title bottomOffset:70.0f];
}

+ (void)showWithText:(NSString *)text_
        bottomOffset:(CGFloat)bottomOffset_{
    [DIALOG showWithText:text_  bottomOffset:bottomOffset_ duration:DEFAULT_DISPLAY_DURATION];
}

+(void)showWithText:(NSString *)text_
       bottomOffset:(CGFloat)bottomOffset_
           duration:(CGFloat)duration_{
    DIALOG *toast = [[DIALOG alloc] initWithText:text_];
    [toast setDuration:duration_];
    [toast showFromBottomOffset:bottomOffset_];
}

- (id)initWithText:(NSString *)text_{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:[UIDevice currentDevice]];
    if (self = [super init]) {
        
        text = [text_ copy];
        
        UIFont *font = [UIFont boldSystemFontOfSize:14];
        CGSize textSize = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width + 12, textSize.height + 12)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width, textLabel.frame.size.height)];
        contentView.layer.cornerRadius = 5.0f;
        contentView.layer.borderWidth = 1.0f;
        contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        contentView.backgroundColor = [UIColor colorWithRed:0.2f
                                                      green:0.2f
                                                       blue:0.2f
                                                      alpha:0.75f];
        [contentView addSubview:textLabel];
        contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [contentView addTarget:self
                        action:@selector(toastTaped:)
              forControlEvents:UIControlEventTouchDown];
        contentView.alpha = 0.0f;
        
        duration = DEFAULT_DISPLAY_DURATION;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
    }
    return self;
}

- (void)deviceOrientationDidChanged:(NSNotification *)notify_{
    [self hideAnimation];
}

-(void)dismissToast{
    [contentView removeFromSuperview];
}

-(void)toastTaped:(UIButton *)sender_{
    [self hideAnimation];
}
-(void)hideAnimation{
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    contentView.alpha = 0.0f;
    [UIView commitAnimations];
}

///
+(void)confirm:(NSString *)title okCallback:(void (^)(BOOL isOK))okCallback cancelCallback:(void (^)())cancelCallback{
    [self confirm:title yesTitle:@"确认" noTitle:@"取消" okCallback:okCallback cancel:cancelCallback];
}
+ (void)confirm:(NSString *)message
       yesTitle:(NSString *)yesTitle
        noTitle:(NSString *)noTitle
       okCallback:(void (^)(BOOL))okCallback
         cancel:(void(^)())callback{
    DIALOG* DIALOG;
    if ((DIALOG = [self shareInstance])) {
        DIALOG.alertViewCallback = okCallback;
        DIALOG.alertViewType = AlertViewTypeConfirm;
        [self showAlert:Nil message:message leftButton:noTitle rightButton:yesTitle DIALOG:DIALOG];
    }else{
        callback();
        return;
    }
    
}

//


+ (void)input:(NSString *)title
  placeHolder:(NSString*)placeHolder
         type:(UIKeyboardType)keyboardType
     callback:(void (^) (BOOL isOk,NSString * string))okCallback
cancelCallBack:(void(^)())cancelCallback
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:nil
                                                       delegate:[DIALOG shareInstance]
                                              cancelButtonTitle:@"取消"
                              
                                              otherButtonTitles:@"确定", nil];
    
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    ((DIALOG *)[DIALOG shareInstance]).alertViewType = AlertViewTypeInput;
    ((DIALOG *)[DIALOG shareInstance]).inputCallback = okCallback;
    [alertView textFieldAtIndex:0].keyboardType = keyboardType;
    [alertView show];
    cancelCallback();
}

+(void)input:(NSString *)title placeHolder:(NSString *)placeHolder type:(UIKeyboardType)keyboardType callback:(void (^)(BOOL, NSString *))callback{
    UIViewController* viewController = [UIViewController current];
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:title preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeHolder;
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ((DIALOG*)[DIALOG shareInstance]).inputCallback = callback;
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [viewController presentViewController:alertController animated:YES completion:nil];

    
}

+(void)optionlist:(UIViewController*)viewController title:(NSString *)title options:(NSArray *)options cancel:(void (^)())cancelCallback{
    DIALOG* DIALOG = [self shareInstance];
    DIALOG.alertCallback = cancelCallback;
    UIAlertController* alertView = [UIAlertController alertControllerWithTitle:title message:title preferredStyle:UIAlertControllerStyleAlert];
    for (NSString *title in options) {
        UIAlertAction* action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:nil];
        [alertView addAction:action];
    }
    [viewController presentViewController:alertView animated:YES completion:nil];
}

+(void)checklist:(UIViewController*)viewController title:(NSString *)title options:(NSArray *)options okCallback:(void (^)(NSArray *))okCallback cancel:(void (^)(void))cancelCallback{

    DIALOG* m_Instance = [DIALOG shareInstance];
    m_Instance.options = options;
    m_Instance.alertTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40,270, 240) style:UITableViewStylePlain];
    UIAlertController* alertView = [UIAlertController alertControllerWithTitle:title message:@"\n\n\n\n\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancelCallback();
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okCallback(m_Instance.seletedIndexes);
        
    }];
    [alertView addAction:cancelAction];
    [alertView addAction:okAction];
    
    [m_Instance.alertTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    m_Instance.seletedIndexes = [NSMutableArray new];
    m_Instance.alertTableView.delegate = m_Instance;
    m_Instance.alertTableView.dataSource = m_Instance;
    m_Instance.isRadio = false;
    [m_Instance.alertTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [alertView.view addSubview:m_Instance.alertTableView];
    [viewController presentViewController:alertView animated:YES completion:nil];
    
    
}

+(void)radiolist:(UIViewController *)viewCotnroller title:(NSString *)title options:(NSArray *)options okCallback:(void (^)(int))okCallback cancel:(void (^)(void))cancelCallback{
    DIALOG* m_Instance = [self shareInstance];
    m_Instance.options = options;
    m_Instance.alertCallback = okCallback;
    m_Instance.alertTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40,270, 240) style:UITableViewStylePlain];
    [m_Instance.alertTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    m_Instance.isRadio = true;
    m_Instance.alertTableView.delegate = m_Instance;
    m_Instance.alertTableView.dataSource = m_Instance;
    m_Instance.seletedIndexes = [NSMutableArray new];
    [m_Instance.alertTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    UIAlertController* alertView = [UIAlertController alertControllerWithTitle:title message:@"\n\n\n\n\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        cancelCallback();
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okCallback([m_Instance.seletedIndexes[0] intValue]);
    }];
    [alertView addAction:cancelAction];
    [alertView addAction:okAction];

    [alertView.view addSubview:m_Instance.alertTableView];
    [viewCotnroller presentViewController:alertView animated:YES completion:nil];
    
}

// UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [DIALOG init];
    switch (_alertViewType) {
        case AlertViewTypeAlert:
            if(_alertViewCallback != nil){
                _alertViewCallback(TRUE);
            }
            break;
        case AlertViewTypeConfirm:
            if(_alertViewCallback != nil){
                _alertViewCallback(buttonIndex == 1);
            }
            break;
        case AlertViewTypeInput:
            if(_inputCallback != nil){
                if (buttonIndex==0) {
                    _inputCallback(NO,nil);
                }else{
                    _inputCallback(YES,[alertView textFieldAtIndex:0].text);
                }
            }
            break;
        default:
            break;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.options.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.textLabel.text = [self.options objectAtIndex:indexPath.row];
        if ([_seletedIndexes containsObject:@(indexPath.row)]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
   
 
}
- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    if (self.isRadio == true) {
        if(_seletedIndexes.count>0){
            if([_seletedIndexes[0] integerValue]!=index){
                _seletedIndexes = [NSMutableArray arrayWithArray:@[@(index)]];
            }else{
                [_seletedIndexes removeAllObjects];
            }
            
        }else{
            _seletedIndexes = [NSMutableArray arrayWithArray:@[@(index)]];
        }
    }else{
        if([_seletedIndexes containsObject:@(index)]){
            [_seletedIndexes removeObject:@(index)];
        }else{
            [_seletedIndexes addObject:@(index)];
        }
    }
    [self.alertTableView reloadData];
    return indexPath;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
