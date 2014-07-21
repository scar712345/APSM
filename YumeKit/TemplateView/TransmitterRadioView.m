//
//  transmitterRadioView.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/18.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "TransmitterRadioView.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"
#import "ViewSource.h"

@interface TransmitterRadioView()

@property (weak,nonatomic) yumeRCPRemoteControllerParameter *sliderSource;

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelLeft;
@property (weak, nonatomic) IBOutlet UILabel *labelRight;
@property (weak, nonatomic) IBOutlet UILabel *labelMin;
@property (weak, nonatomic) IBOutlet UILabel *labelDef;
@property (weak, nonatomic) IBOutlet UILabel *labelMax;

@end

@implementation TransmitterRadioView


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
    
    _slider.enabled = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(radioData:) name:@"radioData" object:[yumeBTLERemoteController sharedInstance ]];
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
    if (_sliderKeyPath) {
        _sliderSource = [YumeBTSharedInstance valueForKeyPath:_sliderKeyPath];
        self.slider.minimumValue = [[_sliderSource valueForKey:@"valueMin"] floatValue];
        self.slider.value = [[_sliderSource valueForKey:@"valueUI"] floatValue];
        self.slider.maximumValue = [[_sliderSource valueForKey:@"valueMax"] floatValue];
        self.labelMin.text = [[_sliderSource valueForKey:@"valueMin"] stringValue];
        self.labelDef.text = [[_sliderSource valueForKey:@"valueUI"] stringValue];
        self.labelMax.text = [[_sliderSource valueForKey:@"valueMax"] stringValue];
    }
}

-(void)processViewSource{
    [self.slider setMaximumTrackImage:[ UIImage imageNamed:@"slider_track(240x10).png"  inBundle:[NSBundle bundleWithIdentifier:@"com.Align.YumeKit"] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage imageNamed:@"slider.png"  inBundle:[NSBundle bundleWithIdentifier:@"com.Align.YumeKit"] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    self.slider.continuous = YES;
    
    if (_viewSourceKeyPath) {
        NSDictionary *dict =  [ViewSourceInstance valueForKey:_viewSourceKeyPath];
        
        NSString *type = dict[@"type"];
        NSString *className = NSStringFromClass([self class]);
        
        if ([className isEqualToString:type]) {
            _labelTitle.text = dict[@"labelTitle"];
            _labelLeft.text = dict[@"labelLeft"];
            _labelRight.text = dict[@"labelRight"];
        }

    }
}

-(id)debugQuickLookObject{
    return self;
}

#pragma mark - Future Method

-(void)radioData:(NSNotification*) notification {
    self.slider.value = _sliderSource.valueUI;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"radioData" object:[yumeBTLERemoteController sharedInstance ]];
}

@end
