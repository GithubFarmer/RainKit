//
//  SAWifiHelper.m
//  SAFoundation
//
//  Created by 汪志刚 on 2018/4/2.
//

#import "SAWifiHelper.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@interface SAWifiInfo : NSObject <SAWifiInfoProtocol>

@property (nonatomic, copy) NSString *SSID;
@property (nonatomic, copy) NSString *BSSID;
@property (nonatomic, strong) NSData *SSIDDATA;

@end

@implementation SAWifiInfo

- (instancetype)initWithWifiInfo:(NSDictionary *)wifiInfo {
    self = [super init];
    if (self) {
        NSArray *bssids = [wifiInfo[(__bridge NSString*)kCNNetworkInfoKeyBSSID] componentsSeparatedByString:@":"];
        NSMutableArray *newBssids = [NSMutableArray array];
        for (NSString *bssid in bssids) {
            NSString *newBssid = nil;
            if (bssid.length == 1) {
                newBssid = [NSString stringWithFormat:@"0%@", bssid];
                [newBssids addObject:newBssid];
            }else{
                [newBssids addObject:bssid];
            }
        }
        NSString *bssid = [newBssids componentsJoinedByString:@":"];
        _SSID = wifiInfo[(__bridge NSString*)kCNNetworkInfoKeySSID];
        
        _BSSID = bssid;
        _SSIDDATA = wifiInfo[(__bridge NSString*)kCNNetworkInfoKeySSIDData];
    }
    return self;
}
@end

@implementation SAWifiHelper

+ (id<SAWifiInfoProtocol>)SSIDInfo {
    
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    
    NSDictionary *info = nil;
    SAWifiInfo *wifiInfo = nil;
    
    for (NSString *ifnam in ifs) {
        
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        
        if (info && [info count]) {
            wifiInfo = [[SAWifiInfo alloc] initWithWifiInfo:info];
            break;
        }
    }
    return wifiInfo;
}

@end
