//
//  UIViewController+RainRotation.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/7/9.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "UIViewController+RainRotation.h"

@implementation UIViewController (RainRotation)

- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)isPreferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientation)rain_preferredInterfaceOrientationForPresentation{
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) {
        return UIInterfaceOrientationLandscapeRight;
    }
    return [UIApplication sharedApplication].statusBarOrientation;
}

@end
