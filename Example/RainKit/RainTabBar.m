//
//  RainTabBar.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/8/22.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainTabBar.h"

#define KRainTabBar_Width [UIScreen mainScreen].bounds.size.width / 5

@implementation RainTabBar

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        UIButton *plus = [UIButton new];
        
        [plus setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plus setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateNormal];
//        plus.contentMode = UIViewContentModeScaleAspectFill;
        CGRect frame = plus.frame;
//        frame.size = plus.currentBackgroundImage.size;
        frame.size = CGSizeMake(KRainTabBar_Width, 80);
        plus.frame = frame;
        plus.layer.cornerRadius = 40;
        plus.layer.masksToBounds = YES;
        [plus addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plus];
        self.plusBtn = plus;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    // 1.设置加号按钮的位置
    CGPoint temp = self.plusBtn.center;
    temp.x=self.frame.size.width/2;
    temp.y=self.frame.size.height/2;
    self.plusBtn.center=temp;
    
    // 2.设置其它UITabBarButton的位置和尺寸
    CGFloat tabbarButtonW = self.frame.size.width / 5;
    CGFloat tabbarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            // 设置宽度
            CGRect temp1=child.frame;
            temp1.size.width=tabbarButtonW;
            temp1.origin.x=tabbarButtonIndex * tabbarButtonW;
            child.frame=temp1;
            // 增加索引
            tabbarButtonIndex++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex++;
            }
        }
    }

}

- (void)plusClick{
    if([self.tabDelegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]){
        [self.tabDelegate tabBarDidClickPlusButton:self];
    }
}

@end
