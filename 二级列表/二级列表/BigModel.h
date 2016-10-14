//
//  BigModel.h
//  二级列表
//
//  Created by 赵博 on 16/10/13.
//  Copyright © 2016年 赵博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BigModel : NSObject

/**
 *  询价主键
 */
@property(nonatomic,copy)NSString *ID;
//询价主键(二层)(起运港和目的港数量都为1的情况下使用)
@property(nonatomic, copy)NSString *HID;
/**
 *  主主键
 */
@property(nonatomic, copy)NSString *GID;
/**
 *  主主键(二层)
 */
@property(nonatomic, copy)NSString *HHID;
/**
 *  报价主键
 */
@property(nonatomic, copy)NSString *SO_ID;
/**
 *  委托主键
 */
@property(nonatomic, copy)NSString *JOB_ID;
/**
 *  起运港
 */
@property(nonatomic,copy)NSString *START_PORT_NAME;
/**
 *  目的港
 */
@property(nonatomic,copy)NSString *END_PORT_NAME;
/**
 *  拼箱类型
 */
@property(nonatomic,copy)NSString *TYPE;
/**
 *  是否服务商报价 0:未转发、1部分转发、2已转发
 */
@property(nonatomic,copy)NSString *IS_RATE;
/**
 *  报价类型
 */
@property(nonatomic,copy)NSString *IS_ASSIST;
/**
 *  是否服务商报价 1:否、2是
 */
@property(nonatomic,copy)NSString *IS_AUDITOR;
/**
 *  时间
 */
@property(nonatomic,copy)NSString *TIME;
/**
 *  船公司
 */
@property(nonatomic,copy)NSString *SHIP_COMPANY_NAME;
/**
 *  1.中转，2直达
 */
@property(nonatomic,copy)NSString *TRANSIT_TYPE;
/**
 *  中转代码
 */
@property(nonatomic,copy)NSString *VIA_CODE;
/**
 *  箱号
 */
@property(nonatomic,copy)NSString *XH;
/**
 *  报价人
 */
@property(nonatomic,copy)NSString *INP_ID;
/**
 *  报价人名
 */
@property(nonatomic,copy)NSString *INP_NAME;
/**
 *  最低价格
 */
@property(nonatomic, copy)NSString *LOW_PRICE;
/**
 *  二级内容
 */
@property(nonatomic,copy)NSString *list;
@property(nonatomic, copy)NSString *STR;
@property(nonatomic, copy)NSString *GOODS_VOLUME;
@property(nonatomic, copy)NSString *GOODS_GROSS_WEIGHT;
@property(nonatomic, copy)NSString *PRICE;
@property(nonatomic, copy)NSString *USER_MARK;

/**
 *  重货价格
 */
@property(nonatomic, copy)NSString *PRICE_WEIGHT;
/**
 *  轻货价格
 */
@property(nonatomic, copy)NSString *PRICE_LIGHT;
//空运
@property(nonatomic, copy)NSString *START_CODE;
@property(nonatomic, copy)NSString *END_CODE;
@property(nonatomic, copy)NSArray *ctno;

@property(nonatomic, copy)NSString *PACKING_TYPE;


- (instancetype) initWithDictionary:(NSDictionary *) dictionary;
@end
