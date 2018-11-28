//
//  RainTransitionAnnimationTwo.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/11/27.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainTransitionAnnimationTwo.h"
//转场后的控制器
#import "RainAnnimation_two_ViewController.h"
//转场前的控制器
#import "RainAnnimationViewController.h"

@implementation RainTransitionAnnimationTwo

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_transitionType) {
        case RainTransitionAnnimationOneTypePresent:
            [self presentAnnination:transitionContext];
            break;
        case RainTransitionAnnimationOneTypeDismiss:
            [self dismissAnnination:transitionContext];
            break;
        case RainTransitionAnnimationOneTypePush:
            [self pushAnnination:transitionContext];
            break;
        case RainTransitionAnnimationOneTypePop:
            [self popAnnination:transitionContext];
            break;
            
        default:
            break;
    }
}

- (void)presentAnnination:(id<UIViewControllerContextTransitioning>)transitionContext{
    [transitionContext completeTransition:YES];
}

- (void)dismissAnnination:(id<UIViewControllerContextTransitioning>)transitionContext{
     [transitionContext completeTransition:YES];
}

- (void)pushAnnination:(id<UIViewControllerContextTransitioning>)transitionContext{
    //通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是转场后的VC、fromVC就是转场前的VC
    RainAnnimationViewController *fromVC;
    RainAnnimation_two_ViewController *toVC = (RainAnnimation_two_ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if([[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] isKindOfClass:[UINavigationController class]]){
        UINavigationController *nvc = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        fromVC = nvc.viewControllers.lastObject;
    }else if ([[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] isKindOfClass:[RainAnnimationViewController class]]){
        fromVC = (RainAnnimationViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    }
    
     UIView *containerView = [transitionContext containerView];
    //点击的cell
    UITableViewCell *cell = [fromVC.tableView cellForRowAtIndexPath:fromVC.currentIndexPath];
    //找到需要做动画的view
    UIView *imageView = [cell.imageView snapshotViewAfterScreenUpdates:NO];//NO表示立即截屏
    imageView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
    UIView *label = [cell.detailTextLabel snapshotViewAfterScreenUpdates:NO];
    label.frame = [cell.detailTextLabel convertRect:cell.detailTextLabel.bounds toView:containerView];
    
    //设置动画之前的状态
    cell.imageView.hidden = YES;
    cell.detailTextLabel.hidden = YES;
    toVC.imageView.hidden = YES;
    toVC.titleLabel.hidden = YES;
    
    //找到做动画的containerView
   
    [containerView addSubview:toVC.view];
    [containerView addSubview:cell.imageView];
    [containerView addSubview:cell.detailTextLabel];
    
    //开始做动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        imageView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        label.frame = [toVC.titleLabel convertRect:toVC.titleLabel.bounds toView:containerView];
    }
//     [UIView animateWithDuration:[self transitionDuration:transitionContext]
//                           delay:0.0 usingSpringWithDamping:0.5  initialSpringVelocity: 1 / 0.5 options:0 animations:^{
//                               imageView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
//                               label.frame = [toVC.titleLabel convertRect:toVC.titleLabel.bounds toView:containerView];
//
//                           }
    completion:^(BOOL finished) {
        toVC.imageView.hidden = NO;
        toVC.titleLabel.hidden = NO;
        [label removeFromSuperview];
        [imageView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)popAnnination:(id<UIViewControllerContextTransitioning>)transitionContext{
    RainAnnimation_two_ViewController *fromVC = (RainAnnimation_two_ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    RainAnnimationViewController *toVC ;
    if([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isKindOfClass:[UINavigationController class]]){
        UINavigationController *nvc = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        toVC = (RainAnnimationViewController *)nvc.viewControllers.lastObject;
    }else if ([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isKindOfClass:[RainAnnimationViewController class]]){
        toVC = (RainAnnimationViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    }
    
    UITableViewCell *cell = [toVC.tableView cellForRowAtIndexPath:toVC.currentIndexPath];
    
    UIView *containerView = [transitionContext containerView];
    UIView *tempImageView = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    tempImageView.frame = [fromVC.imageView convertRect:fromVC.imageView.bounds toView:containerView];
    UIView *tempLabel = [fromVC.titleLabel snapshotViewAfterScreenUpdates:NO];
    tempLabel.frame = [fromVC.titleLabel convertRect:fromVC.titleLabel.bounds toView:containerView];
    
    //动画前的准备工作
    fromVC.imageView.hidden = YES;
    fromVC.titleLabel.hidden = YES;
    [containerView addSubview:toVC.view];
    
    //背景过渡视图
    UIView *bgView = [[UIView alloc] initWithFrame:fromVC.view.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    [containerView addSubview:bgView];
    
    [containerView addSubview:tempImageView];
    [containerView addSubview:tempLabel];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempImageView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
        tempLabel.frame = [cell.detailTextLabel convertRect:cell.detailTextLabel.bounds toView:containerView];
        bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //取消返回
        if([transitionContext transitionWasCancelled]){
            fromVC.imageView.hidden = NO;
            fromVC.titleLabel.hidden = NO;
        }else{
            //手势成功，cell的iamgeView也要显示出来
            cell.imageView.hidden = NO;
            cell.detailTextLabel.hidden = NO;
        }
        //动画交互动作完成或取消后，移除临时动画文件
        [tempImageView removeFromSuperview];
        [tempLabel removeFromSuperview];
        [bgView removeFromSuperview];

    }];
}

@end
