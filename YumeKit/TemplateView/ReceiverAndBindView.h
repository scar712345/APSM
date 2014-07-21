//
//  ReceiverAndBindView.h
//  APSM
//
//  Created by ALIGN-APP on 2014/7/17.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface ReceiverAndBindView : UIView

@property (nonatomic) IBInspectable float borderLineWidth;
@property (nonatomic) IBInspectable float borderRadius;
@property (nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic) IBInspectable NSString *receiverKeyPath;
@property (nonatomic) IBInspectable NSString *bindingKeyPath;
@property (nonatomic) IBInspectable NSString *viewSourceKeyPath;

@property (nonatomic) IBInspectable NSString *labelReceiverText;
@property (nonatomic) IBInspectable NSString *labelBindingText;
@property (nonatomic) IBInspectable NSString *btnReceiverText;
@property (nonatomic) IBInspectable NSString *btnBindingText;

@end
