//
//  yumeBTLERemoteController.m
//  BT_Central
//
//  Created by Yume on 2014/4/18.
//  Copyright (c) 2014年 Yume. All rights reserved.
//

#import "yumeBTLERemoteController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "yumeDeviceListAlertTableView.h"
#import "yumeRemoteControllerDeviceProtocol.h"

#import "yumeRCPDRemoteControllerParameterData.h"
#import "yumeRCRDRemoteControllerRadioData.h"
//#import "yumeFileController.h"

//#import "yumeLanguage.h"

#define DEVICE_ID 0xAA

#define RESEND_DATA_TIMES_TO_DISCONNECT 3
#define TIMEOUT_SECOND 1
#define CHECK_CONNECT_PERIOD 0.2

#ifndef DLog
#define DLog(...) /* */
#endif

typedef NSData*(^yumeWriteToQueue)(void);
typedef char(^yumePredictionOPCode)(void);

@interface yumeBTLERemoteController ()<CBCentralManagerDelegate, CBPeripheralDelegate,UIAlertViewDelegate>{
    NSMutableArray *peripherals;
    NSMutableArray *DataQueue;
    NSMutableArray *predictionOPCodeQueue;
    NSTimer *timeoutTimer;
    NSTimer *checkConnectTimer;
    NSInteger failCount;
    NSInteger mainVersion;
    NSInteger subVersion;
    NSThread *checkConnectThread;
//    UIAlertView *enterPasswordAlertView;
}
@property (strong, nonatomic) CBCentralManager      *centralManager;
@property (strong, nonatomic) CBPeripheral          *discoveredPeripheral;
@property (strong, nonatomic) CBCharacteristic      *readCharacteristic;
@property (strong, nonatomic) CBCharacteristic      *writeCharacteristic;
@property (strong, nonatomic) NSMutableData         *data;
@end

@implementation yumeBTLERemoteController

#pragma mark - Singleton

-(instancetype)init{
    self = [super init];
    if (self) {
        // Start up the CBCentralManager
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        
        peripherals = [NSMutableArray new];
        DataQueue = [NSMutableArray new];
        predictionOPCodeQueue = [NSMutableArray new];
        timeoutTimer = [NSTimer scheduledTimerWithTimeInterval: TIMEOUT_SECOND
                                                        target: self
                                                      selector: @selector(resendWriteData:)
                                                      userInfo: nil
                                                       repeats: NO];
        [timeoutTimer invalidate];
        failCount = 0;
        
        self.parameterDatas = [yumeRCPDRemoteControllerParameterData new];
        self.radioDatas = [yumeRCRDRemoteControllerRadioData new];
//        self.fileController = [yumeFileController new];
        //discoveredPeripheral
        //readCharacteristic
        //writeCharacteristic
        _data = [[NSMutableData alloc] init];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sendData:) name:@"sendData" object:self];
    }
    return self;
}

+(yumeBTLERemoteController*) sharedInstance{
    static yumeBTLERemoteController *sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [yumeBTLERemoteController new];
    });
    
    return sharedInstance;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"sendData" object:self];
}

#pragma mark - Self Define function

-(void)startScan{
    if (_centralManager.state == CBCentralManagerStatePoweredOn) {
        DLog(@"scan");
        [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    }
}

-(void)startScanWithShowDeviceList{
    
    [[yumeBTLERemoteController sharedInstance] clearPeripherals];
    [[yumeBTLERemoteController sharedInstance] startScan];
    
    yumeDeviceListAlertTableView *deviceListAlertTableView = [[yumeDeviceListAlertTableView alloc]initWithTitle:NSLocalizedString(@"Device List", nil)
                                                                                                        message:nil
                                                                                                       delegate:nil
                                                                                              cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                                                                              otherButtonTitles:nil];
    [deviceListAlertTableView show];
}

-(void)clearPeripherals{
    [peripherals removeAllObjects];
}

-(NSArray*)loadPeripherals{
    return peripherals;
}

-(void)connectToPeripheralWithIndex:(NSInteger)index{
    CBPeripheral *peripheral = peripherals[index];
    self.discoveredPeripheral = peripheral;
    [self.centralManager connectPeripheral:peripheral options:nil];
}

-(void)writeDataToPeripheral:(NSData*)data{
    if (self.writeCharacteristic == nil) {
        [self disconnet];
        return;
    }
    
    DLog(@"Write data:%@",data);
    
    [self.discoveredPeripheral writeValue:data
                        forCharacteristic:self.writeCharacteristic
                                     type:CBCharacteristicWriteWithResponse];
    
    timeoutTimer = [NSTimer scheduledTimerWithTimeInterval: TIMEOUT_SECOND
                                                    target: self
                                                  selector: @selector(resendWriteData:)
                                                  userInfo: nil
                                                   repeats: NO];
}

-(void)enqueueDataToQueue:(NSData*)wData prediction:(char)prediction{
    
    if (self.discoveredPeripheral == nil) {
        return;
    }
    
    yumeWriteToQueue data = ^NSData *{
        return wData;
    };
    
    yumePredictionOPCode predictionOPCode = ^char{
        return prediction;
    };
    
    [DataQueue addObject:data];
    [predictionOPCodeQueue addObject:predictionOPCode];
    
    if (DataQueue.count == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sendData" object:self];
    }
}

-(void)stopScan{
    [self.centralManager stopScan];
}

-(void)disconnet{
    
    [DataQueue removeAllObjects];
    [predictionOPCodeQueue removeAllObjects];
    [timeoutTimer invalidate];
    //    [checkConnectTimer invalidate];
    [checkConnectThread cancel];
    failCount = 0;
    
    //    self.settingDatas = nil;
    //    self.parameterDatas = nil;
    self.parameterDatas = [yumeRCPDRemoteControllerParameterData new];
    if (self.discoveredPeripheral != nil && self.readCharacteristic!= nil) {
        [self.discoveredPeripheral setNotifyValue:NO forCharacteristic:self.readCharacteristic];
    }
    self.readCharacteristic = nil;
    self.writeCharacteristic = nil;
    //    if (self.discoveredPeripheral != nil && self.discoveredPeripheral.state == CBPeripheralStateConnected) {
    if (self.discoveredPeripheral != nil) {
        [self.centralManager cancelPeripheralConnection:self.discoveredPeripheral];
    }
    self.discoveredPeripheral = nil;
    
//    if (self.rootVC) {
//        [self.rootVC.navigationController popToRootViewControllerAnimated:YES];
//        [self.rootVC setLabelDeviceText:[NSString stringWithFormat:@" "]];
//        [self.rootVC lockButtonWhenDisconnect];
//    }
}

-(void)pause{
    [timeoutTimer invalidate];
    [checkConnectTimer invalidate];
    [checkConnectThread cancel];
    failCount = 0;
    [_data setLength:0];
}

-(void)play{
    checkConnectThread = [[NSThread alloc]initWithTarget:self selector:@selector(threadCheckConnect) object:nil];
    [checkConnectThread start];
    [self resendWriteData:nil];
}

#pragma mark - Timer

- (void) resendWriteData: (NSTimer *) timer{
    
    if (timer) {
        DLog(@"Time Out!");
    }
    
    failCount++;
    [self.data setLength:0];
    if (failCount == RESEND_DATA_TIMES_TO_DISCONNECT) {
        [self disconnet];
        return;
    }else{
        DLog(@"Resend data failCount:%ld",(long)failCount);
        [self sendData:nil];
    }
}

- (void) sendCheckConnectData: (NSTimer *) timer{
    if ([DataQueue count] != 0) {
        return;
    }
    
//    NSData *data;
}

#pragma mark - Notification

-(void)sendData:(NSNotification*) notification {
    id data = [DataQueue firstObject];
    if (data) {
        NSData *wData = ((yumeWriteToQueue)data)();
        [self writeDataToPeripheral:wData];
    }
}

#pragma mark - Centralmanager methods

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state != CBCentralManagerStatePoweredOn) {
        return;
    }
    DLog(@"CBCentralManagerStatePoweredOn");
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    [peripherals addObject:peripheral];
    DLog(@"Discovered %@ at %@ UUID:%@ Service:%@", peripheral.name, RSSI,peripheral.identifier,peripheral.services);
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    DLog(@"Failed to connect to %@. (%@)", peripheral, [error localizedDescription]);
    //    [self cleanup];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    DLog(@"Peripheral Connected %@",peripheral);
    
    // Stop scanning
    [self.centralManager stopScan];
    DLog(@"Scanning stopped");
    
    // Clear the data that we may already have
    [self.data setLength:0];
    
    // Make sure we get the discovery callbacks
    peripheral.delegate = self;
    
    // Search only for services that match our UUID
    [peripheral discoverServices:nil];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error) {
        DLog(@"Error discovering services: %@", [error localizedDescription]);
        //        [self cleanup];
        return;
    }
    
    DLog(@"Find Services : %@",peripheral.services);
    
    for (CBService *service in peripheral.services) {
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"49535343-FE7D-4AE5-8FA9-9FAFD205E455"]]) {
            [peripheral discoverCharacteristics:nil
                                     forService:service];
        }
        
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error) {
        DLog(@"Error discovering characteristics: %@", [error localizedDescription]);
        //        [self cleanup];
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        
        DLog(@"find characteristic UUID:%@",characteristic.UUID);
        
        //FFF1 Notify
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"49535343-1E4D-4BD9-BA61-23C647249616"]]) {
            DLog(@"find Notify ");
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            self.readCharacteristic = characteristic;
        }
        
        //FFF2 Write
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"49535343-8841-43F4-A8D4-ECBE34729BB3"]]) {
            DLog(@"find Write characteristic");
            self.writeCharacteristic = characteristic;
        }
        
    }
    
    //#warning 如果有write 以及 read
    if(self.readCharacteristic != nil && self.writeCharacteristic != nil){
        NSData* data1 = [yumeRemoteControllerDeviceProtocol askDevice];
        [self enqueueDataToQueue:data1 prediction:0];
        
        data1 = [yumeRemoteControllerDeviceProtocol askVersion];
        [self enqueueDataToQueue:data1 prediction:8];
        
        NSData *data = [yumeRemoteControllerDeviceProtocol readParameters];
        [self enqueueDataToQueue:data prediction:21];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        DLog(@"Error discovering characteristics: %@", [error localizedDescription]);
        return;
    }
    
    [self processData:characteristic.value];
}

-(void)processData:(NSData *)rData{
    DLog(@"R data:%@ length:%lu",rData,(unsigned long)rData.length);
    [self.data appendData:rData];
    
    //How to convert NSData to byte array in iPhone?
    //Source : http://stackoverflow.com/questions/724086/how-to-convert-nsdata-to-byte-array-in-iphone
    NSUInteger len = [self.data length];
    Byte *byteData = (Byte*)malloc(len);
    memcpy(byteData, [self.data bytes], len);
    
    if ([yumeRemoteControllerDeviceProtocol isValidHeader:byteData]) {
        [self processAPSMDevicePacket];
    }else{
        
    }
}

-(void)processAPSMDevicePacket{
    
    short len = [yumeRemoteControllerDeviceProtocol retrieveLength:self.data];
    if ((len + 6) != self.data.length) {
        return;
    }
    
    id predictionOPCode = [predictionOPCodeQueue firstObject];
    if (!predictionOPCode) {
        return;
    }
    
    devicePacket* packet = [yumeRemoteControllerDeviceProtocol receivePacket:self.data];
    char command = ((yumePredictionOPCode)predictionOPCode)();
    if (command != packet->deviceHeader.command) {
        [self resendDataWithTimer];
    }

    if (command == COMMAND_ASK_DEVICE){
        //check gpro version
        DLog(@"command 0:%d",packet->typeASKDeviceID.revVersion);
        if (packet->typeASKDeviceID.revVersion != DEVICE_ID) {
            [self disconnet];
            return;
        }
    }else if (command == COMMAND_ASK_VERSION){
        DLog(@"command 8:%d.%d.%d",packet->typeSetting.mainVersion,packet->typeSetting.subVersion,packet->typeSetting.revVersion);
        mainVersion = packet->typeSetting.mainVersion;
        subVersion = packet->typeSetting.subVersion;
    }else if (command == COMMAND_SEND_PASSWORD){
        DLog(@"command 10:%d",packet->typeAck.ack);
        if (packet->typeAck.ack == ACK_SUCCESS) {
            
            NSData *data = [yumeRemoteControllerDeviceProtocol readParameters];
            [self enqueueDataToQueue:data prediction:21];
            
            checkConnectThread = [[NSThread alloc]initWithTarget:self selector:@selector(threadCheckConnect) object:nil];
            [checkConnectThread start];
        }else if (packet->typeAck.ack == ACK_FAIL || packet->typeAck.ack == ACK_OUT_OF_RANGE){
            UIAlertView *passwordFailAlertView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Password Failed",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"Yes",nil) otherButtonTitles: nil];
            [passwordFailAlertView show];
            [self disconnet];
            return;
        }
    }else if (command == COMMAND_RADIO){
        [self.radioDatas setDataWithPacket:packet->typeRadios];
        [NotificationCenter postNotificationName:@"radioData" object:self];
    }else if (command == COMMAND_READ_PARAMETERS){
        [self.parameterDatas setDataWithPacket:packet->typeParameters];
    }else if (command == COMMAND_SAVE_PARAMETERS || command == COMMAND_UPDATE_PARAMETER || command == COMMAND_DEFAULT_PARAMETER){
        if (packet->typeAck.ack == ACK_SUCCESS) {
            
        }else if (packet->typeAck.ack == ACK_FAIL) {
            
        }else if (packet->typeAck.ack == ACK_OUT_OF_RANGE) {
            
        }
    }
    
    
    [self dequeueDataFromQueueWithCleanBufferAndTimer];
    [self dequeueNextDataFromQueueIfExist];
    
}

-(void)dequeueDataFromQueueWithCleanBufferAndTimer{
    [timeoutTimer invalidate];
    [self.data setLength:0];
    [DataQueue removeObjectAtIndex:0];
    [predictionOPCodeQueue removeObjectAtIndex:0];
    failCount = 0;
}

-(void)dequeueNextDataFromQueueIfExist{
    if (DataQueue.count != 0) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"sendData" object:self];
    }
}

-(void)resendDataWithTimer{
    
    DLog(@"Recieve Wrong command pair");
    
    [self.data setLength:0];
    
    [timeoutTimer invalidate];
    DLog(@"Time Out");
    timeoutTimer = [NSTimer scheduledTimerWithTimeInterval: 0
                                                    target: self
                                                  selector: @selector(resendWriteData:)
                                                  userInfo: nil
                                                   repeats: NO];
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        DLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    
    // Exit if it's not the transfer characteristic
    //    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
    //        return;
    //    }
    
    // Notification has started
    if (characteristic.isNotifying) {
        DLog(@"Notification began on %@", characteristic);
    }
    
    // Notification has stopped
    else {
        // so disconnect from the peripheral
        DLog(@"Notification stopped on %@.  Disconnecting", characteristic);
        [self.centralManager cancelPeripheralConnection:peripheral];
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    DLog(@"Peripheral Disconnected");
    [self disconnet];
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        DLog(@"Error writing characteristic value: %@",
             [error localizedDescription]);
    }
}

#pragma mark - Thread Method

-(void)threadCheckConnect{
    while (!checkConnectThread.isCancelled) {
        [self performSelectorOnMainThread:@selector(sendCheckConnectData:) withObject:nil waitUntilDone:YES];
        
        [NSThread sleepForTimeInterval:CHECK_CONNECT_PERIOD];
    };
}

#pragma mark - UIAlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (alertView == enterPasswordAlertView) {
//        if (buttonIndex == 1) {
//            NSString *stringPassword = [alertView textFieldAtIndex:0].text;
//            int32_t password = (int32_t)[stringPassword integerValue];
//            
//            if ((stringPassword.length == 4) && (0 <= password) && (password <= 9999)) {
//                NSData* data = [yumeRemoteControllerDeviceProtocol sendPassword:password];
//                DLog(@"pass:%@",data);
//                [self writeDataToQueue:data prediction:10];
//            }else{
//                UIAlertView *passwordFailAlertView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Password Failed",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"Yes",nil) otherButtonTitles: nil];
//                [passwordFailAlertView show];
//                [self disconnet];
//                return;
//            }
//        }else if (buttonIndex == 0){
//            [self disconnet];
//            return;
//        }
//    }
}
@end
