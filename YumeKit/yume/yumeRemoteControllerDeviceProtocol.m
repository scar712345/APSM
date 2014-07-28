//
//  yumeRemoteControllerDeviceProtocol.m
//  test
//
//  Created by Yume on 2014/5/22.
//  Copyright (c) 2014年 Yume. All rights reserved.
//

#import "yumeRemoteControllerDeviceProtocol.h"

@implementation yumeRemoteControllerDeviceProtocol

#pragma mark - Send Packet

+(NSMutableData*)structToNSMutableData:(void*)packet size:(size_t)size{
    NSMutableData *data = [NSMutableData new];
    [data appendData:[NSData dataWithBytes:packet length:size]];
    return data;
}

+(NSMutableData*)askDevice{
    
    devicePacket packet = {PACKET_HEADER_HEAD,0,PACKET_HEADER_DEVICE_ID_UNKNOWN,COMMAND_ASK_DEVICE,0};
    
    size_t headerSize = sizeof(packet.deviceHeader);
    size_t contentSize = 0;
    size_t size = headerSize + contentSize;
    packet.deviceHeader.len = contentSize;
    
    packet.deviceHeader.checksum = [self checksumWithBytes:(Byte *)&packet.deviceHeader WithSize:(int)size];
    
    return [self structToNSMutableData:&packet size:size];
}

+(NSMutableData*)askVersion{
    
    devicePacket packet = {PACKET_HEADER_HEAD,0,PACKET_HEADER_DEVICE_ID_APSM,COMMAND_ASK_VERSION,0};
    
    size_t headerSize = sizeof(packet.deviceHeader);
    size_t contentSize = 0;
    size_t size = headerSize + contentSize;
    packet.deviceHeader.len = contentSize;
    
    packet.deviceHeader.checksum = [self checksumWithBytes:(Byte *)&packet.deviceHeader WithSize:(int)size];
    
    return [self structToNSMutableData:&packet size:size];
}

+(NSMutableData*)sendPassword:(int32_t)password{
    
    devicePacket packet = {PACKET_HEADER_HEAD,0,PACKET_HEADER_DEVICE_ID_APSM,COMMAND_SEND_PASSWORD,4};
    
    packet.typeSendPassword.password = password;
    size_t headerSize = sizeof(packet.deviceHeader);
    size_t contentSize = sizeof(packet.typeSendPassword.password);
    size_t size = headerSize + contentSize;
    packet.deviceHeader.len = contentSize;
    
    packet.deviceHeader.checksum = [self checksumWithBytes:(Byte *)&packet.deviceHeader WithSize:(int)size];
    
    return [self structToNSMutableData:&packet size:size];
}

+(NSMutableData*)radio{
    
    devicePacket packet = {PACKET_HEADER_HEAD,0,PACKET_HEADER_DEVICE_ID_APSM,COMMAND_RADIO,0};
    
    size_t headerSize = sizeof(packet.deviceHeader);
    size_t contentSize = 0;
    size_t size = headerSize + contentSize;
    packet.deviceHeader.len = contentSize;

    packet.deviceHeader.checksum = [self checksumWithBytes:(Byte *)&packet.deviceHeader WithSize:(int)size];
    
    return [self structToNSMutableData:&packet size:size];
}

+(NSMutableData*)readParameters{
    
    devicePacket packet = {PACKET_HEADER_HEAD,0,PACKET_HEADER_DEVICE_ID_APSM,COMMAND_READ_PARAMETERS,0};

    size_t headerSize = sizeof(packet.deviceHeader);
    size_t contentSize = 0;
    size_t size = headerSize + contentSize;
    packet.deviceHeader.len = contentSize;
    
    packet.deviceHeader.checksum = [self checksumWithBytes:(Byte *)&packet.deviceHeader WithSize:(int)size];
    
    return [self structToNSMutableData:&packet size:size];
}

+(NSMutableData*)saveParameters:(devicePacketParameters)parameters{
    
    devicePacket packet = {PACKET_HEADER_HEAD,0,PACKET_HEADER_DEVICE_ID_APSM,COMMAND_SAVE_PARAMETERS,4 * 37};
    
    packet.typeParameters = parameters;
    size_t headerSize = sizeof(packet.deviceHeader);
    size_t contentSize = sizeof(packet.typeParameters);
    size_t size = headerSize + contentSize;
    packet.deviceHeader.len = contentSize;
    
    packet.deviceHeader.checksum = [self checksumWithBytes:(Byte *)&packet.deviceHeader WithSize:(int)size];
    
    return [self structToNSMutableData:&packet size:size];
}

+(NSMutableData*)updateParameterWithIndex:(float)index WithValue:(float)value{
    
    devicePacket packet = {PACKET_HEADER_HEAD,0,PACKET_HEADER_DEVICE_ID_APSM,COMMAND_UPDATE_PARAMETER,8};
    
    packet.typeSingleParameter.index = index;
    packet.typeSingleParameter.value = value;
    size_t headerSize = sizeof(packet.deviceHeader);
    size_t contentSize = sizeof(packet.typeSingleParameter);
    size_t size = headerSize + contentSize;
    packet.deviceHeader.len = contentSize;
    
    packet.deviceHeader.checksum = [self checksumWithBytes:(Byte *)&packet.deviceHeader WithSize:(int)size];
    
    return [self structToNSMutableData:&packet size:size];
}

+(NSMutableData*)defaultParameter{
    
    devicePacket packet = {PACKET_HEADER_HEAD,0,PACKET_HEADER_DEVICE_ID_APSM,COMMAND_DEFAULT_PARAMETER,0};

    size_t headerSize = sizeof(packet.deviceHeader);
    size_t contentSize = 0;
    size_t size = headerSize + contentSize;
    packet.deviceHeader.len = contentSize;
    
    packet.deviceHeader.checksum = [self checksumWithBytes:(Byte *)&packet.deviceHeader WithSize:(int)size];
    
    return [self structToNSMutableData:&packet size:size];
}

#pragma mark - Receive Packet

+(devicePacket*)receivePacket:(NSData*)data{
    if (![self isValidPacket:data]) {
        //        DLog(@"Invalid Packet");
        return NULL;
    }
    
    static devicePacket packet = {0};
    NSInteger length = [self retrieveLength:data] + 6;
    [data getBytes: &packet length:length];
    
    Byte checkSum =[self checksumWithBytes:(Byte *)&packet WithSize:(int)length];
    if (checkSum == packet.deviceHeader.checksum) {
        return &packet;
    }else{
        return NULL;
    }
}

#pragma mark - Retrieve Data

+(Byte)retrieveOPCode:(NSData*)data{
    Byte OPCode;
    [data getBytes:&OPCode range:NSMakeRange(3, 1)];
    return OPCode;
}

+(short)retrieveLength:(NSData*)data{
    if (data.length <= 5) {
        return 0;
    }
    short length;
    [data getBytes:&length range:NSMakeRange(4, 2)];
    return length;
}


#pragma mark - Check Methods

+(Byte)checksumWithBytes:(Byte[])datas WithSize:(int)size{
    Byte sum = 0x21;
//    sum ^= PACKET_HEADER_HEAD;
    for (int index = 2; index < size; index++) {
        sum ^= datas[index];
    }
    
    return sum;
}

//計算出checksum
+(Byte)checksum:(NSMutableData*)data{
    
    if ([data length] == 0) {
        return 0;
    }
    
    Byte sum = 0x21;
    sum ^= PACKET_HEADER_HEAD;
    Byte aByte = 0;
    for (int index = 0; index < [data length]; index++) {
        [data getBytes:&aByte range:NSMakeRange(index, 1)];
        sum ^= aByte;
    }
    
    return sum;
}

+(BOOL)isValidPacket:(NSData*)data{
    
    Byte head;
    [data getBytes:&head range:NSMakeRange(0, 1)];
    if (![self isValidHeader:&head]) {
        return NO;
    }
    
//    if (![self isDataHaveValidChecksum:data]) {
//        return NO;
//    }
    
    return YES;
}

+(BOOL)isValidHeader:(Byte[])header{
    
    if (header[0] != PACKET_HEADER_HEAD) {
        return NO;
    }

    return YES;
}

//+(BOOL)isDataHaveValidChecksum:(NSData*)data{
//    Byte sum = 0;
//    Byte aByte;
//    Byte checksum;
//    [data getBytes:&checksum range:NSMakeRange([data length] - 1, 1)];
//    
//    for (int index = 0; index < [data length] - 1; index++) {
//        [data getBytes:&aByte range:NSMakeRange(index, 1)];
//        sum += aByte;
//    }
//    
//    if (sum == checksum) {
//        return YES;
//    }else{
//        return NO;
//    }
//}

//+(BOOL)isValidOPCode:(Byte)OPCode{
//    switch (OPCode) {
//        case 'A':
//        case 'B':
//        case 'C':
//        case 'S':
//        case 'P':
//        case 'R':
//            return YES;
//            break;
//        default:
//            return NO;
//            break;
//    }
//}
@end
