//
//  MSCoderObject.m
//  MSExtension
//
//  Created by rms on 15/12/30.
//  Copyright © 2015年 rms. All rights reserved.
//

#import "MSCoderObject.h"
#import <objc/runtime.h>

@implementation MSCoderObject
//归档
-(void)encodeWithCoder:(NSCoder *)encoder{

    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        //取出i对应的成员变量
        Ivar ivar = ivars[i];
        
        //查看成员变量
        const char *name = ivar_getName(ivar);
        
        //归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
    }
    free(ivars);
}
//解档
-(id)initWithCoder:(NSCoder *)decoder{

    if (self = [super init]) {
        unsigned int count = 0 ;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            
            //解档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [decoder decodeObjectForKey:key];
            
            //设置到成员变量身上
            [self setValue:value forKey:key];
        }
        
        free(ivars);
    }
    return self;

}

@end
