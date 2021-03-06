//
//  RainViewControllerIntercepter.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/7/9.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainViewControllerIntercepter.h"
#import <Aspects/Aspects.h>
#import "RainViewConfigProtocol.h"

@implementation RainViewControllerIntercepter

+ (void)load{
    [self  setUpIntercepter];
}

+ (void)setUpIntercepter{
    
//    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
//        id obj = [aspectInfo instance];
//        if([obj isKindOfClass:[UIViewController class]]){
//            if([obj conformsToProtocol:@protocol(RainViewConfigProtocol)]){
//                [self configViewConttoller:obj];
//            }
//
//        }
//    } error:NULL];
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
        id obj = [aspectInfo instance];
        if([obj isKindOfClass:[UIViewController class]]){
            if([obj conformsToProtocol:@protocol(RainViewConfigProtocol)]){
                [self configViewConttoller:obj];
            }
        }
    } error:NULL];
}

+ (void)configViewConttoller:(UIViewController *)viewController{
    
    BOOL islandScape = NO;
    if([viewController respondsToSelector:@selector(isFullScreenMode)]){
        
        UIViewController <RainViewConfigProtocol> *vc = (UIViewController <RainViewConfigProtocol> *)viewController;
        if([vc isFullScreenMode]){
            viewController.edgesForExtendedLayout = UIRectEdgeAll;
            viewController.extendedLayoutIncludesOpaqueBars = YES;
        }else{
            viewController.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeRight | UIRectEdgeLeft;
            viewController.extendedLayoutIncludesOpaqueBars = NO;
        }
    }else{
//        viewController.extendedLayoutIncludesOpaqueBars = YES;
//        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if([viewController respondsToSelector:@selector(isLandScape)]){
        islandScape = [(UIViewController <RainViewConfigProtocol> *)viewController isLandScape];
    }
    if(viewController.view.backgroundColor){}
    else{
        viewController.view.backgroundColor = islandScape ? [UIColor yellowColor] : [UIColor whiteColor];
    }
//    viewController.extendedLayoutIncludesOpaqueBars = YES;
    viewController.modalPresentationCapturesStatusBarAppearance = NO;
    viewController.automaticallyAdjustsScrollViewInsets = NO;
    [self configNavigationBar:viewController];
}

+ (void)configNavigationBar:(UIViewController *)viewController{
    //配置导航条的颜色
    UIView *lineView = [self findHairlineImageViewUnder:viewController.navigationController.navigationBar];
    lineView.hidden = YES;
    UIColor *color = [UIColor purpleColor];
    if([viewController respondsToSelector:@selector(naviBarColor)]){
        color =  [(UIViewController <RainViewConfigProtocol> *)viewController naviBarColor];
    }
    viewController.navigationController.navigationBar.barTintColor = color;
    [viewController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:20]}];
}

+ (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


@end
