//
//  RainPerson.m
//  RainKit
//
//  Created by 喻永权 on 2018/3/27.
//

#import "RainPerson.h"

@implementation RainPerson

@synthesize personIntroduce = _personIntroduce;

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"classID":@"class"
             };
}


- (void)sendAction{

    self.name = @"Bobby";
    self.personIntroduce = @"我是一年级三班的小明";
}

- (instancetype)init{
    if(self = [super init]){
        [self sendAction];
    }
    return self;
}


@end
