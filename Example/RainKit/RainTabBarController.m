//
//  RainTabBarController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/8/22.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainTabBarController.h"
#import "RainTabBar.h"

@interface RainTabBarController()<RainTabBarDelegate>

@property (nonatomic, strong) RainTabBar *myTabBar;

@end

@implementation RainTabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.myTabBar = [RainTabBar new];
    self.myTabBar.tabDelegate = self;
     [self setValue:_myTabBar forKey:@"tabBar"];
}

- (void)tabBarDidClickPlusButton:(RainTabBar *)tabBar{
    if(self.plusBlock){
        self.plusBlock();
    }
}

@end
