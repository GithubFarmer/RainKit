//
//  RainSingleView.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/4/18.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainSingleView.h"

@implementation RainSingleView

- (instancetype)initWithFrame:(CGRect)frame name:(NSString *)name{
    if(self = [super initWithFrame:frame]){
        name = @"123";
    }
    return self;
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{}



//- (instancetype)initWithFrame:(CGRect)frame{
//   return  [self initWithFrame:frame name:@"123"];
//}
//
//- (instancetype)init{
//    return [self initWithFrame:CGRectZero name:@"123"];
//}
//
//+ (instancetype)new{
//    return [self initWithFrame:CGRectZero name:@"123"];
//}

@end
