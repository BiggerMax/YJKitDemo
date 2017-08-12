//
//  ASSET.h
//  YJKit
//
//  Created by 袁杰 on 17/1/2.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import <UIKit/UIKit.h>
/*!
 *  资源文件加载
 */
@interface ASSET : NSObject
/*!
 *  加载数据
 *  @param  path  路径
 *  @return 返回数据
 */
+(NSData*)loadData:(NSString*)path;
/*!
 *  加载字符串
 *  @param  path  路径
 *  @return 返回字符串
 */
+(NSString*)loadString:(NSString*)path;
/*!
 *  加载XML
 *  @param  path  路径
 *  @return 返回XML
 */
+(GDataXMLDocument*)loadXML:(NSString*)path;
/*!
 *  加载JSON
 *  @param  path  路径
 *  @return 返回JSON
 */
+(id)loadJSON:(NSString*)path;
/*!
 *  加载图像
 *  @param  path  路径
 *  @return 返回图像
 */
+(UIImage*)loadImage:(NSString*)path;
@end
