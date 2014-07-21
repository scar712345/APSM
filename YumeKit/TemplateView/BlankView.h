//
//  blankView.h
//  APSM
//
//  Created by ALIGN-APP on 2014/7/18.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface BlankView : UIView

@property (nonatomic) IBInspectable float borderLineWidth;
@property (nonatomic) IBInspectable float borderRadius;
@property (nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic) IBInspectable NSString *labelTitleText;
@end
