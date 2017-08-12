//
//  CONFIG.m
//  YJKit
//
//  Created by 袁杰 on 16/12/27.
//  Copyright © 2016年 BiggerMax All rights reserved.
//

#import "CONFIG.h"
#import "XML.h"
#import "DATA.h"
#import "JSON.h"
@implementation CONFIG

+(void)init{

}

+(void)set:(NSString *)key value:(id)value{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//
+(id)get:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+(void)setString:(NSString *)key value:(NSString *)value{
     [CONFIG set:key value:value];
}
//
+(NSString *)getString:(NSString *)key{
    NSString *string = [CONFIG get:key];
    NSString *getString = [NSString stringWithFormat:@"%@",string];
    return getString;
}

+(void)setImage:(NSString *)key value:(UIImage *)value{
    NSData *data = UIImagePNGRepresentation(value);
    [CONFIG set:key value:data];
    
}
//
+(UIImage *)getImage:(NSString *)key{
    NSData *data = [CONFIG get:key];
    UIImage *image = [UIImage imageWithData:data];
    return image;

}

+(void)setJSON:(NSString *)key value:(id)value{
    NSString *jsonString = [JSON stringify:value];
    [CONFIG set:key value:jsonString];
}
//
+(id)getJSON:(NSString *)key{
    NSString *string = [CONFIG get:key];
    return [JSON parse:string];
}

//
+(void)setXML:(NSString *)key value:(GDataXMLDocument *)value{
    NSString* xmlString = [XML stringfy:value];
    [CONFIG set:key value:xmlString];
}
+(GDataXMLDocument *)getXML:(NSString *)key{
    NSString *string = [CONFIG getString:key];
    return [XML parse:string];
}

+(void)setData:(NSString *)key value:(NSData*)value{
    [CONFIG set:key value:value];
}
//
+(NSData *)getData:(NSString *)key{
    return [CONFIG get:key];
}

+(void)setBytes:(NSString *)key value:(Bytes *)value{
   NSData *data = [[NSData alloc] initWithBytes:value.bytes length:value.length];
    [CONFIG set:key value:data];
}

+(Bytes *)getBytes:(NSString *)key{
    NSData* data = [CONFIG getData:key];
    Bytes* bytes = [Bytes new];
    bytes.length = data.length;
    bytes.bytes = (Byte*)[data bytes];
    return bytes;
}
@end
