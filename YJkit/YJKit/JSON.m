//
//  JSON.m
//  YJKit
//
//  Created by 袁杰 on 16/12/27.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import "JSON.h"
#import "YJKit.h"
@implementation JSON
+(void)init{
    //
}

//
+(id)parse:(NSString *)string{
    [self init];
    if (string == nil) {
        NSLog(@"[YJKit-JSON-parse]:json string is null.");
        return nil;
    }
    
    NSData *stringData;
    NSError *error;
    stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    id result = [NSJSONSerialization JSONObjectWithData:stringData options:kNilOptions error:&error];
    if (!string) {
        NSLog(@"[YJKit-JSON-parse]:parse error");
        return nil;
    }
    return result;
}

//
+(NSString *)stringify:(id)json{
    if (isNull(json)) {
        NSLog(@"[YJKit-JSON-stringify]:json object is null.");
        return nil;
    }
    if (![NSJSONSerialization isValidJSONObject:json]) {
        NSLog(@"[YJKit-JSON-stringify]:json object is invalid");
        return nil;
    }
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:&error];
    if (notNull(error)) {
        NSLog(@"[YJKit-JSON-stringify]:stringify error:%@",error);
        return nil;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+(NSObject *)find:(NSArray *)jsons value:(id)value key:(NSString *)key{
    return [ARRAY find:jsons value:value key:key];
}

+(NSObject *)find:(NSArray *)jsons value:(id)value{
    return [ARRAY find:jsons value:value key:nil];
}
+(BOOL)contain:(NSArray *)jsons value:(id)value key:(NSString *)key{
    return [ARRAY indexOf:jsons value:value key:key];
}
+(BOOL)contain:(NSArray *)jsons value:(id)value{
    return [ARRAY contain:jsons value:value key:nil];
}
+(NSInteger)indexOf:(NSArray *)jsons value:(id)value key:(NSString *)key{
    return [ARRAY indexOf:jsons value:value key:key];
}
+(NSInteger)indexOf:(NSArray *)jsons value:(id)value{
    return [ARRAY indexOf:jsons value:value key:nil];
}
@end
