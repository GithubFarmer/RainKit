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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)isFullScreenMode{
    return YES;
}

- (BOOL)shouldAutorotate{
    return YES;
}

- (BOOL)isLandScape{
    return YES;
}

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
