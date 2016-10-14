//
//  BigModel.m
//  二级列表
//
//  Created by 赵博 on 16/10/13.
//  Copyright © 2016年 赵博. All rights reserved.
//

#import "BigModel.h"

@implementation BigModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (instancetype) initWithDictionary:(NSDictionary *) dictionary {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];

    }
    
    return self;
}

@end
