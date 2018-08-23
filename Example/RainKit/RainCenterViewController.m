//
//  RainCenterViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/4/20.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainCenterViewController.h"
#import "RainViewConfigProtocol.h"

@interface RainCenterViewController ()<RainViewConfigProtocol>

@end

@implementation RainCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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
