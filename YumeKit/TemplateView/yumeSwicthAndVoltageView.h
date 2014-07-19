//
//  yumeSwicthAndVoltageView.h
//  APSM
//
//  Created by APP559 on 2014/7/14.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface yumeSwicthAndVoltageView : UIView

@property (nonatomic) IBInspectable float borderLineWidth;
@property (nonatomic) IBInspectable float borderRadius;
@property (nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic) IBInspectable NSString* segmentKeyPath;
@property (nonatomic) IBInspectable NSString* textFieldKeyPath;
@property (nonatomic) IBInspectable NSString *viewSourceKeyPath;

@end
