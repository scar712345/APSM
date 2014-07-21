//
//  CradleHeadControllView.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/21.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "CradleHeadControllView.h"

@interface CradleHeadControllView()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@end

@implementation CradleHeadControllView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup{
    NSString *nibName = NSStringFromClass([self class]);
    
    NSBundle *p = [NSBundle bundleWithIdentifier:@"com.Align.YumeKit"];
    
    UINib *nib = [UINib nibWithNibName:nibName bundle:p];
    
    [nib instantiateWithOwner:self options:nil];
    //Add the view loaded from the nib into self.
    [self addSubview:self.view];
}

-(void)prepareForInterfaceBuilder{
    [self viewLiveRendering];
}

- (void)drawRect:(CGRect)rect{
 
#ifndef TARGET_INTERFACE_BUILDER
    [self viewLiveRendering];
#endif
}

-(void)viewLiveRendering{
    self.view.backgroundColor = [UIColor clearColor];

    [self processFuture];
    
    [self processViewSource];
}

-(void) processFuture{
    
}

-(void) processViewSource{
//    if (_labelTitleText) {
//        _labelTitle.text = _labelTitleText;
//    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end