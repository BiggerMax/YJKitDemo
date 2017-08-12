//
//  DB.m
//  YJKit
//
//  Created by 袁杰 on 17/1/1.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import "sqlite3.h"
#import "DB.h"
#import "FSO.h"
#import "Macro.h"
static NSMutableDictionary *connPooling = nil;
@interface DB ()

//数据库句柄
@property sqlite3 *Connection;
//数据库文件的名称
@property(nonatomic,strong) NSString *name;

@end

@implementation DB
+ (void)init
{
    //[YJKit init];
}

+ (DB *)openDB:(NSString *)name
{
    return [DB openDB:name check:true];
}
+ (DB *)openDB:(NSString *)name check:(BOOL)check
{
    [self init];
    if (check && ![FSO isExist:name]) {
        NSLog(@"[YJKit-DB]:open Failed:Can't find the file");
        return nil;
    }
    if (isNull(connPooling)) {
        connPooling = [[NSMutableDictionary alloc] init];
    }
    DB* db = [connPooling objectForKey:name];
    if (isNull(db)){
        db = [DB new];
        BOOL result = [db _open2:name];
        if (result) {
            db.name = name;
            [connPooling setValue:db forKey:name];
            return db;
        }else{
            NSLog(@"[YJKit-DB]:open Failed.");
            return nil;
        }
        
    }else{
        return db;
    }
}
- (BOOL)_open2:(NSString *)name
{
    NSString *path;
    path = [FSO getPathWithFileName:name];
    NSInteger rc = sqlite3_open([path UTF8String], &(_Connection));
    if (rc != SQLITE_OK) {
        return false;
    }else{
        return true;
    }
}

+(void)openQuery:(NSString *)name sql:(NSString*)sql callback:(void(^)(NSDictionary *))callback params:(id)params,... {
    DB *db = [DB openDB:name];
        NSInteger result;
    NSDictionary *dicArray = nil;
        //这个相当于ODBC的Command对象，用于保存编译好的SQL语句
        sqlite3_stmt *stmt;
        
        result = sqlite3_prepare_v2(db.Connection, [sql UTF8String], (int)sql.length, &stmt, nil);
        if (result != SQLITE_OK) {
            NSLog(@"[YJKit-DB]:prepare error! %s",sqlite3_errmsg(db.Connection));
        }
        
        //绑定参数
        va_list arguments;
        if (notNull(params)) {
            int i = 0;
            va_start(arguments, params);
            NSString *str = [NSString stringWithFormat:@"%@",params];
            result = sqlite3_bind_text(stmt, ++i, [str UTF8String], (int)str.length, nil);
            if (result != SQLITE_OK) {
                NSLog(@"[YJKit-DB]:firstArgument error! %s",sqlite3_errmsg(db.Connection));

            }
            
            id otherArgument;
            while (true) {
                otherArgument = va_arg(arguments, id);
                if (isNull(otherArgument)) {
                    break;
                }else{
                    str = [NSString stringWithFormat:@"%@", otherArgument];
                    result = sqlite3_bind_text(stmt, ++i, [str UTF8String], (int)str.length, nil);
                    if (result != SQLITE_OK) {
                        NSLog(@"[YJKit-DB]:otherArgument error! please check sql or arguments.");
                    }
                }
            }
            va_end(arguments);
        }
        
        NSMutableArray *results = [[NSMutableArray alloc] init];
        NSInteger columnCount = sqlite3_column_count(stmt);
        
        //读取结果
        while(true){
            result = sqlite3_step(stmt);
            if (result != SQLITE_ROW) {
                break;
            }
            
            NSMutableDictionary* entity = [[NSMutableDictionary alloc] init];
            for(int i=0; i<columnCount; i++)
            {
                const char* col = sqlite3_column_name(stmt, i);
                const char* value = (char*)sqlite3_column_text(stmt, i);
                [entity setObject:(value != NULL?[NSString stringWithUTF8String:value]:[NSNull null]) forKey:[NSString stringWithUTF8String:col]];
            }
            [results addObject:entity];
        }
        sqlite3_finalize(stmt);
    for (int i = 0; i < results.count; i++) {
        dicArray = [results objectAtIndex:i];
        callback(dicArray);
    }
    
}
- (void)query:(NSString *)sql
     callback:(void(^)(NSDictionary * dictionary))callback
       params:(id)params, ...
{
    NSInteger result;
    sqlite3_stmt *stmt;
    NSDictionary *dicArray = nil;
    result = sqlite3_prepare_v2(_Connection, [sql UTF8String], (int)sql.length, &stmt, nil);
    if (result != SQLITE_OK) {
        NSLog(@"[YJKit-DB]:prepare error! %s",sqlite3_errmsg(_Connection));
    }
    
    //绑定参数
    va_list arguments;
    if (notNull(params)) {
        int i = 0;
        va_start(arguments, params);
        NSString *str = [NSString stringWithFormat:@"%@",params];
        result = sqlite3_bind_text(stmt, ++i, [str UTF8String], (int)str.length, nil);
        if (result != SQLITE_OK) {
            NSLog(@"[YJKit-DB]:firstArgument error! %s",sqlite3_errmsg(_Connection));
            
        }
        
        id otherArgument;
        while (true) {
            otherArgument = va_arg(arguments, id);
            if (isNull(otherArgument)) {
                break;
            }else{
                str = [NSString stringWithFormat:@"%@", otherArgument];
                result = sqlite3_bind_text(stmt, ++i, [str UTF8String], (int)str.length, nil);
                if (result != SQLITE_OK) {
                    NSLog(@"[YJKit-DB]:otherArgument error! please check sql or arguments.");
                }
            }
        }
        va_end(arguments);
    }
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSInteger columnCount = sqlite3_column_count(stmt);
    
    //读取结果
    while(true){
        result = sqlite3_step(stmt);
        if (result != SQLITE_ROW) {
            break;
        }
        
        NSMutableDictionary* entity = [[NSMutableDictionary alloc] init];
        for(int i=0; i<columnCount; i++)
        {
            const char* col = sqlite3_column_name(stmt, i);
            const char* value = (char*)sqlite3_column_text(stmt, i);
            [entity setObject:(value != NULL?[NSString stringWithUTF8String:value]:[NSNull null]) forKey:[NSString stringWithUTF8String:col]];
        }
        [results addObject:entity];
        
    }
    sqlite3_finalize(stmt);
    for (int i = 0; i < results.count; i++) {
        dicArray = [results objectAtIndex:i];
        callback(dicArray);
    }
   
}
-(void)insert:(NSString *)table record:(NSDictionary*)record callback:(void(^)())callback{
    NSMutableString* fields = [NSMutableString new];
     NSMutableString* values = [NSMutableString new];
    for (NSString* key in record.allKeys) {
        [fields appendFormat:@",%@",key];
        [values appendFormat:@",\"%@\"",record[key]];
    }
    NSString * sql = [NSString stringWithFormat:@"insert into %@(%@) values(%@);",table,[fields substringFromIndex:1],[values substringFromIndex:1]];
    
    char * errmsg;
    sqlite3_exec(_Connection, sql.UTF8String, NULL, NULL, &errmsg);
    if (errmsg) {
        NSLog(@"插入失败--%s",errmsg);
    }else{
        NSLog(@"插入成功");
    }
    callback();
}
-(void)update:(NSString *)table record:(NSDictionary *)record key:(NSString *)key value:(id)value callback:(void(^)())callback{
    NSMutableString* fields = [NSMutableString new];
    NSMutableString* values = [NSMutableString new];
    for (NSString* keys in record.allKeys) {
        [fields appendFormat:@",%@",keys];
        [values appendFormat:@",\"%@\"",record[keys]];
    }
    NSString * sql = [NSString stringWithFormat:@"update %@ set %@ = %@ where %@ = %@;",table,[fields substringFromIndex:1],[values substringFromIndex:1],key,value];
    char * errmsg;
    sqlite3_exec(_Connection, sql.UTF8String, NULL, NULL, &errmsg);
    if (errmsg) {
        NSLog(@"更新失败--%s",errmsg);
    }else{
        NSLog(@"更新成功");
    }
    callback();

}
-(void)remove:(NSString *)table key:(NSString *)key value:(id)value callback:(void(^)())callback{
    NSString * sql = [NSString stringWithFormat:@"delete from %@ where %@ = '%@';",table,key,value];
    char * errmsg;
    sqlite3_exec(_Connection, sql.UTF8String, NULL, NULL, &errmsg);
    if (errmsg) {
        NSLog(@"删除失败--%s",errmsg);
    }else{
        NSLog(@"删除成功");
    }
    callback();
}
-(void)get:(NSString *)table key:(NSString *)key value:(id)value callback:(void(^)(NSDictionary *dictionary))callback{
    NSString * sql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@';",table,key,value];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(_Connection, sql.UTF8String, -1, &stmt, NULL);
    NSDictionary *dicArray = nil;
    NSMutableArray *results = [[NSMutableArray alloc] init];
    if (result == SQLITE_OK) {
      
        NSInteger columnCount = sqlite3_column_count(stmt);
        while(true){
            result = sqlite3_step(stmt);
            if (result != SQLITE_ROW) {
                break;
            }
            
            NSMutableDictionary* entity = [[NSMutableDictionary alloc] init];
            for(int i=0; i<columnCount; i++)
            {
                const char* col = sqlite3_column_name(stmt, i);
                const char* value = (char*)sqlite3_column_text(stmt, i);
                [entity setObject:(value != NULL?[NSString stringWithUTF8String:value]:[NSNull null]) forKey:[NSString stringWithUTF8String:col]];
            }
            [results addObject:entity];
        }
        
    }

    sqlite3_finalize(stmt);
    for (int i = 0; i < results.count; i++) {
        dicArray = [results objectAtIndex:i];
    }
    callback(dicArray);
}
- (BOOL)close:(NSString *)name
{
    name = self.name;
    NSInteger rc = sqlite3_close(_Connection);
    if (rc != SQLITE_OK) {
        return false;
    }else{
        [connPooling removeObjectForKey:name];
    }
    return true;
}

@end
