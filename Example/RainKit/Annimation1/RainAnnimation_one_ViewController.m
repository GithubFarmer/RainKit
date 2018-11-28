//
//  RainAnnimation_one_ViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/11/26.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainAnnimation_one_ViewController.h"
#import "RainTransitionAnnimationOne.h"
#import <RainKit/RainHeader.h>

@interface RainAnnimation_one_ViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) RainTransitionAnnimationOne *transition;//过渡动画

@end

@implementation RainAnnimation_one_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.imageView];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    [self.imageView addGestureRecognizer:pan];
}

- (instancetype)init{
    if(self == [super init]){
        
        self.transition.transitionType = RainTransitionAnnimationOneTypePresent;
        //设置了这个属性之后，在present转场动画处理时，转场前的视图fromVC的view一直都在管理转场动画视图的容器containerView中，会被转场后，后加入到containerView中视图toVC的view遮住，类似于入栈出栈的原理；如果没有设置的话，present转场时，fromVC.view就会先出栈从containerView移除，然后toVC.view入栈，那之后再进行dismiss转场返回时，需要重新把fromVC.view加入containerView中。
        //在push转场动画处理时，设置这个属性是没有效果的，也就是没用的。
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)tapClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleGesture:(UIPanGestureRecognizer *)pan{
    CGPoint translation = [pan translationInView:self.imageView];
    CGFloat percentComplete = 0.0;
    self.imageView.center = CGPointMake(self.imageView.center.x + translation.x, self.imageView.center.y + translation.y);
    [pan setTranslation:CGPointZero inView:self.imageView];
    
    percentComplete = (self.imageView.center.y - self.view.frame.size.height / 2) / (self.view.frame.size.height / 2);
    percentComplete = fabs(percentComplete);
    NSLog(@"===%f",percentComplete);
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            self.view.alpha = 1 - percentComplete;
            break;
        case UIGestureRecognizerStateEnded:
        {
            if(percentComplete > 0.5){
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                self.imageView.center = CGPointMake(self.view.center.x, self.view.center.y);
                self.view.alpha = 1;
            }
        }
            break;
        default:
            break;
    }
    
}

- (UIImageView *)imageView{
    if(_imageView == nil){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];;
        _imageView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        _imageView.image = [UIImage imageNamed:@"piao"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}

- (RainTransitionAnnimationOne *)transition{
    if(_transition == nil){
        _transition = [RainTransitionAnnimationOne new];
        self.transitioningDelegate = self;
    }
    return _transition;
}

#pragma mark -
#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.transition.transitionType = RainTransitionAnnimationOneTypePresent;
    return self.transition;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.transition.transitionType = RainTransitionAnnimationOneTypeDismiss;
    return self.transition;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
