//
//  UIViewController+RainNav.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/7/9.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "UIViewController+RainNav.h"

@implementation UIViewController (RainNav)

-(UINavigationController *)getNavForPresented{
    
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:self];
    return nvc;
}

@end
