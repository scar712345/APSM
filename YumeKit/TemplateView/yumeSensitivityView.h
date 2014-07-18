//
//  yumeSensitivityView.h
//  APSM
//
//  Created by APP559 on 2014/7/15.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface yumeSensitivityView : UIView

#ifndef IBInspectable
#define IBInspectable
#endif

@property (nonatomic) IBInspectable float borderLineWidth;
@property (nonatomic) IBInspectable float borderRadius;
@property (nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic) IBInspectable NSString* manualAileronKeyPath;
@property (nonatomic) IBInspectable NSString* manualElevatorKeyPath;
@property (nonatomic) IBInspectable NSString* manualRudderKeyPath;

@property (nonatomic) IBInspectable NSString* altitudeAileronKeyPath;
@property (nonatomic) IBInspectable NSString* altitudeElevatorKeyPath;
@property (nonatomic) IBInspectable NSString* altitudeRudderKeyPath;
@property (nonatomic) IBInspectable NSString* altitudeAltitudeKeyPath;

@end
