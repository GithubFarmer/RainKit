//
//  UIViewController+RainNav.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/7/9.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "UIViewController+RainNav.h"
#import <objc/runtime.h>


@implementation UIViewController (RainNav)

-(RainBaseViewController *)getNavForPresented{
    
    RainBaseViewController *nvc = [[RainBaseViewController alloc]initWithRootViewController:self];
//    nvc.navigationItem.leftBarButtonItem.action = @selector(back);
//    nvc.navigationItem.hidesBackButton = NO;
    return nvc;
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setBackItem:(UIBarButtonItem *)backItem {
    
    self.navigationItem.leftBarButtonItem = backItem;
    objc_setAssociatedObject(self, @"abc", backItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIBarButtonItem *)backItem {
    return objc_getAssociatedObject(self, @"abc");
}


- (void)setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems {
    objc_setAssociatedObject(self, @"kLeftBtn", leftBarButtonItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItems = nil;
//    [self.navigationController resetLeftItemsWithController:self];
}

- (NSArray<UIBarButtonItem *> *)leftBarButtonItems {
    return objc_getAssociatedObject(self, @"kLeftBtn");
}
@end
