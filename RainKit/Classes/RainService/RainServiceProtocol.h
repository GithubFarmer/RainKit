//
//  RainServiceProtocol.h
//  RainKit
//
//  Created by 喻永权 on 2018/7/10.
//

#import <Foundation/Foundation.h>

@protocol RainServiceProtocol <NSObject>


@optional

+ (BOOL)async;

+ (BOOL)isSingleton;

+ (id)shareInstance;

@end
