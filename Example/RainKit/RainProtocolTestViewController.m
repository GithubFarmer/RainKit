//
//  RainProtocolTestViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/7/10.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainProtocolTestViewController.h"
#import <RainKit/RainServiceManager.h>
#import <RainKit/RainServiceTestProtocol.h>
#import "RainViewConfigProtocol.h"

@interface RainProtocolTestViewController ()
//<RainServiceTestProtocol,RainViewConfigProtocol>

@end

@implementation RainProtocolTestViewController

+ (void)load{
    [RainServiceManager registerServiceWithProtocol:@protocol(RainServiceTestProtocol) service:[self class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
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
