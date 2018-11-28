//
//  RainTransitionAnnimationFour.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/11/28.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainTransitionAnnimationFour.h"

@implementation RainTransitionAnnimationFour

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 2;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_transitionFourType) {
        case RainTransitionAnnimationOneTypePush:
            [self pushAnnition:transitionContext];
            break;
        case RainTransitionAnnimationOneTypePop:
            [self popAnnition:transitionContext];
            break;
        case RainTransitionAnnimationOneTypePresent:
            
            break;
        case RainTransitionAnnimationOneTypeDismiss:
            
            break;
        default:
            break;
    }
}

- (void)pushAnnition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    //左侧动画
    UIView *leftView = [fromView snapshotViewAfterScreenUpdates:NO];
    UIView *leftTempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, fromView.frame.size.width / 2, fromView.frame.size.height)];
    leftTempView.clipsToBounds = YES;
    [leftTempView addSubview:leftView];
    
    //右侧动画
    UIView *rightView = [fromView snapshotViewAfterScreenUpdates:NO];
    rightView.frame = CGRectMake(-fromView.frame.size.width/2, 0, fromView.frame.size.width, fromView.frame.size.height);
    UIView *rightTempView = [[UIView alloc]initWithFrame:CGRectMake(fromView.frame.size.width / 2, 0, fromView.frame.size.width/2, fromView.frame.size.height)];
    rightTempView.clipsToBounds = YES;
    [rightTempView addSubview:rightView];
    
    [containerView addSubview:toView];
    [containerView addSubview:leftTempView];
    [containerView addSubview:rightTempView];
    
    fromView.hidden = YES;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        leftTempView.frame = CGRectMake(-fromView.frame.size.width/2, 0, fromView.frame.size.width/2, fromView.frame.size.height);
        rightTempView.frame = CGRectMake(fromView.frame.size.width, 0, fromView.frame.size.width/2, fromView.frame.size.height);
    } completion:^(BOOL finished) {
        fromView.hidden = NO;
        [leftTempView removeFromSuperview];
        [rightTempView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (void)popAnnition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *containerView = [transitionContext containerView];
    //左侧动画
    UIView *leftTempView = [[UIView alloc]initWithFrame:CGRectMake(-toView.frame.size.width/2, 0, toView.frame.size.width / 2, toView.frame.size.height)];
    leftTempView.clipsToBounds = YES;
    [leftTempView addSubview:toView];
    
    //右侧动画
    UIView *rightView = [toView snapshotViewAfterScreenUpdates:YES];
    rightView.frame = CGRectMake(-toView.frame.size.width/2, 0, toView.frame.size.width, toView.frame.size.height);
    UIView *rightTempView = [[UIView alloc]initWithFrame:CGRectMake(toView.frame.size.width, 0, toView.frame.size.width/2, toView.frame.size.height)];
    rightTempView.clipsToBounds = YES;
    [rightTempView addSubview:rightView];
    
    [containerView addSubview:fromView];
    [containerView addSubview:leftTempView];
    [containerView addSubview:rightTempView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        leftTempView.frame = CGRectMake(0, 0, fromView.frame.size.width/2, fromView.frame.size.height);
        rightTempView.frame = CGRectMake(fromView.frame.size.width/2, 0, fromView.frame.size.width/2, fromView.frame.size.height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if([transitionContext transitionWasCancelled]){
            //手势取消
        }else{
            [containerView addSubview:toView];
        }
        [leftTempView removeFromSuperview];
        [rightTempView removeFromSuperview];
        toView.hidden = NO;
    }];
}

@end
