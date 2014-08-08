//
//  Page.m
//  APSM
//
//  Created by APP559 on 2014/7/16.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "Page.h"

@interface Page ()

@end

@implementation Page

-(void)viewDidLayoutSubviews{
    _scrollView.contentSize = CGSizeMake(ScreenWidth, _lastView.frame.origin.y + _lastView.frame.size.height);
    _scrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 25 - 10 - 25 - 50);
}

-(void)viewDidLoad{
    [super viewDidLoad];
    _scrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    
    UIView *strongBackgroundView = _backgroundView;
    if (strongBackgroundView) {
        [strongBackgroundView removeFromSuperview];
    }
}
@end
