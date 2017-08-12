//
//  MESSAGE.m
//  YJKit
//
//  Created by 袁杰 on 17/1/21.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import "MESSAGE.h"

@implementation MESSAGE
+ (void)init
{
    //[YJKit init];
}
+ (void)send:(NSString*)message params:(NSDictionary*)params target:(id)target
{
    [self init];
    [[NSNotificationCenter defaultCenter] postNotificationName:message object:target userInfo:params];
}
+ (void)send:(NSString*)message params:(NSDictionary*)params
{
    [MESSAGE send:message params:params target:nil];
}

+(void)receive:(NSString *)message callback:(void (^)(NSDictionary *))callback target:(id)target{
    [self init];
    [[NSNotificationCenter defaultCenter] addObserverForName:message object:target queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        callback(note.userInfo);
    }];
}
+ (void)receive:(NSString*)message callback:(void (^)(NSDictionary* params))callback
{
    [MESSAGE receive:message callback:callback target:nil];
}
@end
