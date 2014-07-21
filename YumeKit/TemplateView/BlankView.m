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
    _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, 284, 26)];
    _labelTitle.textColor = [UIColor whiteColor];
    _labelTitle.font = [UIFont systemFontOfSize:22.0];
    _labelTitle.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_labelTitle];
}

-(void)prepareForInterfaceBuilder{
    [self viewLiveRendering];
}

- (void)drawRect:(CGRect)rect{
    self.layer.borderColor = _borderColor.CGColor;
    self.layer.borderWidth = _borderLineWidth;
    
    if( [self.layer respondsToSelector:@selector(setCornerRadius:)] )
        [self.layer setCornerRadius:_borderRadius];
#ifndef TARGET_INTERFACE_BUILDER
    [self viewLiveRendering];
#endif
}

-(void)viewLiveRendering{
    self.backgroundColor =[UIColor clearColor];
    
    [self processViewSource];
    
    [self processFuture];
}


-(void) processFuture{
    
}

-(void) processViewSource{
    if (_labelTitleText) {
        _labelTitle.text = _labelTitleText;
    }
}

-(id)debugQuickLookObject{
    return self;
}

@end
