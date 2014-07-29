//
//  blankView.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/18.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "BlankView.h"

@interface BlankView()
@property (strong,nonatomic) UILabel *labelTitle;
@end


@implementation BlankView

- (void) setup{
//    [super setup];
    
    _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, 284, 26)];
    _labelTitle.textColor = [UIColor whiteColor];
    _labelTitle.font = [UIFont systemFontOfSize:22.0];
    _labelTitle.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_labelTitle];
}

-(void)viewLiveRendering{
    [super viewLiveRendering];
    
    self.backgroundColor =[UIColor clearColor];
}

//-(void) processFuture{
//    
//}

//-(void) processViewSource{
//    
//}

-(void)processStoryBoardSource{
    if (_labelTitleText) {
        _labelTitle.text = NSLocalizedString(_labelTitleText, nil) ;
    }
}

@end
