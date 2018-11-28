//
//  RainTransitionAnnimationOne.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/11/26.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainTransitionAnnimationOne.h"
#import "RainTransitionAnnitionNavigationController.h"
//toVC:终点控制器
#import "RainAnnimation_one_ViewController.h"
//fromVC:来源控制器
#import "RainAnnimationViewController.h"

@implementation RainTransitionAnnimationOne

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_transitionType) {
        case RainTransitionAnnimationOneTypePresent:
            [self presentAnnimation:transitionContext];
            break;
        case RainTransitionAnnimationOneTypeDismiss:
            [self dismissAnnimation:transitionContext];
            break;
        case RainTransitionAnnimationOneTypePush:
            [self pushAnnimation:transitionContext];
            break;
        case RainTransitionAnnimationOneTypePop:
            [self popAnnimation:transitionContext];
            break;
        default:
            break;
    }
}

- (void)presentAnnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是转场后VC、fromVC就是转场前的VC
    
    RainAnnimation_one_ViewController *toVC = (RainAnnimation_one_ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    RainAnnimationViewController *fromVC;
    if([[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] isKindOfClass:[UINavigationController class]]){
        UINavigationController *nvc = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        fromVC = nvc.viewControllers.lastObject;
    }else if ([[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] isKindOfClass:[RainAnnimationViewController class]]){
        fromVC = (RainAnnimationViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    }
    
    //取出转场前后视图控制器上的视图view
//    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    //获取点击的cell
    UITableViewCell *cell = [fromVC.tableView cellForRowAtIndexPath:fromVC.currentIndexPath];
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须加入containerView中才能进行，可以理解containerView管理者所有做转场动画的视图
    UIView *containView = [transitionContext containerView];
    //snapshotViewAfterScreenUpdates 对cell的iamgeView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    UIView *tempView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containView];
    cell.imageView.hidden = YES;
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    //tempView 添加到containerView中，要保证在最上层，所以后添加
    [containView addSubview:toVC.view];
    [containView addSubview:tempView];
   
    
    //开始做动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containView];
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [tempView removeFromSuperview];
        toVC.imageView.hidden = NO;
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中断动画完成的部署，会出现无法交互之类的bug
        [transitionContext completeTransition:YES];
    }];
    
}

- (void)dismissAnnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    RainAnnimationViewController *toVC;
    RainAnnimation_one_ViewController *fromVC = (RainAnnimation_one_ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isKindOfClass:[RainAnnimationViewController class]]){
        toVC = (RainAnnimationViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    }else  if([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isKindOfClass:[UINavigationController class]]){
        UINavigationController *nvc = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        toVC = nvc.viewControllers.lastObject;
    }
    
    UIView *containerView = [transitionContext containerView];
    
    //获取点击的cell
    UITableViewCell *cell = [toVC.tableView cellForRowAtIndexPath:toVC.currentIndexPath];
    UIView *tempView = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [fromVC.imageView convertRect:fromVC.imageView.bounds toView:containerView];
    
    //设置初始状态
    fromVC.imageView.hidden = YES;
    
    [containerView addSubview:tempView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        //由于加入了手势必须判断
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if([transitionContext transitionWasCancelled]){
            //手势取消了，原来隐藏的iamgeView要显示出来
            //失败了隐藏tempView，显示fromVC.imageView
            [tempView removeFromSuperview];
            fromVC.imageView.hidden = NO;
        }else{
            //手势成功
            cell.imageView.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}

//push动画过渡
- (void)pushAnnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [transitionContext completeTransition:YES];
}


//pop动画过渡
- (void)popAnnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [transitionContext completeTransition:YES];
}


@end
