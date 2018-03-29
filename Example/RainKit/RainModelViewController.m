//
//  RainModelViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/3/27.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainModelViewController.h"
#import <RainKit/RainPerson.h>

@interface RainModelViewController ()

@end

@implementation RainModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RainPerson *person = [RainPerson new];
    NSLog(@"person:%@",person);
    
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
