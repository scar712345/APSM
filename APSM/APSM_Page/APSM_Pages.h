//
//  page1.h
//  test
//
//  Created by ALIGN-APP on 2014/4/18.
//  Copyright (c) 2014年 ALIGN-APP. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TTScrollSlidingPagesController;
@interface APSM_Pages : UIViewController
@property (nonatomic, strong) TTScrollSlidingPagesController *ttScrollSlidingPagesController;

@property (nonatomic,strong) UIAlertView *alert;
@property (nonatomic,strong) NSArray *pages;
@property (nonatomic,strong) NSString *pageTitle;
@property (nonatomic,strong) NSArray *pagesSubTitle;
@end
