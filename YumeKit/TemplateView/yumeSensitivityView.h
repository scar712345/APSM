//
//  yumeSensitivityView.h
//  APSM
//
//  Created by APP559 on 2014/7/15.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewTemplate.h"
IB_DESIGNABLE
@interface yumeSensitivityView : CustomViewTemplate

//@property (nonatomic) IBInspectable float borderLineWidth;
//@property (nonatomic) IBInspectable float borderRadius;
//@property (nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic) IBInspectable NSString* manualAileronKeyPath;
@property (nonatomic) IBInspectable NSString* manualElevatorKeyPath;
@property (nonatomic) IBInspectable NSString* manualRudderKeyPath;
@property (nonatomic) IBInspectable NSString* altitudeAileronKeyPath;
@property (nonatomic) IBInspectable NSString* altitudeElevatorKeyPath;
@property (nonatomic) IBInspectable NSString* altitudeRudderKeyPath;
@property (nonatomic) IBInspectable NSString* altitudeAltitudeKeyPath;

@property (nonatomic) IBInspectable NSString* viewTitleText;
@property (nonatomic) IBInspectable NSString* labelModeText;
@property (nonatomic) IBInspectable NSString* labelAileronText;
@property (nonatomic) IBInspectable NSString* labelElevatorText;
@property (nonatomic) IBInspectable NSString* labelRudderText;
@property (nonatomic) IBInspectable NSString* labelAltitudeText;
@property (nonatomic) IBInspectable NSString* labelManualText;
@property (nonatomic) IBInspectable NSString* labelAltitude2Text;

@end
