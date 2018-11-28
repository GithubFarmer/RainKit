//
//  RainTransitionAnnimationThree.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/11/28.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainTransitionAnnimationThree.h"

//转场前VC
#import "RainAnnimationViewController.h"
//转场后VC
#import "RainAnnimation_Three_ViewController.h"

@implementation RainTransitionAnnimationThree

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    switch (_transitionType) {
        case RainTransitionAnnimationOneTypePush:
        
            break;
        case RainTransitionAnnimationOneTypePop:
            
            break;
        case RainTransitionAnnimationOneTypePresent:
            [self presentAnnimation:transitionContext];
            break;
        case RainTransitionAnnimationOneTypeDismiss:
            [self dimissAnnimation:transitionContext];
            break;
        default:
            break;
    }
}

- (void)presentAnnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = [fromView snapshotViewAfterScreenUpdates:YES];
    [containerView addSubview:toView];
    [containerView addSubview:tempView];
    
    fromView.hidden = YES;
    toView.hidden = YES;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        tempView.layer.transform = CATransform3DMakeRotation(M_PI/2, 0, 1, 0);
        tempView.alpha = 0;
    } completion:^(BOOL finished) {
        toView.hidden = NO;
        toView.layer.transform = CATransform3DMakeRotation(M_PI/2 * 3, 0, 1, 0);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            toView.layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 1, 0);
        } completion:^(BOOL finished) {
            [tempView removeFromSuperview];
            fromView.hidden = NO;
            [transitionContext completeTransition:YES];
        }];
    }];
}


- (void)dimissAnnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *fromTempView = [fromView snapshotViewAfterScreenUpdates:YES];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    [containerView addSubview:fromTempView];

    fromView.hidden = YES;
    toView.hidden = YES;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        fromTempView.layer.transform = CATransform3DMakeRotation(-M_PI/2, 0, 1, 0);
        fromTempView.alpha = 0;
    } completion:^(BOOL finished) {
        [fromTempView removeFromSuperview];
        if([transitionContext transitionWasCancelled]){
            
        }else{
            toView.hidden = NO;
            toView.layer.transform = CATransform3DMakeRotation(M_PI/2*3, 0, 1, 0);
        }
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            toView.layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 1, 0);
        } completion:^(BOOL finished) {
            fromView.hidden = NO;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if([transitionContext transitionWasCancelled]){
               //取消手势
                toView.hidden = YES;
            }else{
                
            }
        }];
        
    }];
}

@end
