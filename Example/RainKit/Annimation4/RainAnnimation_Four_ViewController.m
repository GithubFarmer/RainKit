//
//  RainAnnimation_Four_ViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/11/28.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainAnnimation_Four_ViewController.h"
#import "RainTransitionAnnimationFour.h"
#import "RainTransitionInteractiveTwo.h"
#import "RainViewConfigProtocol.h"

#import <RainKit/RainHeader.h>

@interface RainAnnimation_Four_ViewController ()<RainViewConfigProtocol>

//动画过渡转场
@property (nonatomic, strong) RainTransitionAnnimationFour *transitionFour;

//手势过渡转场
@property (nonatomic, strong) RainTransitionInteractiveTwo *interactiveFour;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation RainAnnimation_Four_ViewController

- (id)init{
    if(self = [super init]){
        self.transitionFour.transitionFourType = RainTransitionAnnimationOneTypePush;
        self.interactiveFour.interactiveType = RainTransitionInteractiveTwoPop;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"开关门动画";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
}


- (void)tapClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- Getter

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
        _imageView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        _imageView.image = [UIImage imageNamed:@"piao"];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked)];
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:tap];
        
    }
    return _imageView;
}

- (RainTransitionAnnimationFour *)transitionFour{
    if (_transitionFour == nil) {
        _transitionFour = [[RainTransitionAnnimationFour alloc] init];
    }
    return _transitionFour;
}

- (RainTransitionInteractiveTwo *)interactiveFour{
    if (_interactiveFour == nil) {
        _interactiveFour = [[RainTransitionInteractiveTwo alloc] init];
        [_interactiveFour addGestureForViewController:self];
    }
    return _interactiveFour;
}


#pragma mark -- UINavigationControllerDelegate

//返回处理push/pop动画过渡的对象
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        self.transitionFour.transitionFourType = RainTransitionAnnimationOneTypePush;
        return self.transitionFour;
    }else if (operation == UINavigationControllerOperationPop){
        self.transitionFour.transitionFourType = RainTransitionAnnimationOneTypePop;
    }
    return self.transitionFour;
}

//返回处理push/pop手势过渡的对象 这个代理方法依赖于上方的方法 ，这个代理实际上是根据交互百分比来控制上方的动画过程百分比
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    
    //手势开始的时候才需要传入手势过渡代理，如果直接pop或push，应该返回nil，否者无法正常完成pop/push动作
    if ( self.transitionFour.transitionFourType == RainTransitionAnnimationOneTypePop) {
        return self.interactiveFour.isInteractive == YES ? self.interactiveFour : nil;
    }
    return nil;
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
