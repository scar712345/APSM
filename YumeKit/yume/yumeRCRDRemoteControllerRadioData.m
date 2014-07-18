//
//  yumeRCRDRemoteControllerRadioData.m
//  test
//
//  Created by ALIGN-APP on 2014/5/14.
//  Copyright (c) 2014年 ALIGN-APP. All rights reserved.
//

#import "yumeRCRDRemoteControllerRadioData.h"
#import "yumeRCPRemoteControllerRadio.h"

@implementation yumeRCRDRemoteControllerRadioData

-(id)init{
    self = [super init];
    if (self) {
        _Ale                    = [[yumeRCPRemoteControllerRadio alloc]initWithMin:324 WithMax:1724 WithZoom:7 WithOffset:1024];                //  0
        _Ele                    = [[yumeRCPRemoteControllerRadio alloc]initWithMin:324 WithMax:1724 WithZoom:7 WithOffset:1024];                //  1
        _Thr                    = [[yumeRCPRemoteControllerRadio alloc]initWithMin:324 WithMax:1724 WithZoom:7 WithOffset:1024];                //  2
        _Rud                    = [[yumeRCPRemoteControllerRadio alloc]initWithMin:324 WithMax:1724 WithZoom:7 WithOffset:1024];                //  3
        _Ger                    = [[yumeRCPRemoteControllerRadio alloc]initWithMin:324 WithMax:1724 WithZoom:7 WithOffset:1024];                //  4
        _Pit                    = [[yumeRCPRemoteControllerRadio alloc]initWithMin:324 WithMax:1724 WithZoom:7 WithOffset:1024];                //  5
        _Aux1                   = [[yumeRCPRemoteControllerRadio alloc]initWithMin:324 WithMax:1724 WithZoom:7 WithOffset:1024];                //  6
        _Aux2                   = [[yumeRCPRemoteControllerRadio alloc]initWithMin:324 WithMax:1724 WithZoom:7 WithOffset:1024];                //  7
    }
    return self;
}

-(void)setDataWithPacket:(devicePacketRadios)packet{
    self.Ale.valueMCU                   = packet.Aileron;
    self.Ele.valueMCU                   = packet.Elevator;
    self.Thr.valueMCU                   = packet.Throttle;
    self.Rud.valueMCU                   = packet.Rudder;
    self.Ger.valueMCU                   = packet.Gear_Mode;
    self.Pit.valueMCU                   = packet.Pitch_Return_Home;
    self.Aux1.valueMCU                  = packet.Aux1_Smart;
    self.Aux2.valueMCU                  = packet.Aux2;
}

@end
