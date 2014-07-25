//
//  UIScrollView+HitTest.h
//  test
//
//  Created by ALIGN-APP on 2014/5/6.
//  Copyright (c) 2014年 ALIGN-APP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (HitTest)
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;

@end
