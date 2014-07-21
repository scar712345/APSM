//
//  LabelAndSegment.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/19.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "LabelAndSegment.h"
#import "ViewSource.h"

@interface LabelAndSegment()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong,nonatomic) UISegmentedControl *segmentedControl;
@end


@implementation LabelAndSegment

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
    self.layer.borderColor = _borderColor.CGColor;
    self.layer.borderWidth = _borderLineWidth;
    
    if( [self.layer respondsToSelector:@selector(setCornerRadius:)] )
        [self.layer setCornerRadius:_borderRadius];
    
    
#ifndef TARGET_INTERFACE_BUILDER
    [self viewLiveRendering];
#endif
}

-(void)viewLiveRendering{
    self.view.backgroundColor = [UIColor clearColor];
    
    [self processViewSource];
    
    [self processFuture];
}

-(void)processFuture{
    
}

-(void)processViewSource{
    NSArray *array = @[@"seg1",@"seg2"];
    
    if (_viewSourceKeyPath) {
        NSDictionary *dict = [ViewSourceInstance valueForKey:_viewSourceKeyPath];
        
        NSString *type = dict[@"type"];
        NSString *className = NSStringFromClass([self class]);
        
        if ([className isEqualToString:type]) {
            _labelTitle.text = dict[@"labelTitle"];
            array = dict[@"segmentedControl"];
            
            _segmentedControl = [[UISegmentedControl alloc] initWithItems:array];
        }
    }else{
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:array];
    }
    _segmentedControl.frame = CGRectMake(8, self.labelTitle.frame.origin.y+self.labelTitle.frame.size.height+8, 284, 40);
    _segmentedControl.tintColor = [UIColor whiteColor];
    [self.view addSubview:_segmentedControl];

}

-(id)debugQuickLookObject{
    return self;
}

@end
