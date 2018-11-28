//
//  RainPeripheralManager.m
//  RainKit
//
//  Created by 喻永权 on 2018/11/26.
//

#import "RainPeripheralManager.h"


@interface RainPeripheralManager ()<CBCentralManagerDelegate,CBPeripheralDelegate>

//@property (nonatomic, strong) CBCentralManager *centralManager;

@end


@implementation RainPeripheralManager

+ (instancetype)sharePeripheralInstance{
    static RainPeripheralManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[RainPeripheralManager alloc]init];
    });
    return _manager;
}

- (CBCentralManager *)getCentralManager{
    if(_centralManager == nil){
        _centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    }
    return _centralManager;
}

#pragma mark -
#pragma mark - CBCentralManagerDelegate
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"==>%@",peripheral);
}


- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"====%d===>>%@",central.state,peripheral);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
     NSLog(@"====>>%@===>>%@",[NSNumber numberWithInt:central.state],peripheral);
}


- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    NSLog(@"%@====%@",central,[NSNumber numberWithInt:central.state]);
    
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
}

#pragma mark -
#pragma mark - CBPeripheralDelegate
//已经发现外围服务的特征
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(nullable NSError *)error{
    
}
//获取蓝牙传输的值，更新外围设备的特征
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
}
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error{
    
}


@end
