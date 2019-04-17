//
//  RainHeader.h
//  Pods
//
//  Created by 喻永权 on 2018/4/23.
//

#ifndef RainHeader_h
#define RainHeader_h

//竖屏幕宽高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define kSCALL SCREEN_WIDTH/375.0

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define StatusBarAndNavigationBarHeight (iPhoneX ? 88.f : 64.f)

#define RGBRANDOMCOLOR [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0]

#import "UIView+extend.h"

#import "RainPerson.h"

#import "RainPhotoRecycle.h"

#import "RainPictureBlurManager.h"

#import "RainServiceTestProtocol.h"

#import "RainPeripheralManager.h"

#endif /* RainHeader_h */
