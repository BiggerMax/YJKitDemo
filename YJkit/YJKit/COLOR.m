//
//  COLOR.m
//  YJKit
//
//  Created by 袁杰 on 17/1/21.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import "COLOR.h"
#import "MATH.h"

@implementation COLOR

+(UIColor *)fromString:(NSString *)str{
    NSString *cString = [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) return [UIColor blackColor];
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    //if ([cString length] != 6) return [UIColor blackColor];
    if(cString.length==6) cString = [cString stringByAppendingString:@"FF"];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    range.location = 6;
    NSString *aString = [cString substringWithRange:range];
    
    unsigned int red, green, blue, alpha;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&red];
    [[NSScanner scannerWithString:gString] scanHexInt:&green];
    [[NSScanner scannerWithString:bString] scanHexInt:&blue];
    [[NSScanner scannerWithString:aString] scanHexInt:&alpha];
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}
+(NSString *)toString:(UIColor *)color{
    CGFloat red, green, blue, alpha;
    if (![color getRed:&red green:&green blue:&blue alpha:&alpha]) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"#%@%@%@",
            [MATH toHex:red*255 length:2],
            [MATH toHex:green*255 length:2],
            [MATH toHex:blue*255 length:2]];
}
+(NSString *)toRGB:(UIColor *)color{
    CGFloat red, green, blue, alpha;
    if (![color getRed:&red green:&green blue:&blue alpha:&alpha]) {
        return @"";
    };
    return [NSString stringWithFormat:@"rgb(%d,%d,%d)",
            (int)red*255,
            (int)green*255,
            (int)blue*255];
}

+(NSString *)toRGBA:(UIColor *)color{
    CGFloat red, green, blue, alpha;
    if (![color getRed:&red green:&green blue:&blue alpha:&alpha]) {
        return @"";
    };
    return [NSString stringWithFormat:@"rgba(%d,%d,%d,%f)",
            (int)red*255,
            (int)green*255,
            (int)blue*255,
            alpha];
    ;
}
@end
