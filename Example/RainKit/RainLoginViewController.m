//
//  RainLoginViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/8/22.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainLoginViewController.h"
#import "RainLoginView.h"
#import <Masonry/Masonry.h>
#import "RainViewConfigProtocol.h"

@interface RainLoginViewController ()<RainViewConfigProtocol>

@property (nonatomic, strong) RainLoginView *loginView;

@end

@implementation RainLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.extendedLayoutIncludesOpaqueBars=YES;
//    self.modalPresentationCapturesStatusBarAppearance=NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout =  UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight;
//    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    //    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
//    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    
//    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"px_blue"] forBarMetrics:UIBarMetricsCompact];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:30]}];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    UIStatusBarStyle style = [self preferredStatusBarStyle];
//    style = UIStatusBarStyleLightContent;
    
//    self.navigationController.navigationItem.hidesBackButton = YES;

    self.loginView = [RainLoginView new];
    [self.loginView.loginBtn setBackgroundImage:[UIImage imageNamed:@"px_blue"] forState:UIControlStateNormal];
    [self.view addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    

}

- (UIColor *)naviBarColor{
    return [UIColor redColor];
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
