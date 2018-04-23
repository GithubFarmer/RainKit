//
//  SAWifiHelper.h
//  SAFoundation
//
//  Created by 汪志刚 on 2018/4/2.
//

#import <Foundation/Foundation.h>
@protocol SAWifiInfoProtocol;

@interface SAWifiHelper : NSObject

+ (id<SAWifiInfoProtocol>)SSIDInfo;

@end

@protocol SAWifiInfoProtocol <NSObject>

/** 连接的 wifi 的名字 */
@property (nonatomic, copy, readonly) NSString *SSID;
/** 连接的 wifi 的 mac 地址 */
@property (nonatomic, copy, readonly) NSString *BSSID;
/** 连接的 wifi 的 data 数据 */
@property (nonatomic, strong, readonly) NSData *SSIDDATA;

@end
