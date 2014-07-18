//
//  yumeRCPRemoteControllerParameter.m
//  BT_Central
//
//  Created by APP559 on 2014/4/29.
//  Copyright (c) 2014年 Yume. All rights reserved.
//

#import "yumeRCPRemoteControllerParameter.h"
#import "yumeBTLERemoteController.h"
#import "yumeRemoteControllerDeviceProtocol.h"

@interface yumeRCPRemoteControllerParameter(){
    float parameterMin;
    float parameterDefault;
    float parameterMax;
    float parameterIndex;
}
@end

@implementation yumeRCPRemoteControllerParameter
@synthesize valueMCU = _valueMCU;
@synthesize valueUI = _valueUI;

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _valueMCU = [dict[@"default"] floatValue];
        parameterMin = [dict[@"min"] floatValue];
        parameterDefault = [dict[@"default"] floatValue];
        parameterMax = [dict[@"max"] floatValue];
        parameterIndex = [dict[@"index"] floatValue];
    }
    return self;
}

#pragma mark - Setter

-(void)setValueMCU:(float)value{
    if ([self isBetweenMaxAndMin:value]) {
        _valueMCU = value;
    }
    
    return;
}

-(void)setValueUI:(float)value{
    if ([self isBetweenMaxAndMin:value]) {
        _valueMCU = value;
        NSData* data = [yumeRemoteControllerDeviceProtocol updateParameterWithIndex:parameterIndex WithValue:_valueMCU];
        [[yumeBTLERemoteController sharedInstance] enqueueDataToQueue:data prediction:23];
        
        DLog(@"\nSendding...\nPosition : %f\nValue : %f",parameterIndex,value);
    }
    
    return;
}

-(void)setValueToDefualt{
    if ([self isBetweenMaxAndMin:parameterDefault]) {
        _valueMCU = parameterDefault;
    }
    
    return;
}

#pragma mark - Getter

-(float)valueMCU{
    //value = UIvalue * zoom + offset
    return _valueMCU;
}

-(float)valueUI{
    //UIvalue = (value - offset) / value
    return _valueMCU;
}

#pragma mark - Checker

-(BOOL)isBetweenMaxAndMin:(float)value{
    if (value < parameterMin) {
        return NO;
    }
    
    if (value > parameterMax) {
        return NO;
    }
    
    return YES;
}

@end
