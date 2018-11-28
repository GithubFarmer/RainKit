//
//  RainTransitionInteractiveTwo.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/11/27.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainTransitionInteractiveTwo.h"

@interface RainTransitionInteractiveTwo ()

//@property (nonatomic, strong) UIView *tempView;

@end


@implementation RainTransitionInteractiveTwo

- (void)addGestureForViewController:(UIViewController *)viewController{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    self.viewController = viewController;
    [viewController.view addGestureRecognizer:pan];
}

- (void)handleGesture:(UIPanGestureRecognizer *)pan{
    switch (_interactiveType) {
        case RainTransitionInteractiveTwoPresent:
            [self interactivePresent:pan];
            break;
        case RainTransitionInteractiveTwoDismiss:
            [self interactiveDismiss:pan];
            break;
        case RainTransitionInteractiveTwoPush:
            [self interactivePush:pan];
            break;
        case RainTransitionInteractiveTwoPop:
            [self interactivePop:pan];
            break;
        default:
            break;
    }
}

- (void)interactivePresent:(UIPanGestureRecognizer *)pan{
    
}

- (void)interactiveDismiss:(UIPanGestureRecognizer *)pan{
    CGPoint translation = [pan translationInView:pan.view];
    CGFloat percentComplete = 0.0;
    
    //左右滑动的百分比
    percentComplete = translation.x / (_viewController.view.frame.size.width);
    percentComplete = fabs(percentComplete);
    NSLog(@"%f",percentComplete);
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            _isInteractive = YES;
            [_viewController.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            //手势过程中，通过updateInteractiveTransition设置转场过程动画进行的百分比，然后系统会根据百分比自动布局动画控件，不用我们控制了
            [self updateInteractiveTransition:percentComplete];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            _isInteractive = NO;
            //手势完成后结束标记并且判断移动距离时候过半，过则finishInteractiveTransition完成转场操作，否则取消，转场失败
            if(percentComplete > 0.5){
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)interactivePush:(UIPanGestureRecognizer *)pan{
    
}

- (void)interactivePop:(UIPanGestureRecognizer *)pan{
    CGPoint translation = [pan translationInView:pan.view];
    CGFloat percentComplete = 0.0;
    
    //左右滑动的百分比
    percentComplete = translation.x / (_viewController.view.frame.size.width);
    percentComplete = fabs(percentComplete);
    NSLog(@"%f",percentComplete);
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            _isInteractive = YES;
            [_viewController.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            //手势过程中，通过updateInteractiveTransition设置转场过程动画进行的百分比，然后系统会根据百分比自动布局动画控件，不用我们控制了
            [self updateInteractiveTransition:percentComplete];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            _isInteractive = NO;
            //手势完成后结束标记并且判断移动距离时候过半，过则finishInteractiveTransition完成转场操作，否则取消，转场失败
            if(percentComplete > 0.5){
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
        }
            break;
            
        default:
            break;
    }
}


@end
