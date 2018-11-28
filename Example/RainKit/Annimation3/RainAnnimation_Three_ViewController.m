//
//  RainAnnimation_Three_ViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/11/28.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainAnnimation_Three_ViewController.h"
#import "RainTransitionAnnimationThree.h"
#import "RainTransitionInteractiveTwo.h"
#import <RainKit/RainHeader.h>

@interface RainAnnimation_Three_ViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) RainTransitionAnnimationThree *transitionThree;

@property (nonatomic, strong) RainTransitionInteractiveTwo *interactiveThree;

@end

@implementation RainAnnimation_Three_ViewController

- (id)init{
    if(self = [super init]){
        self.transitionThree.transitionType = RainTransitionAnnimationOneTypePresent;
        self.interactiveThree.interactiveType = RainTransitionInteractiveTwoDismiss;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
}

- (void)tapClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImageView *)imageView{
    if(_imageView == nil){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
        _imageView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        _imageView.image = [UIImage imageNamed:@"piao"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}

- (RainTransitionInteractiveTwo *)interactiveThree{
    if(_interactiveThree == nil){
        _interactiveThree = [RainTransitionInteractiveTwo new];
        [_interactiveThree addGestureForViewController:self];
    }
    return _interactiveThree;
}

- (RainTransitionAnnimationThree *)transitionThree{
    if(_transitionThree == nil){
        _transitionThree = [RainTransitionAnnimationThree new];
        self.transitioningDelegate = self;
    }
    return _transitionThree;
}

#pragma mark -
#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.transitionThree.transitionType = RainTransitionAnnimationOneTypeDismiss;
    return self.transitionThree;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.transitionThree;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    self.interactiveThree.interactiveType = RainTransitionInteractiveTwoDismiss;
    return self.interactiveThree;
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
