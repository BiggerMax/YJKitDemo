//
//  UIViewController+YJKit.h
//  YJKit
//
//  Created by 袁杰 on 17/1/1.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YJKit)
+ (UIViewController*)current;
- (void)callback:(dispatch_block_t)callback;
@end
