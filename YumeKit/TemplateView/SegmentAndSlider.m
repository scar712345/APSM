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
    
//    self.segmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(8, 0, 284, 30)];
//    [self.view addSubview:self.segmentedControl];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(radioData:) name:@"radioData" object:[yumeBTLERemoteController sharedInstance ]];
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
    
    [self.slider setMaximumTrackImage:[ UIImage imageNamed:@"slider_track(240x10).png"  inBundle:[NSBundle bundleWithIdentifier:@"com.Align.YumeKit"] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage imageNamed:@"slider.png"  inBundle:[NSBundle bundleWithIdentifier:@"com.Align.YumeKit"] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    self.slider.continuous = YES;
    
    NSArray *itemArray = [NSArray arrayWithObjects:@"Seg 1", @"Seg 2", @"Seg 3",nil];
    if (_viewSourceKeyPath) {
        NSDictionary *dict =  [ViewSourceInstance valueForKey:_viewSourceKeyPath];
        itemArray = dict[@"itemArray"];
    }
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    self.segmentedControl.frame = CGRectMake(8, 10, 284, 25);
    self.segmentedControl.tintColor = [UIColor whiteColor];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:self.segmentedControl];

//    if (_sliderKeyPath) {
//        _sliderSource = [YumeBTSharedInstance valueForKeyPath:_sliderKeyPath];
//        self.slider.minimumValue = [[_sliderSource valueForKey:@"valueMin"] floatValue];
//        self.slider.value = [[_sliderSource valueForKey:@"valueUI"] floatValue];
//        self.slider.maximumValue = [[_sliderSource valueForKey:@"valueMax"] floatValue];
//        self.labelMin.text = [[_sliderSource valueForKey:@"valueMin"] stringValue];
//        self.labelDef.text = [[_sliderSource valueForKey:@"valueUI"] stringValue];
//        self.labelMax.text = [[_sliderSource valueForKey:@"valueMax"] stringValue];
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
