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
             @"itemArray":@[@"MANUAL",@"ATTITUDE",@"GPS"]};
}

-(NSDictionary*)APSMPage1View32{
    return @{@"type":@"SegmentAndSlider",
             @"itemArray":@[@"SMART",@"OFF"]};
}

-(NSDictionary*)APSMPage1View33{
    return @{@"type":@"SegmentAndSlider",
             @"itemArray":@[@"HOME",@"OFF"]};
}

-(NSDictionary*)APSMPage1View34{
    return @{@"type":@"SegmentAndSlider",
             @"itemArray":@[@"ON",@"OFF"]};
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
             @"viewContent2":@"飛行器執行返回Home點"};
}

-(NSDictionary*)APSMPage3View3{
    return @{@"type":@"yumeSwicthAndVoltageView",
             @"viewTitle":@"低電壓警示燈閃爍提醒",
             @"viewContent1":@"電壓低於",
             @"viewContent2":@"飛行器警示燈閃爍提醒"};
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
