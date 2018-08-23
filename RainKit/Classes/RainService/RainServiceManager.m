//
//  RainServiceManager.m
//  RainKit
//
//  Created by 喻永权 on 2018/7/10.
//

#import "RainServiceManager.h"
#import "RainServiceProtocol.h"

@interface RainServiceManager ()

@property (nonatomic, strong) NSMutableDictionary *serviceDict;

@property (nonatomic, strong) NSMutableDictionary *urlDict;

//锁
@property (nonatomic, strong) NSRecursiveLock *lock;

@end


@implementation RainServiceManager

+ (instancetype)shareInstance{
    static RainServiceManager *router = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(router == nil){
            router = [RainServiceManager new];
        }
    });
    return router;
}

+ (id)createServiceWithProtocol:(Protocol *)protocol{
    
    Class service = [self serviceWithProtocol:protocol];
    if([service respondsToSelector:@selector(isSingleton)]){
        if([service isSingleton]){
            if([service respondsToSelector:@selector(shareInstance)]){
                [service shareInstance];
            }else{
                [service new];
            }
        }
    }
    return [service new];
}

+ (void)registerServiceWithProtocol:(Protocol *)protocol service:(Class)service{
    [[RainServiceManager shareInstance] registerServiceWithProtocol:protocol service:service];
}

- (void)registerServiceWithProtocol:(Protocol *)protocol service:(Class)service{
 
    
    void (^registerBlock)(void);
    registerBlock = ^{
        NSString *key = NSStringFromProtocol(protocol);
        NSString *value = NSStringFromClass(service);
        if(key.length && value.length){
            [self.lock lock];
            [self.serviceDict addEntriesFromDictionary:@{key : value}];
            [self.lock unlock];
        }
    };
    if([service respondsToSelector:@selector(async)]){
        BOOL async = [service async];
        if(async){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                registerBlock();
            });
            
        }else{
            registerBlock();
        }
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            registerBlock();
        });
    }
    
}


+ (Class)serviceWithProtocol:(Protocol *)protocol{
    
    NSString *classString = [[[RainServiceManager shareInstance] serviceDict] objectForKey:NSStringFromProtocol(protocol)];
    if(classString.length){
        return NSClassFromString(classString);
    }
    return nil;
}


- (NSMutableDictionary *)serviceDict{
    if(_serviceDict == nil){
        _serviceDict = [NSMutableDictionary new];
    }
    return _serviceDict;
}

- (NSMutableDictionary *)urlDict{
    if(_urlDict == nil){
        _urlDict = [NSMutableDictionary new];
    }
    return _urlDict;
}

- (NSRecursiveLock *)lock{
    if(_lock == nil){
        _lock = [NSRecursiveLock new];
    }
    return _lock;
}
@end
