//
//  RainTabBarController.h
//  RainKit_Example
//
//  Created by 喻永权 on 2018/8/22.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RainTabBarController : UITabBarController

@property (nonatomic, copy) void (^plusBlock)(void);

@end
