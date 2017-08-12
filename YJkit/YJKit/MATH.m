//
//  MATH.m
//  YJKit
//
//  Created by HeYanTao on 15/10/12.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import "MATH.h"

@implementation MATH
+ (void)init
{
    //[YJKit init];
}
+(NSString *)toHex:(long long int)value length:(int)length
{
    [self init];
    NSString *nLetterValue;
    NSString *str =@"";
    long long int tmpid = value;
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    while (str.length<length) {
        str = [@"0" stringByAppendingString:str];
    }
    return str;
}

@end
