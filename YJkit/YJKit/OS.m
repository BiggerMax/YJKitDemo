//
//  OS.m
//  YJKit
//
//  Created by 袁杰 on 17/1/2.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import "OS.h"
#import <UIKit/UIKit.h>
@implementation OS
+(NSString *)platform{
    NSString *platform = [[UIDevice currentDevice] model];
    return platform;
}

+(NSString *)version{
    NSString *version = [[UIDevice currentDevice] systemVersion];
    return version;
}

+(NSString *)Kernel{
    NSString *kernel = [[NSProcessInfo processInfo] operatingSystemVersionString];
    return kernel;
}
@end
