//
//  DEVICE.h
//  YJKit
//
//  Created by 袁杰 on 17/1/1.
//  Copyright © 2017年 BiggerMax All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <mach-o/arch.h>
//struct host_basic_info {
//    integer_t max_cpus;
//    integer_t avail_cpus;
//    natural_t memory_size;
//    cpu_type_t cpu_type;
//    cpu_subtype_t cpu_subtype;
//    cpu_threadtype_t cpu_threatype;
//    integer_t physical_cpu;
//    integer_t physical_cpu_max;
//    integer_t logical_cpu;
//    integer_t logical_cpu_max;
//    unit64_t max_meo;
//};
/*!
 *  设备参数
 */
@interface DEVICE : NSObject
/*!
 *  获取编号
 *
 *  @return 返回设备ID
 */
+(NSString*)getID;
/*!
 *  查看处理器
 *
 *  @return 返回CPU
 */
+(NSString*)getCPU;
/*!
 *  获取内存
 *  @return 返回内存
 */
+(NSString *)getMemory:(BOOL)isAll;
/*!
 *  获取磁盘
 *
 *  @return 返回磁盘
 */
+(NSString *)getDisk:(BOOL)isAll;
/*!
 *  获取网络
 *
 *  @return 返回当前使用网络
 */
+(NSString*)getNetwork;
@end
