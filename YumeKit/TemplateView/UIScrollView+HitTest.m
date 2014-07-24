//
//  UIScrollView+HitTest.m
//  test
//
//  Created by ALIGN-APP on 2014/5/6.
//  Copyright (c) 2014年 ALIGN-APP. All rights reserved.
//

#import "UIScrollView+HitTest.h"

@implementation UIScrollView (HitTest)
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{

    UIView *result=[super hitTest:point withEvent:event];
//    if (result ==  self) {
//        //TODO nothing to do...
//    }else{
//        self.delaysContentTouches=NO;
//    }
    if ([result isKindOfClass:[UISlider class]]) {
          self.delaysContentTouches=NO;
    }
    
    return result;
}
@end
