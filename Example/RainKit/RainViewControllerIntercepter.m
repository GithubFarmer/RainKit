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
        }else{
            viewController.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeRight | UIRectEdgeLeft;
        }
    }
    if([viewController respondsToSelector:@selector(isLandScape)]){
        islandScape = [(UIViewController <RainViewConfigProtocol> *)viewController isLandScape];
    }
    viewController.view.backgroundColor = islandScape ? [UIColor yellowColor] : [UIColor redColor];
    viewController.extendedLayoutIncludesOpaqueBars = YES;
    viewController.modalPresentationCapturesStatusBarAppearance = NO;
    viewController.automaticallyAdjustsScrollViewInsets = NO;
}


@end
