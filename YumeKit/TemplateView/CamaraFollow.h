//
//  CamaraFollow.h
//  APSM
//
//  Created by ALIGN-APP on 2014/7/28.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewTemplate.h"

IB_DESIGNABLE
@interface CamaraFollow : CustomViewTemplate

//@property (nonatomic) IBInspectable NSString *viewSourceKeyPath;
@property (nonatomic) IBInspectable NSString *followSpeedKeyPath;
@property (nonatomic) IBInspectable NSString *followAngleKeyPath;

@end
