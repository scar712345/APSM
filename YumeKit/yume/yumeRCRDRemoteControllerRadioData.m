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

#define RCP_ALLOC [yumeRCPRemoteControllerRadio alloc]

-(id)init{
    self = [super init];
    if (self) {
        _Ale                    = [RCP_ALLOC initWithDictionary:@{@"min":@(-1000),@"max":@(1000)}];
        _Ele                    = [RCP_ALLOC initWithDictionary:@{@"min":@(-1000),@"max":@(1000)}];
        _Thr                    = [RCP_ALLOC initWithDictionary:@{@"min":@(-1000),@"max":@(1000)}];
        _Rud                    = [RCP_ALLOC initWithDictionary:@{@"min":@(-1000),@"max":@(1000)}];
        _Ger                    = [RCP_ALLOC initWithDictionary:@{@"min":@(-1000),@"max":@(1000)}];
        _Pit                    = [RCP_ALLOC initWithDictionary:@{@"min":@(-1000),@"max":@(1000)}];
        _Aux1                   = [RCP_ALLOC initWithDictionary:@{@"min":@(-1000),@"max":@(1000)}];
        _Aux2                   = [RCP_ALLOC initWithDictionary:@{@"min":@(-1000),@"max":@(1000)}];
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
