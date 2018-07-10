//
//  UIViewController+RainNav.h
//  RainKit_Example
//
//  Created by 喻永权 on 2018/7/9.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RainBaseViewController.h"

@interface UIViewController (RainNav)


- (RainBaseViewController *)getNavForPresented;

@property (nonatomic, strong) UIBarButtonItem *backItem;

@property (nonatomic, strong) NSArray <UIBarButtonItem *>*leftBarButtonItems;  

@end
