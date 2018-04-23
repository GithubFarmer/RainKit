//
//  RainSingleView.h
//  RainKit_Example
//
//  Created by 喻永权 on 2018/4/18.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RainSingleView : UIView

//禁用初始化方法
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;


//声明初始化方法
- (instancetype)initWithFrame:(CGRect)frame name:(NSString *)name NS_DESIGNATED_INITIALIZER;

@end
