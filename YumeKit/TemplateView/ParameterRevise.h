//
//  ParameterRevise.h
//  APSM
//
//  Created by ALIGN-APP on 2014/7/24.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewTemplate.h"
IB_DESIGNABLE
@interface ParameterRevise : CustomViewTemplate
@property (nonatomic) IBInspectable NSString* pGainKeyPath;
@property (nonatomic) IBInspectable NSString* iGainKeyPath;
@property (nonatomic) IBInspectable NSString* dGainKeyPath;
@property (nonatomic) IBInspectable NSString* powerKeyPath;

@end
