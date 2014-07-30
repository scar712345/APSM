//
//  yumeXYZView.h
//  APSM
//
//  Created by APP559 on 2014/7/15.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewTemplate.h"
IB_DESIGNABLE
@interface yumeXYZView : CustomViewTemplate

//@property (nonatomic) IBInspectable float borderLineWidth;
//@property (nonatomic) IBInspectable float borderRadius;
//@property (nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic) IBInspectable NSString* xKeyPath;
@property (nonatomic) IBInspectable NSString* yKeyPath;
@property (nonatomic) IBInspectable NSString* zKeyPath;

@property (nonatomic) IBInspectable NSString* viewTitleText;
@property (nonatomic) IBInspectable NSString* xText;
@property (nonatomic) IBInspectable NSString* yText;
@property (nonatomic) IBInspectable NSString* zText;
@property (nonatomic) IBInspectable NSString* unitText;

@end
