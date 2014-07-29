//
//  yumeHeightWarningView.h
//  APSM
//
//  Created by APP559 on 2014/7/24.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewTemplate.h"
IB_DESIGNABLE
@interface yumeHeightWarningView : CustomViewTemplate
//@property (nonatomic) IBInspectable float borderLineWidth;
//@property (nonatomic) IBInspectable float borderRadius;
//@property (nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic) IBInspectable NSString* segmentKeyPath;
@property (nonatomic) IBInspectable NSString* textField1KeyPath;
@property (nonatomic) IBInspectable NSString* textField2KeyPath;
//@property (nonatomic) IBInspectable NSString *viewSourceKeyPath;
@end
