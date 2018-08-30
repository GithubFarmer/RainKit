//
//  RainHoriViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/7/9.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainHoriViewController.h"
#import "RainViewConfigProtocol.h"
#import "UIViewController+RainRotation.h"


@interface RainHoriViewController ()<RainViewConfigProtocol>

@end

@implementation RainHoriViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"横屏界面";
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor yellowColor];
    CGPoint centerPoint = CGPointMake(CGRectGetWidth(self.view.bounds)/2.f, CGRectGetHeight(self.view.bounds)/2.f);
//    view.layer.borderWidth = 20;
//    view.layer.borderColor = [UIColor redColor].CGColor;
    view.center = centerPoint;
    view.bounds = CGRectMake(0, 0, 300, 400);
    [self.view addSubview:view];
    CGPoint centerPoint1 = CGPointMake(CGRectGetWidth(view.bounds)/2.f, CGRectGetHeight(view.bounds)/2.f);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:centerPoint1 radius:150-10 startAngle:0 endAngle:2 * M_PI clockwise:NO];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    layer.strokeColor = [UIColor brownColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 20;
    layer.strokeEnd = 1;
    layer.strokeStart = 0;
    [view.layer addSublayer:layer];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
//- (BOOL)isFullScreenMode{
//    return YES;
//}
//
//- (BOOL)shouldAutorotate{
//    return YES;
//}
//
//- (BOOL)isLandScape{
//    return YES;
//}

//iOS9以后，状态丢失的情况
- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self rain_preferredInterfaceOrientationForPresentation];
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
