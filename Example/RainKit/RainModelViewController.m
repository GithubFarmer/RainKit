//
//  RainModelViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/3/27.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainModelViewController.h"
#import "SADevice.h"
#import <RainKit/RainPerson.h>


#import "sys/utsname.h"
#import <AdSupport/AdSupport.h>

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import <AFNetworking/AFNetworking.h>
#import "SAWifiHelper.h"
#import "NSString+RainKit.h"

#import "RainSingleView.h"

@interface RainModelViewController ()

@property (nonatomic, strong)dispatch_source_t timer;

@property (nonatomic, strong) NSString *sa_wifimac;
@end

@implementation RainModelViewController{
    NSInteger time;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RainPerson *person = [RainPerson new];
    NSLog(@"person:%@",person);
    NSLog(@"mac:%@", [self getMacAddress]);
    NSLog(@"====>IP:%@", [SADevice getClientIP]);
//    NSLog(@"====>外网IP:%@",[SADevice deviceIPAddress]);
    
//    NSLog(@"==%d",[SADevice currentNetworkType]);
    [self sa_appConfig_networkChangeNotification];
    
    NSString *intro = @"JSONHON";
    NSLog(@"%@",[intro name]);
    
    
    
//    RainSingleView *singleView = [[RainSingleView alloc]initWithFrame:CGRectZero name:@"234"];
    
    NSString *str1 = @"121312";
    NSNumber *num = @121312;
    NSLog(@"%d",[str1 isEqual:num]);
    
    [self performSelector:@selector(action1:) withObject:@{@"name":@"name" ,
                                                         @"age":@"25"
                                                         }];
    
}

- (void)action1:(NSDictionary *)dict{
    NSLog(@"%@",dict);
}

//使用分类方法
- (void)sa_categoryMethod{
    
    
    
}




- (void)sa_appConfig_networkChangeNotification {
    
    AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager]networkReachabilityStatus];
//    switch (status) {
//        case AFNetworkReachabilityStatusReachableViaWiFi:
            self.sa_wifimac = [SAWifiHelper SSIDInfo].BSSID;
//            break;
//        default:
//            self.sa_wifimac = nil;
//            break;
//    }
    NSLog(@"notification---sa_wifimac:%@ ==> %d ==> %@ ===> %@",self.sa_wifimac, status,[SAWifiHelper SSIDInfo].SSID, [SAWifiHelper SSIDInfo].SSIDDATA);
}

//错误的得到ip地址
- (NSString *)getMacAddress {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return [outstring uppercaseString];
}


- (void)GCD_Timer{
    //1.得到线程
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    time = 0;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1*NSEC_PER_SEC, 3*NSEC_PER_SEC);
    __weak typeof (self) weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        if(time++ == 6){
            NSLog(@"hello");
            weakSelf.timer = nil;
        }
        NSLog(@"hello!!!!");
    });
    dispatch_resume(self.timer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//预处理判断语句
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 700000

#else

#endif

@end
