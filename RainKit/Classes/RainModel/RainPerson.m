//
//  RainPerson.m
//  RainKit
//
//  Created by 喻永权 on 2018/3/27.
//

#import "RainPerson.h"

@implementation RainPerson

@synthesize personIntroduce = _personIntroduce;

//给定义的model属性进行重命名
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"classID":@"class"
             };
}

//集合对象数组需要实现的协议
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"personArray":[RainObject class]
             };
}


- (void)sendAction{

    self.name = @"Bobby";
    self.personIntroduce = @"我是一年级三班的小明";
    self.name = @"daa";
    self.name = @"fda";
//    self.age = 13;
//    self.address = @"";
}

- (instancetype)init{
    if(self = [super init]){
        [self sendAction];
    }
    return self;
}

@end


@implementation RainObject


@end
