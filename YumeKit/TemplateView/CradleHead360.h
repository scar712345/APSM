//
//  CradleHead360.h
//  APSM
//
//  Created by ALIGN-APP on 2014/7/21.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface CradleHead360 : UIView
@property (nonatomic) IBInspectable float borderLineWidth;
@property (nonatomic) IBInspectable float borderRadius;
@property (nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic) IBInspectable NSString* segmentKeyPath;
@property (nonatomic) IBInspectable NSString* textFieldKeyPath;
@property (nonatomic) IBInspectable NSString *viewSourceKeyPath;

@end
