//
//  LabelAndTextfiled.h
//  APSM
//
//  Created by ALIGN-APP on 2014/7/29.
//  Copyright (c) 2014年 yume. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CustomViewTemplate.h"
IB_DESIGNABLE
@interface LabelAndTextfiled : CustomViewTemplate

@property (nonatomic) IBInspectable NSString* viewTitleText;
@property (nonatomic) IBInspectable NSString* viewContent1Text;
@property (nonatomic) IBInspectable NSString* labelUnitText;

@property (nonatomic) IBInspectable NSString* textFieldKeyPath;
@end
