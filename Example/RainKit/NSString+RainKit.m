//
//  NSString+RainKit.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/4/18.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "NSString+RainKit.h"
#import <objc/runtime.h>

static char *const nameKey = "RainKit.name";

@implementation NSString (RainKit)

- (id)init{
    self = [super init];
    if(self){
//        self.name = @"Rainy";
//        NSLog(@"name:%@",self.name);
    }
    return self;
}

- (void)setName:(NSString *)name{
    
    objc_setAssociatedObject(self, nameKey, name, OBJC_ASSOCIATION_COPY);
}

- (NSString *)name{
    NSString *tempName = objc_getAssociatedObject(self, nameKey);
    return tempName;
}
@end
