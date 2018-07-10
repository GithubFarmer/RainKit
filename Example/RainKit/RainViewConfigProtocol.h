//
//  RainViewConfigProtocol.h
//  RainKit_Example
//
//  Created by 喻永权 on 2018/7/9.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RainViewConfigProtocol <NSObject>

@optional
/**
是否是全屏显示

 @return 返回YES或NO
 */
- (BOOL)isFullScreenMode;

- (BOOL)isLandScape;

@end
