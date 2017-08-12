//
//  RES.m
//  YJKit
//
//  Created by 袁杰 on 17/1/2.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import "RES.h"

@implementation RES

+(NSString *)loadLocalize:(NSString *)key{
    NSString *local = NSLocalizedString(key, nil);
    return local;
}

+(UIImage *)loadImage:(NSString *)key{
    return [UIImage imageNamed:key];
}
@end
