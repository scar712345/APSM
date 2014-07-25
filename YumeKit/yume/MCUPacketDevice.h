//
//  MCUPacketDevice.h
//  test
//
//  Created by Yume on 2014/5/22.
//  Copyright (c) 2014年 Yume. All rights reserved.
//

#ifndef test_MCUPacketDevice_h
#define test_MCUPacketDevice_h

#define ACK_FAIL 0
#define ACK_SUCCESS 1
#define ACK_OUT_OF_RANGE 2

#define COMMAND_ASK_DEVICE 0
#define COMMAND_ASK_VERSION 8
#define COMMAND_SEND_PASSWORD 10
#define COMMAND_RADIO 20
#define COMMAND_READ_PARAMETERS 21
#define COMMAND_SAVE_PARAMETERS 22
#define COMMAND_UPDATE_PARAMETER 23
#define COMMAND_DEFAULT_PARAMETER 24

#define PACKET_HEADER_HEAD 0x3F
#define PACKET_HEADER_DEVICE_ID_UNKNOWN 0
#define PACKET_HEADER_DEVICE_ID_APSM 0xAA

#pragma pack(1)
typedef struct {
    Byte head;
    Byte checksum;
    Byte deviceID;
    Byte command;
    short len;
} devicePacketHeader;

typedef struct {
    uint8_t revVersion;
} devicePacketAskDeviceID;

typedef struct {
    uint16_t revVersion;
    uint8_t subVersion;
    uint8_t mainVersion;
} devicePacketSetting;

typedef struct {
    int32_t password;
} devicePacketPassword;

typedef struct {
    float Aileron;
    float Elevator;
    float Throttle;
    float Rudder;
    float Gear_Mode;
    float Pitch_Return_Home;
    float Aux1_Smart;
    float Aux2;
} devicePacketRadios;

typedef struct {
    float multiRotorMode;
    float CMDSource;
    float SPK_Binding;
    float p;
    float q;
    float r;
    float phi;
    float theta;
    float psi;
    float altitude;
    float AntX;
    float AntY;
    float AntZ;
    float LPLevel1_Enable;
    float LPLevel1_Voltage;
    float LPLevel2_Enable;
    float LPLevel2_Voltage;
    float AilDir;
    float EleDir;
    float ThrDir;
    float RudDir;
    float OSD_Unit;
    float OSD_VideoFormat;
    float OSD_VoltageEnable;
    float OSD_VoltageWarning;
    float OSD_DistanceEnable;
    float OSD_DistanceWarning;
    float OSD_HeightEnable;
    float OSD_HeightHWarning;
    float OSD_HeightLWarning;
    float OSD_SatelliteEnable;
    float OSD_SatelliteWarning;
    float OSD_VisionAngle;
    float OSD_ScreenHOffSet;
    float OSD_ScreenVOffSet;
    float OSD_ShowPosition;
    float FlightMode;
} devicePacketParameters;

typedef struct {
    float index;
    float value;
} devicePacketSingleParameter;

typedef struct {
    Byte ack;
} devicePacketAck;

typedef struct{
    devicePacketHeader deviceHeader;
    union{
        devicePacketAskDeviceID typeASKDeviceID;
        devicePacketSetting typeSetting;
        devicePacketPassword typeSendPassword;
        devicePacketRadios typeRadios;
        devicePacketParameters typeParameters;
        devicePacketSingleParameter typeSingleParameter;
        devicePacketAck typeAck;
    };
}devicePacket;
#endif
