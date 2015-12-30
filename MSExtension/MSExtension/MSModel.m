//
//  MSModel.m
//  MSExtension
//
//  Created by rms on 15/12/30.
//  Copyright © 2015年 rms. All rights reserved.
//

#import "MSModel.h"
#import <objc/runtime.h>

@implementation MSModel

+(instancetype)modelWithDict:(NSDictionary *)dict{

    MSModel *model = [[MSModel alloc]init];
    
    NSArray *arr = [model getIvars];
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *key = obj;
        id value = dict[key];
        
        [model setValue:value forKey:key];
    }];
    
    return model;
    
}

-(NSArray *)getIvars{

    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);

    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
  
        [array addObject:key];
    }
    return array;
}
@end
