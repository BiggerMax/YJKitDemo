//
//  FSO.m
//  YJKit
//
//  Created by 袁杰 on 17/1/1.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import "FSO.h"
#import "YJKit.h"
@implementation FSO

+(BOOL)isExist:(NSString *)path{
   // NSString *paths = [self getPathWithFileName:path];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}

+ (NSString*)getPathWithFileName:(NSString*)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSLog(@"%@",directory);
    NSString* path = [[NSString alloc] initWithString:
                      [directory stringByAppendingPathComponent:fileName]];
    return path;
}

+(BOOL)deleteData:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL succeed = [fileManager removeItemAtPath:path error:&error];
    return succeed;
}


//+ (BOOL)saveStringWithString:(NSString*)string fileName:(NSString*)fileName ext:(NSString*)ext
//{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *directory = [paths objectAtIndex:0];
//    fileName = [[NSString alloc] initWithString:
//                [directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",fileName,ext]]];
//    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSData *data = [string dataUsingEncoding:encoding];
//    return [data writeToFile:fileName atomically:NO];
//}

+ (BOOL)saveData:(NSObject *)data withPath:(NSString *)path
{
    if (notNull(path))
    {
        return [NSKeyedArchiver archiveRootObject:data toFile:path];
    }
    return NO;
}
+(void)save:(NSString *)path object:(NSObject *)object callback:(void (^)(void))callback{
    [self saveData:object withPath:path];
    callback();
}
+(void)load:(NSString *)path callback:(void (^)(id data))callback{
    callback([NSKeyedUnarchiver unarchiveObjectWithFile:path]);
}
+(void)loadData:(NSString *)path callback:(void (^)(NSData *))callback{
    callback([NSData dataWithContentsOfFile:path]);
}
+(void)saveData:(NSString *)path data:(NSData *)data callback:(void (^)(void))callback{
    [data writeToFile:path atomically:YES];
    callback();
}
+(void)loadString:(NSString *)path callback:(void (^)(NSString *))callback{
    NSError* error;
    NSString *string = [NSString stringWithContentsOfFile:path
                                                 encoding:NSUTF8StringEncoding
                                                    error:&error];
    callback(string);
}

+(void)saveString:(NSString *)path string:(NSString *)string callback:(void (^)(void))callback{
    NSError* error;
    [string writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:&error];
    callback();
}

+(void)loadJSON:(NSString *)path callback:(void (^)(NSDictionary *))callback{
    [self loadString:path callback:^(NSString *string) {
        callback([JSON parse:string]);
    }];
}

+(void)saveJSON:(NSString *)path json:(NSDictionary *)json callback:(void (^)(void))callback{
    NSString* jsonString = [JSON stringify:json];
    [self saveString:path string:jsonString callback:^{
        callback();
    }];
}

+(void)loadXML:(NSString *)path callback:(void (^)(GDataXMLDocument *))callback{
    [self loadString:path callback:^(NSString *string) {
        callback([XML parse:string]);
    }];
}

+(void)saveXML:(NSString *)path xml:(GDataXMLDocument *)xml callback:(void (^)(void))callback{
    NSString* string = [XML stringfy:xml];
    [self saveString:path string:string callback:^{
        callback();
    }];
}

+(void)loadImage:(NSString *)path callback:(void (^)(UIImage *))callback{
    callback([UIImage imageWithContentsOfFile:path]);
}

+(void)saveImage:(NSString *)path image:(UIImage *)image callback:(void (^)(void))callback{
    NSData *data = UIImagePNGRepresentation(image);
    [self saveData:path data:data callback:^{
        callback();
    }];
}
+(void)saveBytes:(NSString *)path bytes:(Bytes *)bytes callback:(void (^)(void))callback{
    NSData *data = [[NSData alloc] initWithBytes:bytes.bytes length:bytes.length];
    [self saveData:path data:data callback:^{
        callback();
    }];
}

+(void)loadBytes:(NSString *)path callback:(void(^)(Bytes *))callback{
    [self loadData:path callback:^(NSData *data) {
        Bytes* bytes = [Bytes new];
        bytes.length = data.length;
        bytes.bytes = (Byte*)[data bytes];
        callback(bytes);
    }];
}
@end
