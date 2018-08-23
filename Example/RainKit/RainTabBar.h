//
//  RainTabBar.h
//  RainKit_Example
//
//  Created by 喻永权 on 2018/8/22.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RainTabBar;

@protocol RainTabBarDelegate <UITabBarDelegate>

//@optional

- (void)tabBarDidClickPlusButton:(RainTabBar *)tabBar;

@end

@interface RainTabBar : UITabBar

@property (nonatomic, strong) UIButton *plusBtn;

@property (nonatomic, weak) id <RainTabBarDelegate> tabDelegate;

@end
