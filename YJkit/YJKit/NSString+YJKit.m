//
//  NSString+YJKit.m
//  YJKit
//
//  Created by 袁杰 on 16/12/27.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import "NSString+YJKit.h"
#import "Macro.h"

@implementation NSString (YJKit)
+ (void)init
{
    //[YJKit init];
}
+(BOOL)isEmpty:(NSString *)str{
    if (isNull(str)) {
        return TRUE;
    }
    if([str isEqualToString:@""]){
        return TRUE;
    }
    return FALSE;
}

//
-(NSInteger)indexOf:(NSString *)string{
    NSRange range = [self rangeOfString:string];
    return range.location;
}

//
-(NSInteger)lastIndexOf:(NSString *)string{
    return string.length;
}

//
-(BOOL)startWith:(NSString *)string{
    return ([self indexOf:string] == 0);
}

//
-(BOOL)endWith:(NSString *)string{
    return ([self indexOf:string] == self.length - string.length);
}

//
-(CGSize)sizeWithSize:(CGSize)size font:(UIFont *)font{
    return [self boundingRectWithSize:size
                              options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:@{NSFontAttributeName:font}
                              context:nil].size;
}
- (NSString *)URLEncode
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,    (CFStringRef)self,NULL,CFSTR("!*'();:@&=+$,/?%#[]"),kCFStringEncodingUTF8));
    return result;
}

- (NSString*)replace:(NSString *)target to:(NSString*)to
{
    return [self stringByReplacingOccurrencesOfString:target withString:to];
}

- (BOOL)contains:(NSString *)string
{
    return !([self indexOf:string]==NSNotFound);
}
@end
