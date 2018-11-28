//
//  RainPeripheralManager.h
//  RainKit
//
//  Created by 喻永权 on 2018/11/26.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef NS_ENUM(NSInteger, RainCentralState) {
    RainCentralStateNever,//中心设备初始化，从未连接
    RainCentralStateOpen,//中心设备已经打开
    RainCentralStateClose,//中心设备关闭
    RainCentralStateUnsupported//不支持中心设备（即不支持蓝牙）
};

typedef NS_ENUM(NSInteger, RainPeripheralState) {
    RainPeripheralStateDidDiscovered,//外围设备已经发现
    RainPeripheralStateConnecting,//外围设备正在连接
    RainPeripheralStateSuccessed,//外围设备连接成功
    RainPeripheralStateFailed,//外围设备连接失败
    RainPeripheralStateUnConnected//外围设备失去连接
};

@interface RainPeripheralManager : NSObject

+ (instancetype)sharePeripheralInstance;

//中心设备状态
@property (nonatomic, assign) RainCentralState centralState;

@property (nonatomic, strong, getter = getCentralManager) CBCentralManager *centralManager;

//外围设备状态
@property (nonatomic, assign) RainPeripheralState peripheralState;

@end
