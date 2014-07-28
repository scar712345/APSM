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
             @"labelTitle":NSLocalizedString(@"AIL", nil),
             @"labelLeft":NSLocalizedString(@"Left", nil),
             @"labelRight":NSLocalizedString(@"Right", nil)};
}

-(NSDictionary*)APSMPage1View22{
    return @{@"type":@"TransmitterRadioView",
             @"labelTitle":NSLocalizedString(@"ELE", nil),
             @"labelLeft":NSLocalizedString(@"Up", nil),
             @"labelRight":NSLocalizedString(@"Down", nil)};
}

-(NSDictionary*)APSMPage1View23{
    return @{@"type":@"TransmitterRadioView",
             @"labelTitle":NSLocalizedString(@"RUD", nil),
             @"labelLeft":NSLocalizedString(@"Left", nil),
             @"labelRight":NSLocalizedString(@"Right", nil)};
}

-(NSDictionary*)APSMPage1View24{
    return @{@"type":@"TransmitterRadioView",
             @"labelTitle":NSLocalizedString(@"THR", nil),
             @"labelLeft":NSLocalizedString(@"Idle", nil),
             @"labelRight":NSLocalizedString(@"Full", nil)};
}

-(NSDictionary*)APSMPage1View31{
    return @{@"type":@"SegmentAndSlider",
             @"itemArray":@[NSLocalizedString(@"MANUAL", nil),NSLocalizedString(@"ATTITUDE", nil),NSLocalizedString(@"GPS", nil)],
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
             @"itemArray":@[NSLocalizedString(@"SMART", nil),NSLocalizedString(@"OFF", nil)],
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
             @"itemArray":@[NSLocalizedString(@"HOME", nil),NSLocalizedString(@"OFF", nil)],
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
             @"itemArray":@[NSLocalizedString(@"ON", nil),NSLocalizedString(@"OFF", nil)],
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
             @"viewTitle":NSLocalizedString(@"飛行器類型", nil),
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
             @"viewTitle":NSLocalizedString(@"低電壓返航保護裝置", nil),
             @"viewContent1":NSLocalizedString(@"電壓低於", nil),
             @"viewContent2":NSLocalizedString(@"飛行器執行返回Home點", nil),
             @"labelUnit":@"V"};
}

-(NSDictionary*)APSMPage3View3{
    return @{@"type":@"yumeSwicthAndVoltageView",
             @"viewTitle":NSLocalizedString(@"低電壓警示燈閃爍提醒", nil),
             @"viewContent1":NSLocalizedString(@"電壓低於", nil),
             @"viewContent2":NSLocalizedString(@"飛行器警示燈閃爍提醒", nil),
             @"labelUnit":@"V"};
}

#pragma mark - OSD Page 1

-(NSDictionary*)OSDPage1View11{
    return @{@"type":@"LabelAndSegment",
             @"labelTitle":NSLocalizedString(@"顯示單位", nil),
             @"segmentedControl":@[NSLocalizedString(@"公制", nil),NSLocalizedString(@"英制",nil)]};
}

-(NSDictionary*)OSDPage1View12{
    return @{@"type":@"LabelAndSegment",
             @"labelTitle":NSLocalizedString(@"影像格式", nil),
             @"segmentedControl":@[NSLocalizedString(@"NTSC", nil),NSLocalizedString(@"PAL", nil)]};
}

-(NSDictionary*)OSDPage1View13{
    return @{@"type":@"LabelAndSegment",
             @"labelTitle":NSLocalizedString(@"顯示經緯度", nil),
             @"segmentedControl":@[NSLocalizedString(@"ON", nil),NSLocalizedString(@"OFF", nil)]};
}

-(NSDictionary*)OSDPage1View31{
    return @{@"type":@"yumeSwicthAndVoltageView",
             @"viewTitle":NSLocalizedString(@"低電壓提醒", nil),
             @"viewContent1":NSLocalizedString(@"電壓低於", nil),
             @"viewContent2":@"",
             @"labelUnit":@"V"};
}

-(NSDictionary*)OSDPage1View32{
    return @{@"type":@"yumeSwicthAndVoltageView",
             @"viewTitle":NSLocalizedString(@"衛星數量", nil),
             @"viewContent1":NSLocalizedString(@"衛星數量低於", nil),
             @"viewContent2":@"",
             @"labelUnit":NSLocalizedString(@"個", nil)};
}

-(NSDictionary*)OSDPage1View33{
    return @{@"type":@"yumeSwicthAndVoltageView",
             @"viewTitle":NSLocalizedString(@"飛行距離提醒", nil),
             @"viewContent1":NSLocalizedString(@"飛行距離超過", nil),
             @"viewContent2":@"",
             @"labelUnit":@"M"};
}

-(NSDictionary*)OSDPage1View34{
    return @{@"type":@"yumeHeightWarningView",
             @"viewTitle":NSLocalizedString(@"飛行高度提醒", nil),
             @"viewContent1":NSLocalizedString(@"飛行高度超過", nil),
             @"viewContent2":NSLocalizedString(@"飛行高度低於", nil),
             @"labelUnit1":@"M",
             @"labelUnit2":@"M"};
}

#pragma mark - CradleHead Page 1


-(NSDictionary*)CradleHeadPage1View31{
    return @{@"type":@"ParameterRevise",
             @"viewTitle":NSLocalizedString(@"PAN", nil),
             @"labelPGain":NSLocalizedString(@"P Gain", nil),
             @"labelIGain":NSLocalizedString(@"I Gain", nil),
             @"labelDGain":NSLocalizedString(@"D Gain", nil),
             @"labelPower":NSLocalizedString(@"Power", nil)};
}

-(NSDictionary*)CradleHeadPage1View32{
    return @{@"type":@"ParameterRevise",
             @"viewTitle":NSLocalizedString(@"ROLL", nil),
             @"labelPGain":NSLocalizedString(@"P Gain", nil),
             @"labelIGain":NSLocalizedString(@"I Gain", nil),
             @"labelDGain":NSLocalizedString(@"D Gain", nil),
             @"labelPower":NSLocalizedString(@"Power", nil)};
}

-(NSDictionary*)CradleHeadPage1View33{
    return @{@"type":@"ParameterRevise",
             @"viewTitle":NSLocalizedString(@"TILT", nil),
             @"labelPGain":NSLocalizedString(@"P Gain", nil),
             @"labelIGain":NSLocalizedString(@"I Gain", nil),
             @"labelDGain":NSLocalizedString(@"D Gain", nil),
             @"labelPower":NSLocalizedString(@"Power", nil)};
}

#pragma mark - CradleHead Page 2

-(NSDictionary*)CradleHeadPage2View21{
    return @{@"type":@"CradleHeadControllView",
             @"labelTitle":NSLocalizedString(@"Pan", nil),
             @"segmentedControl":@[NSLocalizedString(@"Manual", nil),NSLocalizedString(@"Attitude", nil)]};
}

-(NSDictionary*)CradleHeadPage2View22{
    return @{@"type":@"CradleHeadControllView",
             @"labelTitle":NSLocalizedString(@"Roll", nil),
             @"segmentedControl":@[NSLocalizedString(@"Manual", nil),NSLocalizedString(@"Attitude", nil)]};
}

-(NSDictionary*)CradleHeadPage2View23{
    return @{@"type":@"CradleHeadControllView",
             @"labelTitle":NSLocalizedString(@"Tilt", nil),
             @"segmentedControl":@[NSLocalizedString(@"Manual", nil),NSLocalizedString(@"Attitude", nil)]};
}

-(NSDictionary*)CradleHeadPage2View41{
    return @{@"type":@"SegmentAndSlider",
             @"itemArray":@[NSLocalizedString(@"ON", nil),NSLocalizedString(@"OFF", nil)],
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

-(NSDictionary*)CradleHeadPage2View42{
    return @{@"type":@"SegmentAndSlider",
             @"itemArray":@[NSLocalizedString(@"ON", nil),NSLocalizedString(@"OFF", nil)],
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

#pragma mark - CradleHead Page 3

-(NSDictionary*)CradleHeadPage3View11{
    return @{@"type":@"CamaraFollow",
             @"viewTitle":NSLocalizedString(@"Pan", nil),
             @"viewContent1":NSLocalizedString(@"跟隨速度", nil),
             @"viewContent2":NSLocalizedString(@"跟隨角度差最大值", nil),
             @"segmentedControl":@[NSLocalizedString(@"Manual", nil),NSLocalizedString(@"Attitude",nil)]};
}

-(NSDictionary*)CradleHeadPage3View12{
    return @{@"type":@"CamaraFollow",
             @"viewTitle":NSLocalizedString(@"Roll", nil),
             @"viewContent1":NSLocalizedString(@"跟隨速度", nil) ,
             @"viewContent2":NSLocalizedString(@"跟隨角度差最大值", nil) ,
             @"segmentedControl":@[NSLocalizedString(@"Manual",nil),
                                   NSLocalizedString(@"Attitude",nil)]};
}

-(NSDictionary*)CradleHeadPage3View13{
    return @{@"type":@"CamaraFollow",
             @"viewTitle":NSLocalizedString(@"Tilt", nil),
             @"viewContent1":NSLocalizedString(@"跟隨速度", nil),
             @"viewContent2":NSLocalizedString(@"跟隨角度差最大值", nil),
             @"segmentedControl":@[NSLocalizedString(@"Manual",nil),
                                   NSLocalizedString(@"Attitude",nil)]};
}

-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
