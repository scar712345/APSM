//
//  yumeXYZView.h
//  APSM
//
//  Created by APP559 on 2014/7/15.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface yumeXYZView : UIView

#ifndef IBInspectable
#define IBInspectable
#endif

@property (nonatomic) IBInspectable float borderLineWidth;
@property (nonatomic) IBInspectable float borderRadius;
@property (nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic) IBInspectable NSString* xKeyPath;
@property (nonatomic) IBInspectable NSString* yKeyPath;
@property (nonatomic) IBInspectable NSString* zKeyPath;

@end
