//
//  RainTransitionAnnimationTwo.h
//  RainKit_Example
//
//  Created by 喻永权 on 2018/11/27.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RainTransitionAnnimationOne.h"

@interface RainTransitionAnnimationTwo : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) RainTransitionAnnimationOneType transitionType;

@end
