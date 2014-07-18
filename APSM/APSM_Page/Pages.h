//
//  Pages.h
//  APSM
//
//  Created by APP559 on 2014/7/16.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTScrollSlidingPagesController;
@interface Pages : UIViewController
@property (nonatomic, strong) TTScrollSlidingPagesController *ttScrollSlidingPagesController;

@property (nonatomic,strong) UIAlertView *alert;
@property (nonatomic,strong) NSArray *pages;
@property (nonatomic,strong) NSString *pageTitle;
@property (nonatomic,strong) NSArray *pagesSubTitle;
@end
