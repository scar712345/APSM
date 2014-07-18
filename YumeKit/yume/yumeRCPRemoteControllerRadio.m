//
//  yumeRCPRemoteControllerParameter.m
//  BT_Central
//
//  Created by APP559 on 2014/4/29.
//  Copyright (c) 2014年 Yume. All rights reserved.
//

#import "yumeRCPRemoteControllerRadio.h"
#import "yumeBTLERemoteController.h"

@interface yumeRCPRemoteControllerRadio(){
    // 矩陣位置1 , 矩陣位置2 , 預設值 , 最小值 , 最大值 , 縮放比 , 偏移量
    short valueMin;
    short valueMax;
    short valueZoom;
    short valueOffset;
}

@end

@implementation yumeRCPRemoteControllerRadio
@synthesize valueMCU = _valueMCU;
@synthesize valueUI = _valueUI;

-(id)initWithMin:(short)min WithMax:(short)max WithZoom:(short)zoom WithOffset:(short)offset{
    self = [super init];
    if (self) {
        valueMin = min;
        valueMax = max;
        valueZoom = zoom;
        valueOffset = offset;
    }
    return self;
}

#pragma mark - Setter

-(void)setValueMCU:(short)value{
//    if ([self isBetweenMaxAndMin:value]) {
        _valueMCU = value;
//        NSLog(@"Radio UI Value : %d ,Max:%d Min:%d",(_valueMCU - valueOffset) / valueZoom,[self getValueUIMax],[self getValueUIMin]);
//    }
    
    return;
}

#pragma mark - Getter

-(short)valueMCU{
    //value = UIvalue * zoom + offset
    return _valueMCU;
}

-(short)valueUI{
    //UIvalue = (value - offset) / value
    return (_valueMCU - valueOffset) / valueZoom;
}

-(short)getValueUIMax{
    return (valueMax - valueOffset) / valueZoom;
}

-(short)getValueUIMin{
    return (valueMin - valueOffset) / valueZoom;
}

#pragma mark - Checker

-(BOOL)isBetweenMaxAndMin:(short)value{
    if (value < valueMin) {
        return NO;
    }
    
    if (value > valueMax) {
        return NO;
    }
    
    return YES;
}

@end
