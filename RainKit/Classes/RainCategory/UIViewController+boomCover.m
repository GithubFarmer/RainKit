//
//  UIViewController+boomCover.m
//  RainKit
//
//  Created by 喻永权 on 2018/5/2.
//

#import "UIViewController+boomCover.h"
#import <objc/runtime.h>


static const char *KIsCover = "Rain.isCover";
static const char *KIsCoverView = "Rain.isCoverView";
static const char *KIsCoverStartView = "Rain.isCoverStartView";
static const char *KIsCoverController = "Rain.isCoverController";


UIView *_effectView;
@implementation UIViewController (boomCover)
    
- (void)boom_hideCompletion:(void (^)(void))block{
    if(!self.isCover){
        self.coverController = nil;
        self.coverStartView = nil;
        self.coverView = nil;
        return ;
    }
    UIView *coverView = nil;
    if(self.coverController){
        coverView = self.coverController.view;
    }else if (self.coverView){
        coverView = self.coverView;
    }else{
        return;
    }
    coverView.transform = CGAffineTransformIdentity;
    UIView *superView = self.view;
    CGPoint endPoint;
    if(self.coverStartView){
        endPoint = [self.coverStartView.superview convertPoint:self.coverStartView.center toView:superView];
        if(!CGRectContainsPoint(superView.frame, endPoint)){
            endPoint = superView.center;
        }
    }else{
        endPoint = superView.center;
    }
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         coverView.alpha = 0;
                         coverView.center = endPoint;
                         coverView.transform = CGAffineTransformMakeScale(0.05, 0.05);
                         _effectView.alpha = 0.1;
                     } completion:^(BOOL finished) {
                         self.isCover = NO;
                         [coverView removeFromSuperview];
                         coverView.transform = CGAffineTransformIdentity;
                         if(self.coverController){
                             [self.coverController removeFromParentViewController];
                         }
                         self.coverController = nil;
                         self.coverView = nil;
                         self.coverStartView = nil;
                         [_effectView removeFromSuperview];
                         if(block){
                             block();
                         }
                     }];
}

- (void)boom_showCoverView:(UIView *)coverView startView:(UIView *)startView completion:(void (^)(void))block{
    
    UIView *superView = self.view;
    if([superView.subviews containsObject:coverView]){
        return;
    }
    self.navigationController.navigationBar.hidden = YES;
    
    if(_effectView == nil){
        if([[UIDevice currentDevice].systemVersion floatValue] < 8.0){
            UIToolbar *toolBar = [[UIToolbar alloc]init];
            toolBar.barStyle = UIBarStyleBlackTranslucent;
            _effectView = toolBar;
        }else{
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            _effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
        }
        _effectView.frame = superView.bounds;
        [superView addSubview:_effectView];
    }else if (_effectView.superview == nil){
        [superView addSubview:_effectView];
    }
    coverView.frame = superView.bounds;
    [superView addSubview:coverView];
    [superView bringSubviewToFront:coverView];
    self.coverView = coverView;
    self.coverStartView = startView;
    CGPoint startPoint;
    if(startView){
        startPoint = [startView.superview convertPoint:startView.center toView:superView];
        if(!CGRectContainsPoint(superView.frame, startPoint)){
            startPoint = superView.center;
        }
    }else{
        startPoint = superView.center;
    }
    coverView.center = startPoint;
    coverView.alpha = 0;
    coverView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    _effectView.alpha = 0;
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         coverView.alpha = 1;
                         coverView.transform = CGAffineTransformIdentity;
                         coverView.center = superView.center;
                         _effectView.alpha = 1;
                     } completion:^(BOOL finished) {
                         if(block){
                             block();
                         }
                         self.isCover = YES;
                     }];
}

- (void)boom_showCoverController:(UIViewController *)coverVC startView:(UIView *)startView completion:(void (^)(void))block{
    
    if([self.childViewControllers containsObject:coverVC]){
        return;
    }
    [self addChildViewController:coverVC];
    [coverVC didMoveToParentViewController:self];
    self.coverController = coverVC;
    [self boom_showCoverController:coverVC startView:startView completion:block];
}


#pragma mark -
#pragma mark -setters & getters

- (void)setIsCover:(BOOL)isCover{
    objc_setAssociatedObject(self, KIsCover, @(isCover), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isCover{
    return [objc_getAssociatedObject(self, KIsCover) boolValue];
}

- (void)setCoverView:(UIView *)coverView{
    objc_setAssociatedObject(self, KIsCoverView, coverView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)coverView{
    return  objc_getAssociatedObject(self, KIsCoverView);
}

- (void)setCoverStartView:(UIView *)coverStartView{
    objc_setAssociatedObject(self, KIsCoverStartView, coverStartView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)coverStartView{
    return objc_getAssociatedObject(self, KIsCoverStartView);
}

- (void)setCoverController:(UIViewController *)coverController{
    objc_setAssociatedObject(self, KIsCoverController, coverController, OBJC_ASSOCIATION_RETAIN);
}

- (UIViewController *)coverController{
    return objc_getAssociatedObject(self, KIsCoverController);
}
@end
