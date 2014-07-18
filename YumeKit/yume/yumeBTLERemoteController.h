//
//  yumeBTLERemoteController.h
//  BT_Central
//
//  Created by Yume on 2014/4/18.
//  Copyright (c) 2014年 Yume. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCUPacketDevice.h"

@class yumeRCPDRemoteControllerParameterData;
@class yumeRCRDRemoteControllerRadioData;
//@class yumeFileController;

@interface yumeBTLERemoteController : NSObject
@property (nonatomic,strong) yumeRCPDRemoteControllerParameterData *parameterDatas;
@property (nonatomic,strong) yumeRCRDRemoteControllerRadioData *radioDatas;
//@property (nonatomic,strong) yumeFileController *fileController;
//@property (nonatomic,weak) FGXBluetoothDataViewController *rootVC;
+(yumeBTLERemoteController*) sharedInstance;

#pragma mark - Self Define function
-(void)startScanWithShowDeviceList;
-(void)clearPeripherals;
-(NSArray*)loadPeripherals;
-(void)connectToPeripheralWithIndex:(NSInteger)index;
-(void)enqueueDataToQueue:(NSData*)wData prediction:(char)prediction;
-(void)stopScan;
-(void)disconnet;

-(void)pause;
-(void)play;
@end
