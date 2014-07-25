//
//  ViewSource.m
//  APSM
//
//  Created by APP559 on 2014/7/19.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "ViewSource.h"

@implementation ViewSource

+(ViewSource*) sharedInstance{
    static ViewSource *sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [ViewSource new];
    });
    
    return sharedInstance;
}
#pragma mark - APSM Page 1

-(NSDictionary*)APSMPage1View21{
    return @{@"type":@"TransmitterRadioView",
             @"labelTitle":@"AIL",
             @"labelLeft":@"Left",
             @"labelRight":@"Right"};
}

-(NSDictionary*)APSMPage1View22{
    return @{@"type":@"TransmitterRadioView",
             @"labelTitle":@"ELE",
             @"labelLeft":@"Up",
             @"labelRight":@"Down"};
}

-(NSDictionary*)APSMPage1View23{
    return @{@"type":@"TransmitterRadioView",
             @"labelTitle":@"RUD",
             @"labelLeft":@"Left",
             @"labelRight":@"Right"};
}

-(NSDictionary*)APSMPage1View24{
    return @{@"type":@"TransmitterRadioView",
             @"labelTitle":@"THR",
             @"labelLeft":@"Idle",
             @"labelRight":@"Full"};
}

-(NSDictionary*)APSMPage1View31{
    return @{@"type":@"SegmentAndSlider",
             @"itemArray":@[@"MANUAL",@"ATTITUDE",@"GPS"],
             @"adapter":^NSInteger(NSInteger value) {
                 if (-1000 <= value && value <= -551) {
                     return 0;
                 }else if (-550 <= value && value <= 449){
                     return 1;
                 }else if (450 <= value && value <= 1000){
                     return 2;
                 }else{
                     return 0;
                 }
             }};
}

-(NSDictionary*)APSMPage1View32{
    return @{@"type":@"SegmentAndSlider",
             @"itemArray":@[@"SMART",@"OFF"],
             @"adapter":^NSInteger(NSInteger value) {
                 if (-1000 <= value && value <= 0) {
                     return 0;
                 }else if (1 <= value && value <= 1000){
                     return 1;
                 }else{
                     return 0;
                 }
             }};
}

-(NSDictionary*)APSMPage1View33{
    return @{@"type":@"SegmentAndSlider",
             @"itemArray":@[@"HOME",@"OFF"],
             @"adapter":^NSInteger(NSInteger value) {
                 if (-1000 <= value && value <= 0) {
                     return 0;
                 }else if (1 <= value && value <= 1000){
                     return 1;
                 }else{
                     return 0;
                 }
             }};
}

-(NSDictionary*)APSMPage1View34{
    return @{@"type":@"SegmentAndSlider",
             @"itemArray":@[@"ON",@"OFF"],
             @"adapter":^NSInteger(NSInteger value) {
                 if (-1000 <= value && value <= 0) {
                     return 0;
                 }else if (1 <= value && value <= 1000){
                     return 1;
                 }else{
                     return 0;
                 }
             }};
}

#pragma mark - APSM Page 2

-(NSDictionary*)APSMPage2View2{
    return @{@"type":@"yumeImageButtonsView",
             @"viewTitle":@"飛行器類型",
             @"images":@[@"wing4_1.jpg",
                         @"wing4_2.jpg",
                         @"wing6_1.jpg",
                         @"wing6_2.jpg",
                         @"wing8_1.jpg",
                         @"wing8_2.jpg"],
             @"toUI":^NSInteger(NSInteger valueMCU) {
                 return valueMCU;
             },
             @"toMCU":^NSInteger(NSInteger valueUI) {
                 return valueUI;
             }};
}

#pragma mark - APSM Page 3

-(NSDictionary*)APSMPage3View2{
    return @{@"type":@"yumeSwicthAndVoltageView",
             @"viewTitle":@"低電壓返航保護裝置",
             @"viewContent1":@"電壓低於",
             @"viewContent2":@"飛行器執行返回Home點",
             @"labelUnit":@"V"};
}

-(NSDictionary*)APSMPage3View3{
    return @{@"type":@"yumeSwicthAndVoltageView",
             @"viewTitle":@"低電壓警示燈閃爍提醒",
             @"viewContent1":@"電壓低於",
             @"viewContent2":@"飛行器警示燈閃爍提醒",
             @"labelUnit":@"V"};
}

#pragma mark - OSD Page 1

-(NSDictionary*)OSDPage1View11{
    return @{@"type":@"LabelAndSegment",
             @"labelTitle":@"顯示單位",
             @"segmentedControl":@[@"公制",@"英制"]};
}

-(NSDictionary*)OSDPage1View12{
    return @{@"type":@"LabelAndSegment",
             @"labelTitle":@"影像格式",
             @"segmentedControl":@[@"NTSC",@"PAL"]};
}

-(NSDictionary*)OSDPage1View13{
    return @{@"type":@"LabelAndSegment",
             @"labelTitle":@"顯示經緯度",
             @"segmentedControl":@[@"ON",@"OFF"]};
}

-(NSDictionary*)APSMPage5View1{
    return @{@"type":@"yumeSwicthAndVoltageView",
             @"viewTitle":@"低電壓提醒",
             @"viewContent1":@"電壓低於",
             @"viewContent2":@"",
             @"labelUnit":@"V"};
}

-(NSDictionary*)APSMPage5View2{
    return @{@"type":@"yumeSwicthAndVoltageView",
             @"viewTitle":@"衛星數量",
             @"viewContent1":@"衛星數量低於",
             @"viewContent2":@"",
             @"labelUnit":@"個"};
}

-(NSDictionary*)APSMPage5View3{
    return @{@"type":@"yumeSwicthAndVoltageView",
             @"viewTitle":@"飛行距離提醒",
             @"viewContent1":@"飛行距離超過",
             @"viewContent2":@"",
             @"labelUnit":@"M"};
}

-(NSDictionary*)APSMPage5View4{
    return @{@"type":@"yumeHeightWarningView",
             @"viewTitle":@"飛行高度提醒",
             @"viewContent1":@"飛行高度超過",
             @"viewContent2":@"飛行高度低於",
             @"labelUnit1":@"M",
             @"labelUnit2":@"M"};
}

#pragma mark - CradleHead Page 1

-(NSDictionary*)CradleHeadPage1View31{
    return @{@"type":@"CradleHeadControllView",
             @"labelTitle":@"Pan",
             @"segmentedControl":@[@"Manual",@"Attitude"]};
}

-(NSDictionary*)CradleHeadPage1View32{
    return @{@"type":@"CradleHeadControllView",
             @"labelTitle":@"Roll",
             @"segmentedControl":@[@"Manual",@"Attitude"]};
}

-(NSDictionary*)CradleHeadPage1View33{
    return @{@"type":@"CradleHeadControllView",
             @"labelTitle":@"Tilt",
             @"segmentedControl":@[@"Manual",@"Attitude"]};
}

-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
