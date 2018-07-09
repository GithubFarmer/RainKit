//
//  UIViewController+boomCover.h
//  RainKit
//
//  Created by 喻永权 on 2018/5/2.
//

#import <UIKit/UIKit.h>

@interface UIViewController (boomCover)

@property (nonatomic, assign) BOOL isCover;

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) UIView *coverStartView;

@property (nonatomic, strong) UIViewController *coverController;

- (void)boom_showCoverController:(UIViewController *)coverVC startView:(UIView *)startView completion:(void (^)(void))block;

- (void)boom_showCoverView:(UIView *)coverView startView:(UIView *)startView completion:(void (^)(void))block;

- (void)boom_hideCompletion:(void (^)(void))block;

@end
