//
//  yumeRCPDRemoteControllerParameterData.m
//  BT_Central
//
//  Created by APP559 on 2014/4/29.
//  Copyright (c) 2014年 Yume. All rights reserved.
//

#import "yumeRCPDRemoteControllerParameterData.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"
#import "yumeRemoteControllerDeviceProtocol.h"

@implementation yumeRCPDRemoteControllerParameterData

-(id)init{
    self = [super init];
    if (self) {
        
//        0: QuadX, 1: QuadP, 2: HexX, 3: HexP
        _multiRotorMode      = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@0,
                                                                                              @"default":@0,
                                                                                              @"max"    :@3,
                                                                                              @"index"  :@0}];
        
//        0: SBus, 1: Traditional, 2: SPK DMS2, 3: SPK DMSX, 4: Xbus, 5: JR DMSS, 6: FlySky
        _CMDSource           = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@0,
                                                                                              @"default":@0,
                                                                                              @"max"    :@5,
                                                                                              @"index"  :@1}];

        _SPK_Binding         = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@50,
                                                                                              @"default":@100,
                                                                                              @"max"    :@300,
                                                                                              @"index"  :@2}];

        _p                   = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@50,
                                                                                              @"default":@100,
                                                                                              @"max"    :@300,
                                                                                              @"index"  :@3}];

        _q                   = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@50,
                                                                                              @"default":@100,
                                                                                              @"max"    :@300,
                                                                                              @"index"  :@4}];

        _r                   = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@50,
                                                                                              @"default":@100,
                                                                                              @"max"    :@300,
                                                                                              @"index"  :@5}];

        _phi                 = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@50,
                                                                                              @"default":@100,
                                                                                              @"max"    :@300,
                                                                                              @"index"  :@6}];

        _theta               = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@50,
                                                                                              @"default":@100,
                                                                                              @"max"    :@300,
                                                                                              @"index"  :@7}];

        _psi                 = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@50,
                                                                                              @"default":@100,
                                                                                              @"max"    :@300,
                                                                                              @"index"  :@8}];

        _altitude            = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@50,
                                                                                              @"default":@100,
                                                                                              @"max"    :@300,
                                                                                              @"index"  :@9}];

        _AntX                = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(-1000),
                                                                                              @"default":@0,
                                                                                              @"max"    :@1000,
                                                                                              @"index"  :@10}];

        _AntY                = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(-1000),
                                                                                              @"default":@0,
                                                                                              @"max"    :@1000,
                                                                                              @"index"  :@11}];
        
        _AntZ                = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(-1000),
                                                                                              @"default":@0,
                                                                                              @"max"    :@1000,
                                                                                              @"index"  :@12}];

        _LPLevel1_Enable     = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@0,
                                                                                              @"default":@0,
                                                                                              @"max"    :@1,
                                                                                              @"index"  :@13}];

        _LPLevel1_Voltage    = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@3,
                                                                                              @"default":@3.7,
                                                                                              @"max"    :@3.9,
                                                                                              @"index"  :@14}];

        _LPLevel2_Enable     = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@0,
                                                                                              @"default":@0,
                                                                                              @"max"    :@1,
                                                                                              @"index"  :@15}];

        _LPLevel2_Voltage    = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@3,
                                                                                              @"default":@3.7,
                                                                                              @"max"    :@3.9,
                                                                                              @"index"  :@16}];
        
        _AilDir              = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(-1),
                                                                                              @"default":@1,
                                                                                              @"max"    :@1,
                                                                                              @"index"  :@17}];

        _EleDir              = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(-1),
                                                                                              @"default":@1,
                                                                                              @"max"    :@1,
                                                                                              @"index"  :@18}];

        _ThrDir              = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(-1),
                                                                                              @"default":@1,
                                                                                              @"max"    :@1,
                                                                                              @"index"  :@19}];

        _RudDir              = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(-1),
                                                                                              @"default":@1,
                                                                                              @"max"    :@1,
                                                                                              @"index"  :@20}];
        
        
        
        _OSD_Unit               = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(0),
                                                                                                 @"default":@0,
                                                                                                 @"max"    :@1,
                                                                                                 @"index"  :@21}];
        
        _OSD_VideoFormat        = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(0),
                                                                                                 @"default":@0,
                                                                                                 @"max"    :@1,
                                                                                                 @"index"  :@22}];
        
        _OSD_VoltageEnable      = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(0),
                                                                                                 @"default":@0,
                                                                                                 @"max"    :@1,
                                                                                                 @"index"  :@23}];
        
        _OSD_VoltageWarning     = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(11.1),
                                                                                                 @"default":@11.1,
                                                                                                 @"max"    :@25.4,
                                                                                                 @"index"  :@24}];
        
        _OSD_DistanceEnable     = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(0),
                                                                                                 @"default":@0,
                                                                                                 @"max"    :@1,
                                                                                                 @"index"  :@25}];
        
        _OSD_DistanceWarning    = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(0),
                                                                                                 @"default":@0,
                                                                                                 @"max"    :@100000,
                                                                                                 @"index"  :@26}];
        
        _OSD_HeightEnable       = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(0),
                                                                                                 @"default":@0,
                                                                                                 @"max"    :@1,
                                                                                                 @"index"  :@27}];
        
        _OSD_HeightHWarning     = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(0),
                                                                                                 @"default":@0,
                                                                                                 @"max"    :@100000,
                                                                                                 @"index"  :@28}];
        
        _OSD_HeightLWarning     = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(0),
                                                                                                 @"default":@0,
                                                                                                 @"max"    :@100000,
                                                                                                 @"index"  :@29}];
        
        _OSD_SatelliteEnable    = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(0),
                                                                                                 @"default":@0,
                                                                                                 @"max"    :@1,
                                                                                                 @"index"  :@30}];
        
        _OSD_SatelliteWarning   = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(5),
                                                                                                 @"default":@5,
                                                                                                 @"max"    :@32,
                                                                                                 @"index"  :@31}];
        
        _OSD_VisionAngle        = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(30),
                                                                                                 @"default":@30,
                                                                                                 @"max"    :@120,
                                                                                                 @"index"  :@32}];
        
        _OSD_ScreenHOffSet      = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(-8),
                                                                                                 @"default":@0,
                                                                                                 @"max"    :@7,
                                                                                                 @"index"  :@33}];
        
        _OSD_ScreenVOffSet      = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(-8),
                                                                                                 @"default":@0,
                                                                                                 @"max"    :@7,
                                                                                                 @"index"  :@34}];
        
        _OSD_ShowPosition       = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(0),
                                                                                                 @"default":@1,
                                                                                                 @"max"    :@1,
                                                                                                 @"index"  :@35}];
        
        _FlightMode             = [[yumeRCPRemoteControllerParameter alloc] initWithDictionary:@{@"min"    :@(1),
                                                                                                 @"default":@2,
                                                                                                 @"max"    :@2,
                                                                                                 @"index"  :@36}];

    }
    return self;
}


-(void)setDataWithPacket:(devicePacketParameters)packet{
    _multiRotorMode.valueMCU    = packet.multiRotorMode;
    _CMDSource.valueMCU         = packet.CMDSource;
    _SPK_Binding.valueMCU       = packet.SPK_Binding;
    _p.valueMCU                 = packet.p;
    _q.valueMCU                 = packet.q;
    _r.valueMCU                 = packet.r;
    _phi.valueMCU               = packet.phi;
    _theta.valueMCU             = packet.theta;
    _psi.valueMCU               = packet.psi;
    _altitude.valueMCU          = packet.altitude;
    _AntX.valueMCU              = packet.AntX;
    _AntY.valueMCU              = packet.AntY;
    _AntZ.valueMCU              = packet.AntZ;
    _LPLevel1_Enable.valueMCU   = packet.LPLevel1_Enable;
    _LPLevel1_Voltage.valueMCU  = packet.LPLevel1_Voltage;
    _LPLevel2_Enable.valueMCU   = packet.LPLevel2_Enable;
    _LPLevel2_Voltage.valueMCU  = packet.LPLevel2_Voltage;
    _AilDir.valueMCU            = packet.AilDir;
    _EleDir.valueMCU            = packet.EleDir;
    _ThrDir.valueMCU            = packet.theta;
    _RudDir.valueMCU            = packet.RudDir;
    
    _OSD_Unit.valueMCU              = packet.OSD_Unit;
    _OSD_VideoFormat.valueMCU       = packet.OSD_VideoFormat;
    _OSD_VoltageEnable.valueMCU     = packet.OSD_VoltageEnable;
    _OSD_VoltageWarning.valueMCU    = packet.OSD_VoltageWarning;
    _OSD_DistanceEnable.valueMCU    = packet.OSD_DistanceEnable;
    _OSD_DistanceWarning.valueMCU   = packet.OSD_DistanceWarning;
    _OSD_HeightEnable.valueMCU      = packet.OSD_HeightEnable;
    _OSD_HeightHWarning.valueMCU    = packet.OSD_HeightHWarning;
    _OSD_HeightLWarning.valueMCU    = packet.OSD_HeightLWarning;
    _OSD_SatelliteEnable.valueMCU   = packet.OSD_SatelliteEnable;
    _OSD_SatelliteWarning.valueMCU  = packet.OSD_SatelliteWarning;
    _OSD_VisionAngle.valueMCU       = packet.OSD_VisionAngle;
    _OSD_ScreenHOffSet.valueMCU     = packet.OSD_ScreenHOffSet;
    _OSD_ScreenVOffSet.valueMCU     = packet.OSD_ScreenVOffSet;
    _OSD_ShowPosition.valueMCU      = packet.OSD_ShowPosition;
    _FlightMode.valueMCU            = packet.FlightMode;
}

-(devicePacketParameters)getPacket{
    
    devicePacketParameters packet = {0};
    
    packet.multiRotorMode   = _multiRotorMode.valueMCU;
    packet.CMDSource        = _CMDSource.valueMCU;
    packet.SPK_Binding      = _SPK_Binding.valueMCU;
    packet.p                = _p.valueMCU;
    packet.q                = _q.valueMCU;
    packet.r                = _r.valueMCU ;
    packet.phi              = _phi.valueMCU;
    packet.theta            = _theta.valueMCU;
    packet.psi              = _psi.valueMCU;
    packet.altitude         = _altitude.valueMCU;
    packet.AntX             = _AntX.valueMCU;
    packet.AntY             = _AntY.valueMCU ;
    packet.AntZ             = _AntZ.valueMCU;
    packet.LPLevel1_Enable  = _LPLevel1_Enable.valueMCU;
    packet.LPLevel1_Voltage = _LPLevel1_Voltage.valueMCU;
    packet.LPLevel2_Enable  = _LPLevel2_Enable.valueMCU;
    packet.LPLevel2_Voltage = _LPLevel2_Voltage.valueMCU;
    packet.AilDir           = _AilDir.valueMCU;
    packet.EleDir           = _EleDir.valueMCU;
    packet.theta            = _ThrDir.valueMCU;
    packet.RudDir           = _RudDir.valueMCU;
    
    packet.OSD_Unit             = _OSD_Unit.valueMCU;
    packet.OSD_VideoFormat      = _OSD_VideoFormat.valueMCU;
    packet.OSD_VoltageEnable    = _OSD_VoltageEnable.valueMCU;
    packet.OSD_VoltageWarning   = _OSD_VoltageWarning.valueMCU;
    packet.OSD_DistanceEnable   = _OSD_DistanceEnable.valueMCU;
    packet.OSD_DistanceWarning  = _OSD_DistanceWarning.valueMCU;
    packet.OSD_HeightEnable     = _OSD_HeightEnable.valueMCU;
    packet.OSD_HeightHWarning   = _OSD_HeightHWarning.valueMCU;
    packet.OSD_HeightLWarning   = _OSD_HeightLWarning.valueMCU;
    packet.OSD_SatelliteEnable  = _OSD_SatelliteEnable.valueMCU;
    packet.OSD_SatelliteWarning = _OSD_SatelliteWarning.valueMCU;
    packet.OSD_VisionAngle      = _OSD_VisionAngle.valueMCU;
    packet.OSD_ScreenHOffSet    = _OSD_ScreenHOffSet.valueMCU;
    packet.OSD_ScreenVOffSet    = _OSD_ScreenVOffSet.valueMCU;
    packet.OSD_ShowPosition     = _OSD_ShowPosition.valueMCU;
    packet.FlightMode           = _FlightMode.valueMCU;
    
    return packet;
    
}

@end
