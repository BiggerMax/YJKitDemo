//
//  UI.m
//  YJKit
//
//  Created by 袁杰 on 17/1/1.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import "UI.h"
#import "UIViewController+YJKit.h"
@implementation UI
+ (id)load:(NSString *)path
{
    return [UI loadNibNamed:path placeHolder:nil];
}

+ (id)loadNibNamed:(NSString *)name placeHolder:(UIView *)placeHolder
{
    UIView* uc = [[NSBundle mainBundle] loadNibNamed:name owner:[UIViewController current] options:nil][0];
    if(placeHolder){
        CGRect frame = placeHolder.bounds;
        uc.frame = frame;
        [placeHolder addSubview:uc];
    }
    return uc;
}
@end
