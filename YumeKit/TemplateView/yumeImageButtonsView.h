//
//  yumeImageButtonsView.h
//  APSM
//
//  Created by APP559 on 2014/7/15.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface yumeImageButtonsView : UIView

@property (nonatomic) IBInspectable float borderLineWidth;
@property (nonatomic) IBInspectable float borderRadius;
@property (nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic) IBInspectable CGPoint buttonBeginPoint;
@property (nonatomic) IBInspectable CGSize buttonSize;
@property (nonatomic) IBInspectable NSInteger buttonInRow;
@property (nonatomic) IBInspectable float buttonMargin;
@property (nonatomic) IBInspectable NSInteger buttonSelected;

@property (nonatomic) IBInspectable BOOL hasChangeAlert;

@property (nonatomic) IBInspectable NSString* viewSourceKeyPath;

@end
