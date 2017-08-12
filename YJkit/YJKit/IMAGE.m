//
//  IMAGE.m
//  YJKit
//
//  Created by 袁杰 on 17/1/1.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import "IMAGE.h"

@implementation IMAGE
+(UIImage *)singgleColor:(UIImage *)image color:(UIColor *)color{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(context, rect, image.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage *)clip:(UIImage *)image rect:(CGRect)rect{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width, image.size.height), NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width, rect.size.height));
    CGContextClip(ctx);
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage *)scale:(UIImage *)image size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}

+(UIImage *)clearText:(NSString *)string font:(UIFont *)font size:(CGSize)size{
    CGSize titleSize = [string sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat x = (size.width-titleSize.width)/2;
    CGFloat y = (size.height-titleSize.height)/2;
    UIGraphicsBeginImageContext(size);
    
    NSDictionary *attr = @{NSFontAttributeName:font};
    
    [string drawInRect:CGRectMake(x, y, titleSize.width, titleSize.height) withAttributes:attr];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}

+(UIImage *)clearImage:(UIImage *)image color:(UIColor *)color size:(CGSize)size{
//    CGImageRef temImg = image.CGImage;
//    temImg = CGImageCreateWithImageInRect(temImg, CGRectMake(0, 0, size.width, size.height));
//    UIImage *newImage = [UIImage imageWithCGImage:temImg];
//    return newImage;
    CGSize iconSize = image.size;
    CGFloat x = (size.width-iconSize.width)/2;
    CGFloat y = (size.height-iconSize.height)/2;
        UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1.0, 0.2, 0.3, 1.0);
    CGContextFillRect(context, CGRectMake(0, 0, 80, 80));
    CGContextStrokePath(context);

    [image drawInRect:CGRectMake(x, y, iconSize.width, iconSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
