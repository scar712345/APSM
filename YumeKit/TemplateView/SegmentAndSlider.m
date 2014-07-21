//
//  SegmentAndSlider.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/19.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "SegmentAndSlider.h"
#import "ViewSource.h"

@interface SegmentAndSlider()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;

@end


@implementation SegmentAndSlider

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
    
    [self processViewSource];
    
    [self processFuture];
}

-(void)processFuture{
    
}

-(void)processViewSource{
    [self.slider setMaximumTrackImage:[ UIImage imageNamed:@"slider_track(240x10).png"  inBundle:[NSBundle bundleWithIdentifier:@"com.Align.YumeKit"] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage imageNamed:@"slider.png"  inBundle:[NSBundle bundleWithIdentifier:@"com.Align.YumeKit"] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    self.slider.continuous = YES;
    
    NSArray *itemArray = [NSArray arrayWithObjects:@"Seg 1", @"Seg 2", @"Seg 3",nil];
    if (_viewSourceKeyPath) {
        NSDictionary *dict =  [ViewSourceInstance valueForKey:_viewSourceKeyPath];
        
        NSString *type = dict[@"type"];
        NSString *className = NSStringFromClass([self class]);
        
        if ([className isEqualToString:type]) {
            itemArray = dict[@"itemArray"];
        }
        
    }
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    self.segmentedControl.frame = CGRectMake(8, 10, 284, 25);
    self.segmentedControl.tintColor = [UIColor whiteColor];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:self.segmentedControl];
}

-(id)debugQuickLookObject{
    return self;
}

@end
