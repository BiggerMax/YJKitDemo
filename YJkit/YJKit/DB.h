//
//  DB.h
//  YJKit
//
//  Created by 袁杰 on 17/1/1.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJKit.h"
/*!
 *  数据库操作
 */
@interface DB : NSObject
/*!
 *  打开数据库(必须存在)
 *
 *  @param name 名称
 *
 *  @return 数据库
 */
+ (DB*)openDB:(NSString*)name;
/*!
 *  关闭数据库
 *  @param name 名称
 */
- (BOOL)close:(NSString *)name;
/*!
 *  获取
 *  @param table 名称
 *  @param  key key
 *  @param  value value
 *  @param  callback 返回对象
 */
-(void)get:(NSString *)table key:(NSString *)key value:(id)value callback:(void(^)(NSDictionary *dictionary))callback;
/*!
 *  插入
 *  @param table 名称
 *  @param  record 对象
 *  @param  callback callback
 */
-(void)insert:(NSString *)table record:(NSDictionary*)record callback:(void(^)())callback;
/*!
 *  更新
 *  @param table 名称
 *  @param  record 对象
 *  @param key key
 *  @param value value
 *  @param  callback callback
 */
-(void)update:(NSString *)table record:(NSDictionary *)record key:(NSString *)key value:(id)value callback:(void(^)())callback;
/*!
 *  删除
 *  @param table 名称
 *  @param  key key
 *  @param  value value
 *  @param  callback callback
 */
-(void)remove:(NSString *)table key:(NSString *)key value:(id)value callback:(void(^)())callback;
/*!
 *  查询
 *  @param sql sql语句
 *  @param  callback 返回对象
 *  @param  params  变长参数
 */
- (void)query:(NSString*)sql callback:(void(^)(NSDictionary *dictionary))callback params:(id)params, ...;
/*!
 *  快速查询
 *  @param name  名称
 *  @param  sql  sql语句
 *  @param  callback 返回对象
 *  @param  params   变长参数
 */
+(void)openQuery:(NSString *)name sql:(NSString*)sql callback:(void(^)(NSDictionary *dictionary))callback params:(id)params,... ;

@end
