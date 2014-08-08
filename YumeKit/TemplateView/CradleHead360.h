//
//  CradleHead360.h
//  APSM
//
//  Created by ALIGN-APP on 2014/7/21.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewTemplate.h"
IB_DESIGNABLE
@interface CradleHead360 : CustomViewTemplate
//@property (nonatomic) IBInspectable float borderLineWidth;
//@property (nonatomic) IBInspectable float borderRadius;
//@property (nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic) IBInspectable NSString* segmentKeyPath;
//@property (nonatomic) IBInspectable NSString *viewSourceKeyPath;

//@property (nonatomic) IBInspectable NSString* textFieldDegree0KeyPath;
//@property (nonatomic) IBInspectable NSString* textFieldDegree15KeyPath;
//@property (nonatomic) IBInspectable NSString* textFieldDegree30KeyPath;
//@property (nonatomic) IBInspectable NSString* textFieldDegree90KeyPath;

@property (nonatomic) IBInspectable NSString* labelMainTitleKeyPath;
@property (nonatomic) IBInspectable NSString* labelSubTitleKeyPath;

@property (nonatomic) IBInspectable NSString* labelDegree0KeyPath;
@property (nonatomic) IBInspectable NSString* labelDegree15KeyPath;
@property (nonatomic) IBInspectable NSString* labelDegree30KeyPath;
@property (nonatomic) IBInspectable NSString* labelDegree90KeyPath;

@property (nonatomic) IBInspectable NSString* labelUnitKeyPath;

@end
