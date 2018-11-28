//
//  RainTransitionInteractiveTwo.h
//  RainKit_Example
//
//  Created by 喻永权 on 2018/11/27.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RainTransitionInteractiveTwoType) {
    RainTransitionInteractiveTwoPresent,
    RainTransitionInteractiveTwoDismiss,
    RainTransitionInteractiveTwoPush,
    RainTransitionInteractiveTwoPop
};

/** 处理手势过渡的对象 */
@interface RainTransitionInteractiveTwo : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) RainTransitionInteractiveTwoType interactiveType;

@property (nonatomic, strong) UIViewController *viewController;

/** 区分是手势交互还是直接push/pop转场 */
@property (nonatomic, assign) BOOL isInteractive;

/** 给控制器的view添加相应的手势 */
- (void)addGestureForViewController:(UIViewController *)viewController;

@end
