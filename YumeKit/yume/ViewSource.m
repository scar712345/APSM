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

#pragma mark - APSM Page 4

-(NSDictionary*)APSMPage4View12{
    return @{@"type":@"LabelAndTextfiled",
             @"viewTitle":NSLocalizedString(@"巡航距離", nil),
             @"viewContent1":NSLocalizedString(@"正方型單邊長,距離", nil),
             @"labelUnit":@"M"};
}

-(NSDictionary*)APSMPage4View13{
    return @{@"type":@"LabelAndTextfiled",
             @"viewTitle":NSLocalizedString(@"拍攝張數", nil),
             @"viewContent1":NSLocalizedString(@"每10M拍攝張數", nil),
             @"labelUnit":@"張"};
}

-(NSDictionary*)APSMPage4View14{
    return @{@"type":@"yumeImageButtonsView",
             @"viewTitle":NSLocalizedString(@"巡航點選擇", nil),
             @"images":@[@"aps-m_2x2(140x140).jpg",
                         @"aps-m_3x3(140x140).jpg",
                         @"aps-m_5x5(140x140).jpg"],
             @"toUI":^NSInteger(NSInteger valueMCU) {
                 return valueMCU;
             },
             @"toMCU":^NSInteger(NSInteger valueUI) {
                 return valueUI;
             }};
}

#pragma mark - OSD Page 1

-(NSDictionary*)OSDPage1View1{
    return @{@"type":@"LabelAndSegment",
             @"labelTitle":NSLocalizedString(@"顯示單位", nil),
             @"segmentedControl":@[NSLocalizedString(@"公制", nil),NSLocalizedString(@"英制",nil)]};
}

-(NSDictionary*)OSDPage1View2{
    return @{@"type":@"LabelAndSegment",
             @"labelTitle":NSLocalizedString(@"影像格式", nil),
             @"segmentedControl":@[NSLocalizedString(@"NTSC", nil),NSLocalizedString(@"PAL", nil)]};
}

-(NSDictionary*)OSDPage1View3{
    return @{@"type":@"LabelAndSegment",
             @"labelTitle":NSLocalizedString(@"顯示經緯度", nil),
             @"segmentedControl":@[NSLocalizedString(@"ON", nil),NSLocalizedString(@"OFF", nil)]};
}

-(NSDictionary*)OSDPage1View51{
    return @{@"type":@"yumeSwicthAndVoltageView",
             @"viewTitle":NSLocalizedString(@"低電壓", nil),
             @"viewContent1":NSLocalizedString(@"電壓低於", nil),
             @"viewContent2":@"",
             @"labelUnit":@"V"};
}

-(NSDictionary*)OSDPage1View52{
    return @{@"type":@"yumeSwicthAndVoltageView",
             @"viewTitle":NSLocalizedString(@"衛星數量", nil),
             @"viewContent1":NSLocalizedString(@"衛星數量低於", nil),
             @"viewContent2":@"",
             @"labelUnit":NSLocalizedString(@"個", nil)};
}

-(NSDictionary*)OSDPage1View53{
    return @{@"type":@"yumeSwicthAndVoltageView",
             @"viewTitle":NSLocalizedString(@"飛行距離", nil),
             @"viewContent1":NSLocalizedString(@"飛行距離超過", nil),
             @"viewContent2":@"",
             @"labelUnit":@"M"};
}

-(NSDictionary*)OSDPage1View54{
    return @{@"type":@"yumeHeightWarningView",
             @"viewTitle":NSLocalizedString(@"飛行高度", nil),
             @"viewContent1":NSLocalizedString(@"飛行高度超過", nil),
             @"viewContent2":NSLocalizedString(@"飛行高度低於", nil),
             @"labelUnit1":@"M",
             @"labelUnit2":@"M"};
}

#pragma mark - CradleHead Page 1

-(NSDictionary*)CradleHeadPage1View1{
    return @{@"type":@"yumeImageButtonsView",
             @"viewTitle":NSLocalizedString(@"選擇雲台類型", nil),
             @"images":@[@"G2001(152x152).jpg",
                         @"G3001(152x152).jpg"],
             @"toUI":^NSInteger(NSInteger valueMCU) {
                 return valueMCU;
             },
             @"toMCU":^NSInteger(NSInteger valueUI) {
                 return valueUI;
             }};
}

-(NSDictionary*)CradleHeadPage1View31{
    return @{@"type":@"ParameterRevise",
             @"labelViewTitle":NSLocalizedString(@"PAN", nil),
             @"labelPGain":NSLocalizedString(@"P Gain", nil),
             @"labelIGain":NSLocalizedString(@"I Gain", nil),
             @"labelDGain":NSLocalizedString(@"D Gain", nil),
             @"labelPower":NSLocalizedString(@"Power", nil)};
}

-(NSDictionary*)CradleHeadPage1View32{
    return @{@"type":@"ParameterRevise",
             @"labelViewTitle":NSLocalizedString(@"ROLL", nil),
             @"labelPGain":NSLocalizedString(@"P Gain", nil),
             @"labelIGain":NSLocalizedString(@"I Gain", nil),
             @"labelDGain":NSLocalizedString(@"D Gain", nil),
             @"labelPower":NSLocalizedString(@"Power", nil)};
}

-(NSDictionary*)CradleHeadPage1View33{
    return @{@"type":@"ParameterRevise",
             @"labelViewTitle":NSLocalizedString(@"TILT", nil),
             @"labelPGain":NSLocalizedString(@"P Gain", nil),
             @"labelIGain":NSLocalizedString(@"I Gain", nil),
             @"labelDGain":NSLocalizedString(@"D Gain", nil),
             @"labelPower":NSLocalizedString(@"Power", nil)};
}

#pragma mark - CradleHead Page 2

-(NSDictionary*)CradleHeadPage2View21{
    return @{@"type":@"CradleHeadControllView",
             @"labelTitle":NSLocalizedString(@"PAN", nil),
             @"segmentedControl":@[NSLocalizedString(@"Manual", nil),NSLocalizedString(@"Attitude", nil)]};
}

-(NSDictionary*)CradleHeadPage2View22{
    return @{@"type":@"CradleHeadControllView",
             @"labelTitle":NSLocalizedString(@"ROLL", nil),
             @"segmentedControl":@[NSLocalizedString(@"Manual", nil),NSLocalizedString(@"Attitude", nil)]};
}

-(NSDictionary*)CradleHeadPage2View23{
    return @{@"type":@"CradleHeadControllView",
             @"labelTitle":NSLocalizedString(@"TILT", nil),
             @"segmentedControl":@[NSLocalizedString(@"Manual", nil),NSLocalizedString(@"Attitude", nil)]};
}

-(NSDictionary*)CradleHeadPage2View31{
    return @{@"type":@"TransmitterRadioView",
             @"labelTitle":NSLocalizedString(@"PAN", nil),
             @"labelLeft":NSLocalizedString(@"Left", nil),
             @"labelRight":NSLocalizedString(@"Right", nil)};
}

-(NSDictionary*)CradleHeadPage2View32{
    return @{@"type":@"TransmitterRadioView",
             @"labelTitle":NSLocalizedString(@"ROLL", nil),
             @"labelLeft":NSLocalizedString(@"Left", nil),
             @"labelRight":NSLocalizedString(@"Right", nil)};
}

-(NSDictionary*)CradleHeadPage2View33{
    return @{@"type":@"TransmitterRadioView",
             @"labelTitle":NSLocalizedString(@"TILT", nil),
             @"labelLeft":NSLocalizedString(@"Up", nil),
             @"labelRight":NSLocalizedString(@"Down", nil)};
}

-(NSDictionary*)CradleHeadPage2View34{
    return @{@"type":@"TransmitterRadioView",
             @"labelTitle":NSLocalizedString(@"ZOOM", nil),
             @"labelLeft":NSLocalizedString(@"", nil),
             @"labelRight":NSLocalizedString(@"", nil)};
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
             @"viewTitle":NSLocalizedString(@"PAN", nil),
             @"viewContent1":NSLocalizedString(@"跟隨速度", nil),
             @"viewContent2":NSLocalizedString(@"跟隨角度差最大值", nil),
             @"segmentedControl":@[NSLocalizedString(@"Manual", nil),NSLocalizedString(@"Attitude",nil)]};
}

-(NSDictionary*)CradleHeadPage3View12{
    return @{@"type":@"CamaraFollow",
             @"viewTitle":NSLocalizedString(@"ROLL", nil),
             @"viewContent1":NSLocalizedString(@"跟隨速度", nil) ,
             @"viewContent2":NSLocalizedString(@"跟隨角度差最大值", nil) ,
             @"segmentedControl":@[NSLocalizedString(@"Manual",nil),
                                   NSLocalizedString(@"Attitude",nil)]};
}

-(NSDictionary*)CradleHeadPage3View13{
    return @{@"type":@"CamaraFollow",
             @"viewTitle":NSLocalizedString(@"TILT", nil),
             @"viewContent1":NSLocalizedString(@"跟隨速度", nil),
             @"viewContent2":NSLocalizedString(@"跟隨角度差最大值", nil),
             @"segmentedControl":@[NSLocalizedString(@"Manual",nil),
                                   NSLocalizedString(@"Attitude",nil)]};
}

-(NSDictionary*)CradleHeadPage3View21{
    return @{@"type":@"CradleHeadNeutralPosition",
             @"viewTitle":NSLocalizedString(@"PAN", nil),};
}

-(NSDictionary*)CradleHeadPage3View22{
    return @{@"type":@"CradleHeadNeutralPosition",
             @"viewTitle":NSLocalizedString(@"TILT", nil),};
}

-(NSDictionary*)CradleHeadPage3View23{
    return @{@"type":@"CradleHeadNeutralPosition",
             @"viewTitle":NSLocalizedString(@"ROLL", nil),};
}

-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
