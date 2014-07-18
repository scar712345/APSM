//
//  yumeRCPDRemoteControllerParameterData.h
//  BT_Central
//
//  Created by APP559 on 2014/4/29.
//  Copyright (c) 2014年 Yume. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCUPacketDevice.h"

@class yumeRCPRemoteControllerParameter;

@interface yumeRCPDRemoteControllerParameterData : NSObject

@property(nonatomic,strong) yumeRCPRemoteControllerParameter* multiRotorMode;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* CMDSource;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* SPK_Binding;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* p;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* q;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* r;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* phi;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* theta;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* psi;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* altitude;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* AntX;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* AntY;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* AntZ;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* LPLevel1_Enable;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* LPLevel1_Voltage;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* LPLevel2_Enable;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* LPLevel2_Voltage;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* AilDir;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* EleDir;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* ThrDir;
@property(nonatomic,strong) yumeRCPRemoteControllerParameter* RudDir;

-(void)setDataWithPacket:(devicePacketParameters)packet;
-(devicePacketParameters)getPacket;
@end
