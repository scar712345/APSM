//
//  CradleHeadNeutralPosition.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/28.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "CradleHeadNeutralPosition.h"

@interface CradleHeadNeutralPosition()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *viewTitle;

@end

@implementation CradleHeadNeutralPosition


- (void) setup{
    [super setup];
    [self addSubview:self.view];
}

-(void)viewLiveRendering{
    [super viewLiveRendering];
    self.view.backgroundColor = [UIColor clearColor];
}

//-(void) processFuture{
//    
//}

-(void) processViewSource{
    _viewTitle.text = self.viewSourceDictionary[@"viewTitle"];
}


@end
