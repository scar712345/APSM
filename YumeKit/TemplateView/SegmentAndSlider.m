//
//  SegmentAndSlider.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/19.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "SegmentAndSlider.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"
#import "ViewSource.h"

typedef NSInteger(^yumeAdapter)(NSInteger value);

@interface SegmentAndSlider()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak,nonatomic) yumeRCPRemoteControllerParameter *sliderSource;
@property (strong,nonatomic) yumeAdapter adapter;

@end


@implementation SegmentAndSlider

- (void) setup{
    [super setup];
    [self addSubview:self.view];
    
    _slider.enabled = NO;
//    _segmentedControl.enabled = NO;
    _adapter = nil;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(radioData:) name:@"radioData" object:[yumeBTLERemoteController sharedInstance ]];
    
    [self.slider setMaximumTrackImage:IMAGE_NAMED(@"slider_track(240x10).png") forState:UIControlStateNormal];
    [self.slider setThumbImage:IMAGE_NAMED(@"slider.png") forState:UIControlStateNormal];
    self.slider.continuous = YES;
    
    _segmentedControl.enabled = NO;
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
        
        if (_adapter) {
            [_segmentedControl setSelectedSegmentIndex:_adapter(_sliderSource.valueUI)];
        }
    }
}

-(void)processViewSource{
        
//    NSArray *itemArray = [NSArray arrayWithObjects:@"Seg 1", @"Seg 2", @"Seg 3",nil];
//
//    itemArray = self.viewSourceDictionary[@"itemArray"];
//    _adapter = self.viewSourceDictionary[@"adapter"];
//
//    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
//    self.segmentedControl.frame = CGRectMake(8, 10, 284, 25);
//    self.segmentedControl.tintColor = [UIColor whiteColor];
//    self.segmentedControl.selectedSegmentIndex = 0;
//    _segmentedControl.enabled = NO;
//    [self.view addSubview:self.segmentedControl];
    
    
    
    NSArray *itemArray = self.viewSourceDictionary[@"itemArray"];
    _adapter = self.viewSourceDictionary[@"adapter"];
    
    [self.segmentedControl removeAllSegments];
    for (int index = 0 ; index < itemArray.count ; index++) {
        [self.segmentedControl insertSegmentWithTitle:(NSString *)itemArray[index] atIndex:index animated:NO];
    }
   
}

-(id)debugQuickLookObject{
    return self;
}

#pragma mark - Future Method

-(void)radioData:(NSNotification*) notification {
    self.slider.value = _sliderSource.valueUI;
    if (_adapter) {
        [_segmentedControl setSelectedSegmentIndex:_adapter(_sliderSource.valueUI)];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"radioData" object:[yumeBTLERemoteController sharedInstance ]];
}

@end
