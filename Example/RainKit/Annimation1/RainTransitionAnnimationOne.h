//
//  RainTransitionAnnimationOne.h
//  RainKit_Example
//
//  Created by 喻永权 on 2018/11/26.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RainTransitionAnnimationOneType) {
    RainTransitionAnnimationOneTypePresent,//管理present动画
    RainTransitionAnnimationOneTypeDismiss,//管理dismiss动画
    RainTransitionAnnimationOneTypePush,//管理push动画
    RainTransitionAnnimationOneTypePop//管理pop动画
};


@interface RainTransitionAnnimationOne : NSObject <UIViewControllerAnimatedTransitioning>

/** 动画转场类型 */
@property (nonatomic, assign) RainTransitionAnnimationOneType transitionType;

@end
