//
//  RainBaseViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/7/9.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainBaseViewController.h"
#import "UIViewController+RainNav.h"

@interface RainBaseViewController ()<UINavigationControllerDelegate>

@end

@implementation RainBaseViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if(self){
        if(@available (iOS 11.0, *)){
            [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-100, 0) forBarMetrics:UIBarMetricsDefault];
        }else{
            [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self  resetBackBtn:viewController];
}

- (void)resetBackBtn:(UIViewController *)vc{
    
    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    but.backgroundColor = [UIColor redColor];
    [but setTitle:@"返回" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:but];
//    vc.navigationItem.leftBarButtonItem = leftBarButtonItem;
    vc.backItem = leftBarButtonItem;
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//# pragma mark- autorotate
//
//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return [[self.viewControllers lastObject] preferredStatusBarStyle];
//}
//
//- (BOOL)prefersStatusBarHidden{
//    return [[self.viewControllers lastObject] prefersStatusBarHidden];
//}
//
//- (UIStatusBarAnimation) preferredStatusBarUpdateAnimation{
//    return [[self.viewControllers lastObject] preferredStatusBarUpdateAnimation];
//}
//
//- (BOOL)shouldAutorotate{
//    return [[self.viewControllers lastObject] shouldAutorotate];
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return [[self.viewControllers lastObject]supportedInterfaceOrientations];
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return [[self.viewControllers lastObject]preferredInterfaceOrientationForPresentation];
//}




#pragma mark-
#pragma mark-   UIViewControllerRotation
/**
 * 如果window的根视图是SANavigationController，则会先调用这个
 * 只需要在支持除竖屏以外方向的页面重新下边三个方法
 */

// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}
@end
