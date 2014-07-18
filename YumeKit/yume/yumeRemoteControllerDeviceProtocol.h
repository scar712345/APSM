//
//  yumeRemoteControllerDeviceProtocol.h
//  test
//
//  Created by Yume on 2014/5/22.
//  Copyright (c) 2014年 Yume. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCUPacketDevice.h"

@interface yumeRemoteControllerDeviceProtocol : NSObject

#pragma mark - Send Packet
+(NSMutableData*)askDevice;
+(NSMutableData*)askVersion;
+(NSMutableData*)sendPassword:(int32_t)password;
+(NSMutableData*)radio;
+(NSMutableData*)readParameters;
+(NSMutableData*)saveParameters:(devicePacketParameters)parameters;
+(NSMutableData*)updateParameterWithIndex:(float)index WithValue:(float)value;
+(NSMutableData*)defaultParameter;

#pragma mark - Receive Packet
+(devicePacket*)receivePacket:(NSData*)data;

#pragma mark - Retrieve Data
+(short)retrieveLength:(NSData*)data;

+(BOOL)isValidHeader:(Byte[])header;
@end
