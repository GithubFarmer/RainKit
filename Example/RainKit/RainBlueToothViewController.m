//
//  RainBlueToothViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/11/26.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainBlueToothViewController.h"
#import <RainKit/RainPeripheralManager.h>

@interface RainBlueToothViewController ()

@end

@implementation RainBlueToothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[RainPeripheralManager sharePeripheralInstance] get];
    [[RainPeripheralManager sharePeripheralInstance] getCentralManager];
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
