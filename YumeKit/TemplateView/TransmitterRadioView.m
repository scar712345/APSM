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

@interface TransmitterRadioView()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelLeft;
@property (weak, nonatomic) IBOutlet UILabel *labelRight;
@property (weak, nonatomic) IBOutlet UILabel *labelMin;
@property (weak, nonatomic) IBOutlet UILabel *labelDef;
@property (weak, nonatomic) IBOutlet UILabel *labelMax;

@property (weak,nonatomic) yumeRCPRemoteControllerParameter *sliderSource;

@end

@implementation TransmitterRadioView

- (void) setup{
    [super setup];
    [self addSubview:self.view];
    
    _slider.enabled = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(radioData:) name:@"radioData" object:[yumeBTLERemoteController sharedInstance ]];
    
    [self.slider setMaximumTrackImage:[ UIImage imageNamed:@"slider_track(240x10).png"  inBundle:[NSBundle bundleWithIdentifier:@"com.Align.YumeKit"] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage imageNamed:@"slider.png"  inBundle:[NSBundle bundleWithIdentifier:@"com.Align.YumeKit"] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    self.slider.continuous = YES;
}

-(void)viewLiveRendering{
    [super viewLiveRendering];
    self.view.backgroundColor = [UIColor clearColor];
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
    _labelTitle.text = NSLocalizedString(self.viewSourceDictionary[@"labelTitle"], nil) ;
    _labelLeft.text = NSLocalizedString(self.viewSourceDictionary[@"labelLeft"], nil) ;
    _labelRight.text = NSLocalizedString(self.viewSourceDictionary[@"labelRight"], nil) ;
}

#pragma mark - Future Method

-(void)radioData:(NSNotification*) notification {
    self.slider.value = _sliderSource.valueUI;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"radioData" object:[yumeBTLERemoteController sharedInstance ]];
}

@end
