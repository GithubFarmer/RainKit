//
//  RainServiceManager.h
//  RainKit
//
//  Created by 喻永权 on 2018/7/10.
//

#import <Foundation/Foundation.h>

@interface RainServiceManager : NSObject

+ (instancetype)shareInstance;

+ (id _Nullable)createServiceWithProtocol:(Protocol *_Nonnull)protocol;

+ (void)registerServiceWithProtocol:(Protocol *_Nonnull)protocol service:(Class _Nonnull)service;


/*******和协议类似这里只是实现协议方法的中间件******/
//+ (void)registerServiceWithUrl:(NSString *_Nonnull)urlString service:(Class _Nonnull)service;
//
//+ (void)createtServiceWithUrl:(NSString *_Nonnull)urlString  service:(Class _Nonnull)service;

@end
