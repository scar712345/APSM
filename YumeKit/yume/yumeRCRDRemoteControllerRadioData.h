//
//  yumeRCRDRemoteControllerRadioData.h
//  test
//
//  Created by ALIGN-APP on 2014/5/14.
//  Copyright (c) 2014年 ALIGN-APP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCUPacketDevice.h"

@class yumeRCPRemoteControllerRadio;

//Ale, Ele, Thr, Rud, Ger, Pit, Aux1, Aux2,
//Magnet_Detect, System_Voltage, Vibration_Frequency, Vibration_Magnitude,
@interface yumeRCRDRemoteControllerRadioData : NSObject
@property(nonatomic,strong) yumeRCPRemoteControllerRadio* Ale;                      //  0
@property(nonatomic,strong) yumeRCPRemoteControllerRadio* Ele;                      //  1
@property(nonatomic,strong) yumeRCPRemoteControllerRadio* Thr;                      //  2
@property(nonatomic,strong) yumeRCPRemoteControllerRadio* Rud;                      //  3
@property(nonatomic,strong) yumeRCPRemoteControllerRadio* Ger;                      //  4
@property(nonatomic,strong) yumeRCPRemoteControllerRadio* Pit;                      //  5
@property(nonatomic,strong) yumeRCPRemoteControllerRadio* Aux1;                     //  6
@property(nonatomic,strong) yumeRCPRemoteControllerRadio* Aux2;                     //  7


-(void)setDataWithPacket:(devicePacketRadios)packet;
@end


