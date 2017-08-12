//
//  AJAX.m
//  YJKit
//
//  Created by 袁杰 on 17/1/2.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import "AJAX.h"
#import "YJKit.h"
@interface AJAX ()

@end
static NSDictionary *HEADERS;
static NSDictionary *HEADER;

static BOOL isDemo = FALSE;
#define MSG_LOGIN @"连接失败"
@implementation AJAX


+(void)get:(NSString *)url params:(NSDictionary *)params callback:(void (^)(BOOL, NSHTTPURLResponse *, NSData *))successCallback callback:(void (^)(NSError *))failureCallbck mode:(AJAXMode)mode{
    if (isNull(url)) {
        NSLog(@"[YJKit-AJAX-getWithUrl]:url is null.");
        return;
    }
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSString* method;
    switch (mode) {
        case AJAXModeDelete:
            method = @"DELETE";
            break;
        case AJAXModeGet:
            method = @"GET";
            break;
        case AJAXModePost:
            method = @"POST";
            break;
        case AJAXModePut:
            method = @"PUT";
            break;
        default:
            method = nil;
            break;
    }
    request.HTTPMethod = method;
    
    //封装参数
    if (notNull(params))
    {
        switch (mode) {
            case AJAXModePost:
            case AJAXModePut:{
                NSMutableData *data = [[NSMutableData alloc] init];
                [data appendData:[[JSON stringify:params] dataUsingEncoding:NSUTF8StringEncoding]];
                request.HTTPBody = data;
                break;}
            case AJAXModeDelete:
            case AJAXModeGet:{
                NSString* fullUrl;
                NSString* str = @"";
                for (NSString* key in params) {
                    id value = [params objectForKey:key];
                    if([NSJSONSerialization isValidJSONObject:value]){
                        value = [JSON stringify:value];
                    }
                    if([value isKindOfClass:[NSString class]]){
                        value = [(NSString*)value URLEncode];
                    }
                    str = [str stringByAppendingString:[[NSString alloc] initWithFormat:@"&%@=%@",key,value]];
                }
                if(str.length>0){
                    str = [str substringFromIndex:1];
                }
                if (isEmpty(str)) {
                    fullUrl = url;
                }else{
                    NSURL* url1 = [NSURL URLWithString:url];
                    if (url1.query) {
                        fullUrl = [NSString stringWithFormat:@"%@&%@",url,str];
                    }
                    else{
                        fullUrl = [NSString stringWithFormat:@"%@?%@",url,str];
                    }
                }
                request.URL = [NSURL URLWithString:fullUrl];
                break;}
            default:
                break;
        }
    }
//    if (isDemo) {
//        NSString *path = [url replace:@"http://" to:@""];
//        NSArray *array = [STRING parse:path seperator:@"/"];
//        NSString *filename = array(array, array.count-1);
//        if ([filename contains:@"."]) {
//            NSInteger index = [filename indexOf:@"."];
//            filename = [filename substringToIndex:index];
//        }
//        filename = [filename URLEncode];
//        NSString *backupDbPath = [[NSBundle mainBundle]
//                                  pathForResource:filename
//                                  ofType:@"txt"];
//        
//        successCallback(FALSE,Nil,[NSData dataWithContentsOfFile:backupDbPath]);
//        return;
//    }
    if(notNull(HEADER)){
        for (NSString *key in HEADER.allKeys) {
            [request setValue:HEADER[key] forHTTPHeaderField:key];
        }
    }
    request.cachePolicy = NSURLCacheStorageAllowedInMemoryOnly;
    
    //发起请求
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  connectionError)
                                  {
                                      //成功返回取消loading
                                      NSString* message = nil;
                                      if(connectionError){
                                          message = @"服务器连接错误";
                                      }else{
                                          NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
                                          int statusCode = -1;
                                          if(httpResponse){
                                              statusCode = (int)httpResponse.statusCode;
                                          }
                                          if(statusCode!=200){
                                              if(statusCode==401){
                                                  [MESSAGE send: MSG_LOGIN params:nil target:self];
                                                  return;
                                              }
                                              switch (statusCode) {
                                                  case -1:
                                                  case 0:
                                                      message = @"网络无法连接，请检查网络设置。";
                                                      break;
                                                  default:{
                                                      NSError* error;
                                                      NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                                      message = json[@"error_msg"];
                                                      NSDictionary* error_detail = json[@"error_detail"];
                                                      if(error_detail){
                                                          NSMutableString* string = [NSMutableString stringWithString:message];
                                                          for (NSString* key in error_detail.allKeys) {
                                                              [string appendFormat:@"\n[%@]%@",key,error_detail[key]];
                                                          }
                                                          message = string;
                                                      }
                                                      break;}
                                              }
                                          }
                                      }
                                      if(message){
                                          dispatch_async(dispatch_get_main_queue(),^ {
                                              [DIALOG alert:message callback:^{
                                                  
                                                  successCallback(TRUE,(NSHTTPURLResponse*)response, nil);
                                              }];
                                          });
                                          return;
                                      };
                                      dispatch_async(dispatch_get_main_queue(),^ {
                                          successCallback(FALSE,(NSHTTPURLResponse*)response, data);
                                      });
                                  }];
    [task resume];

}
+ (void)getResponseWithUrl:(NSString *)url
                    params:(NSDictionary *)params
                      mode:(AJAXMode)mode
                  callback:(void (^)(BOOL isError,NSHTTPURLResponse* response, NSData* data))callback
{
    if (isNull(url)) {
        NSLog(@"[YJKit-AJAX-getWithUrl]:url is null.");
        return;
    }
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSString* method;
    switch (mode) {
        case AJAXModeDelete:
            method = @"DELETE";
            break;
        case AJAXModeGet:
            method = @"GET";
            break;
        case AJAXModePost:
            method = @"POST";
            break;
        case AJAXModePut:
            method = @"PUT";
            break;
        default:
            method = nil;
            break;
    }
    request.HTTPMethod = method;
    
    //封装参数
    if (notNull(params))
    {
        switch (mode) {
            case AJAXModePost:
            case AJAXModePut:{
                NSMutableData *data = [[NSMutableData alloc] init];
                [data appendData:[[JSON stringify:params] dataUsingEncoding:NSUTF8StringEncoding]];
                request.HTTPBody = data;
                break;}
            case AJAXModeDelete:
            case AJAXModeGet:{
                NSString* fullUrl;
                NSString* str = @"";
                for (NSString* key in params) {
                    id value = [params objectForKey:key];
                    if([NSJSONSerialization isValidJSONObject:value]){
                        value = [JSON stringify:value];
                    }
                    if([value isKindOfClass:[NSString class]]){
                        value = [(NSString*)value URLEncode];
                    }
                    str = [str stringByAppendingString:[[NSString alloc] initWithFormat:@"&%@=%@",key,value]];
                }
                if(str.length>0){
                    str = [str substringFromIndex:1];
                }
                if (isEmpty(str)) {
                    fullUrl = url;
                }else{
                    NSURL* url1 = [NSURL URLWithString:url];
                    if (url1.query) {
                        fullUrl = [NSString stringWithFormat:@"%@&%@",url,str];
                    }
                    else{
                        fullUrl = [NSString stringWithFormat:@"%@?%@",url,str];
                    }
                }
                request.URL = [NSURL URLWithString:fullUrl];
                break;}
            default:
                break;
        }
    }
//    if (isDemo) {
//        NSString *path = [url replace:@"http://" to:@""];
//        NSArray *array = [STRING parse:path seperator:@"/"];
//        NSString *filename = array(array, array.count-1);
//        if ([filename contains:@"."]) {
//            NSInteger index = [filename indexOf:@"."];
//            filename = [filename substringToIndex:index];
//        }
//        filename = [filename URLEncode];
//        NSString *backupDbPath = [[NSBundle mainBundle]
//                                  pathForResource:filename
//                                  ofType:@"txt"];
//        
//        callback(FALSE,Nil,[NSData dataWithContentsOfFile:backupDbPath]);
//        return;
//    }
    if(notNull(HEADER)){
        for (NSString *key in HEADER.allKeys) {
            [request setValue:HEADER[key] forHTTPHeaderField:key];
        }
    }
    request.cachePolicy = NSURLCacheStorageAllowedInMemoryOnly;
    
    //发起请求
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  connectionError)
                                  {
                                      //成功返回取消loading
                                      NSString* message = nil;
                                      if(connectionError){
                                          message = @"服务器连接错误";
                                      }else{
                                          NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
                                          int statusCode = -1;
                                          if(httpResponse){
                                              statusCode = (int)httpResponse.statusCode;
                                          }
                                          if(statusCode!=200){
                                              if(statusCode==401){
                                                  [MESSAGE send:MSG_LOGIN params:nil target:self];
                                                  return;
                                              }
                                              switch (statusCode) {
                                                  case -1:
                                                  case 0:
                                                      message = @"网络无法连接，请检查网络设置。";
                                                      break;
                                                  default:{
                                                      NSError* error;
                                                      NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                                      message = json[@"error_msg"];
                                                      NSDictionary* error_detail = json[@"error_detail"];
                                                      if(error_detail){
                                                          NSMutableString* string = [NSMutableString stringWithString:message];
                                                          for (NSString* key in error_detail.allKeys) {
                                                              [string appendFormat:@"\n[%@]%@",key,error_detail[key]];
                                                          }
                                                          message = string;
                                                      }
                                                      break;}
                                              }
                                          }
                                      }
                                      if(message){
                                          dispatch_async(dispatch_get_main_queue(),^ {
                                              [DIALOG alert:message callback:^{
                                                  
                                                  callback(TRUE,(NSHTTPURLResponse*)response, nil);
                                              }];
                                          });
                                          return;
                                      };
                                      dispatch_async(dispatch_get_main_queue(),^ {
                                          callback(FALSE,(NSHTTPURLResponse*)response, data);
                                      });
                                  }];
    [task resume];
}
+(NSDictionary *)headers
{
    return HEADERS;
}
+(void)setHeader:(NSDictionary*)header
{
    HEADER = header;
}

+(void)getVoid:(NSString *)url params:(NSDictionary *)params  successCallback:(void (^)(BOOL))successCallback failureCallbck:(void (^)(NSError *))failureCallbck mode:(AJAXMode)mode{
    [self get:url params:params callback:^(BOOL isError, NSHTTPURLResponse *response, NSData *data) {
        if (!isError) {
            if (notNull(successCallback)) successCallback(false);
            return ;
        }
        if (notNull(successCallback)) successCallback(true);
    } callback:^(NSError *error) {
        failureCallbck(error);
    } mode:mode];
}

+(void)getData:(NSString *)url params:(NSDictionary *)params successCallback:(void (^)(NSData *))successCallback failureCallbck:(void (^)(NSError *))failureCallbck mode:(AJAXMode)mode{
    [self get:url params:params callback:^(BOOL isError, NSHTTPURLResponse *response, NSData *data) {
        if(isError)
        {
            failureCallbck(Nil);
            return ;
        }
        if (isDemo) {
            successCallback(data);
            return;
        }
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
        HEADERS =httpResponse.allHeaderFields;
        //检查状态码
        switch (httpResponse.statusCode)
        {
            case 500:
                NSLog(@"[YJKit-AJAX-getDataWithUrl]:Internal Server Error.");
                if (notNull(successCallback)) successCallback(nil);
                break;
            case 404:
                NSLog(@"[YJKit-AJAX-getDataWithUrl]:Resource not found.");
                if (notNull(successCallback)) successCallback(nil);
                break;
            case 200:
                if (notNull(successCallback)) successCallback(data);
                break;
            default:
                NSLog(@"[YJKit-AJAX-getDataWithUrl]:Unknown error.");
                if (notNull(successCallback)) successCallback(nil);
                break;
        }

    } callback:^(NSError *error) {
        failureCallbck(error);
    } mode:mode];
}

+(void)getString:(NSString *)url params:(NSDictionary *)params successCallback:(void (^)(NSString *))successCallback failureCallbck:(void (^)(NSError *))failureCallbck mode:(AJAXMode)mode{
    [self getData:url params:params successCallback:^(NSData *data) {
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        successCallback(string);
    } failureCallbck:^(NSError *error) {
        failureCallbck(error);
    } mode:mode];
}


+(void)getJSON:(NSString *)url params:(NSDictionary *)params successCallback:(void (^)(NSDictionary *))successCallback failureCallbck:(void (^)(NSError *))failureCallbck mode:(AJAXMode)mode{
    [self getData:url params:params successCallback:^(NSData *data) {
        if (data) {
            NSError *error;
            id result;
            result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                if (notNull(failureCallbck)) failureCallbck(nil);
                return;
            }
            if (notNull(successCallback)) successCallback(result);
        }
    } failureCallbck:^(NSError *error) {
        failureCallbck(error);
    } mode:mode];
}

//+(void)getJSONs:(NSString *)url params:(NSDictionary *)params successCallback:(void (^)(NSArray *))successCallback failureCallbck:(void (^)(NSError *))failureCallbck mode:(AJAXMode)mode{
//    [self getData:url params:params successCallback:^(NSData *data) {
//        if (data) {
//            NSError *error;
//            id result;
//            result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//            if (error) {
//                if (notNull(failureCallbck)) failureCallbck(nil);
//                return;
//            }
//            if (notNull(successCallback)) successCallback(result);
//        }
//    } failureCallbck:^(NSError *error) {
//        failureCallbck(error);
//    } mode:mode];
//}

+(void)isDemo:(BOOL)isdemo
{
    isDemo = isdemo;
}

+(void)getImage:(NSString *)url params:(NSDictionary *)params successCallback:(void (^)(UIImage *))successCallback failureCallbck:(void (^)(NSError *))failureCallbck mode:(AJAXMode)mode{
    [AJAX getData:url params:params successCallback:^(NSData *data) {
        successCallback([UIImage imageWithData:data]);
    } failureCallbck:^(NSError *error) {
        failureCallbck(error);
    } mode:mode];
}




+(void)getXML:(NSString *)url params:(NSDictionary *)params successCallback:(void (^)(GDataXMLDocument *))successCallback failureCallbck:(void (^)(NSError *))failureCallbck mode:(AJAXMode)mode{
    [self getString:url params:params successCallback:^(NSString *string) {
        GDataXMLDocument* xml = [XML parse:string];
        successCallback(xml);
    } failureCallbck:^(NSError *error) {
        failureCallbck(error);
    } mode:mode];
}

+(void)getBase64:(NSString *)url params:(NSDictionary *)params successCallback:(void (^)(NSString *))successCallback failureCallbck:(void (^)(NSError *))failureCallbck mode:(AJAXMode)mode{
    [self getData:url params:params successCallback:^(NSData *data) {
        NSString *base64 = [data base64EncodedStringWithOptions:0];
        successCallback(base64);
    } failureCallbck:^(NSError *error) {
        failureCallbck(error);
    } mode:mode];
}
+(void)getBytes:(NSString *)url params:(NSDictionary *)params successCallback:(void (^)(Bytes *))successCallback failureCallbck:(void (^)(NSError *))failureCallbck mode:(AJAXMode)mode{
    [self getData:url params:params successCallback:^(NSData *data) {
        Bytes* bytes = [Bytes new];
        bytes.length = data.length;
        bytes.bytes = (Byte*)[data bytes];
        successCallback(bytes);
    } failureCallbck:^(NSError *error) {
        NSLog(@"%@",error);
    } mode:mode];
}
+ (void)upload:(NSString *)url
        params:(NSDictionary *)params
          mode:(AJAXMode)mode
      successCallback:(void (^)(NSDictionary* json))successCallback
     failureCallbck:(void (^)(NSError *error))failureCallbck
{
    if (isNull(url)) {
        NSLog(@"[YJKit-AJAX-getWithUrl]:url is null.");
        return;
    }
    
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //要上传的图片
   // UIImage *image;//=[params objectForKey:@"pic"];
    //得到图片的data
    //NSData* data = UIImagePNGRepresentation(image);
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [params allKeys];
    
    //遍历keys
    for(int i=0;i<[keys count];i++) {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //如果key不是pic，说明value是字符类型，比如name：Boris
        //if(![key isEqualToString:@"pic"]) {
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        //[body appendString:@"Content-Transfer-Encoding: 8bit"];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[params objectForKey:key]];
        //}
    }
    ////添加分界线，换行
    //[body appendFormat:@"%@\r\n",MPboundary];
    
    //声明myRequestData，用来放入http body
    
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        //声明结束符：--AaB03x--
        NSString *end=[[NSString alloc]initWithFormat:@"%@\r\n",endMPboundary];
        //加入结束符--AaB03x--
        [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
        
        //设置HTTPHeader中Content-Type的值
        NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
        //设置HTTPHeader
        [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    
    //http method
    NSString* method;
    switch (mode) {
        case AJAXModeDelete:
            method = @"DELETE";
            break;
        case AJAXModeGet:
            method = @"GET";
            break;
        case AJAXModePost:
            method = @"POST";
            break;
        case AJAXModePut:
            method = @"PUT";
            break;
        default:
            method = nil;
            break;
    }
    request.HTTPMethod = method;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  connectionError)
                                  {
                                      //成功返回取消loading
                                      NSString* message = nil;
                                      if(connectionError){
                                          message = @"服务器连接错误";
                                      }else{
                                          NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
                                          int statusCode = -1;
                                          if(httpResponse){
                                              statusCode = (int)httpResponse.statusCode;
                                          }
                                          if(statusCode!=200){
                                              if(statusCode==401){
                                                  [MESSAGE send:MSG_LOGIN params:nil target:self];
                                                  return;
                                              }
                                              switch (statusCode) {
                                                  case -1:
                                                  case 0:
                                                      message = @"网络无法连接，请检查网络设置。";
                                                      break;
                                                  default:{
                                                      NSError* error;
                                                      NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                                      message = json[@"error_msg"];
                                                      break;}
                                              }
                                          }
                                      }
                                      if(message){
                                          dispatch_async(dispatch_get_main_queue(),^ {
                                              [DIALOG alert:message callback:^{
                                                  
                                                  failureCallbck(nil);
                                              }];
                                          });
                                          return;
                                      };
                                      dispatch_async(dispatch_get_main_queue(),^ {
                                          NSError* error;
                                          successCallback([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error]);
                                      });
                                      
                                  }];
    [task resume];
}


@end
