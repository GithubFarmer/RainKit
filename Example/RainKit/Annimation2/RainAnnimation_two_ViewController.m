//
//  RainAnnimation_two_ViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/11/27.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainAnnimation_two_ViewController.h"
#import "RainTransitionAnnimationTwo.h"
#import "RainTransitionInteractiveTwo.h"
#import <RainKit/RainHeader.h>
#import "RainViewConfigProtocol.h"


@interface RainAnnimation_two_ViewController ()<RainViewConfigProtocol>
/** 动画过渡转场 */
@property (nonatomic, strong) RainTransitionAnnimationTwo *transition;
/** 手势过渡转场 */
@property (nonatomic, strong) RainTransitionInteractiveTwo *transitionInteractive;

@end

@implementation RainAnnimation_two_ViewController

- (instancetype)init{
    if(self = [super init]){
        self.transition.transitionType = RainTransitionAnnimationOneTypePush;
        self.transitionInteractive.interactiveType = RainTransitionInteractiveTwoPop;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.titleLabel];
}

- (UIImageView *)imageView{
    if(_imageView == nil){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_HEIGHT/2)];
        _imageView.image = [UIImage imageNamed:@"piao"];
        _imageView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if(_titleLabel == nil){
        _titleLabel =  [[UILabel alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT - StatusBarAndNavigationBarHeight - 30, SCREEN_WIDTH, 40)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.text = @"手势过渡动画";
    }
    return _titleLabel;
}

- (void)tapClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (RainTransitionAnnimationTwo *)transition{
    if(_transition == nil){
        _transition = [RainTransitionAnnimationTwo new];
    }
    return _transition;
}

- (RainTransitionInteractiveTwo *)transitionInteractive{
    if(_transitionInteractive == nil){
        _transitionInteractive = [RainTransitionInteractiveTwo new];
        [_transitionInteractive addGestureForViewController:self];
    }
    return _transitionInteractive;
}
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    if(self.transition.transitionType == RainTransitionAnnimationOneTypePop){
        return (self.transitionInteractive.isInteractive == YES ? self.transitionInteractive : nil);
    }
    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  {
    if(operation == UINavigationControllerOperationPush){
        self.transition.transitionType = RainTransitionAnnimationOneTypePush;
        return self.transition;
    }else if(operation == UINavigationControllerOperationPop){
        self.transition.transitionType = RainTransitionAnnimationOneTypePop;
    }
    return self.transition;
}


- (void)viewDidDisappear:(BOOL)animated{
    self.navigationController.delegate = nil;
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
