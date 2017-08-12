//
//  XML.m
//  YJKit
//
//  Created by 袁杰 on 16/12/27.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import "XML.h"

@implementation XML

+(GDataXMLDocument*)parse:(NSString *)string{
    GDataXMLDocument* xml = [[GDataXMLDocument alloc]initWithXMLString:string options:0 error:nil];
    return xml;
}

//
+(NSString *)stringfy:(GDataXMLDocument*)xml{
    NSData* data = [xml XMLData];
    NSString* string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}
@end
