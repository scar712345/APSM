//
//  CradleHeadControllView.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/21.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "CradleHeadControllView.h"
#import "ViewSource.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"

@interface CradleHeadControllView()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak,nonatomic) yumeRCPRemoteControllerParameter *segmentSource;
@end

@implementation CradleHeadControllView

- (void) setup{
    [super setup];
    [self addSubview:self.view];
   
    [_segmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
}

-(void)viewLiveRendering{
    [super viewLiveRendering];
    self.view.backgroundColor = [UIColor clearColor];
}

-(void) processFuture{
    if (_segmentKeyPath) {
        _segmentSource = [YumeBTSharedInstance valueForKeyPath:_segmentKeyPath];
        [_segmentedControl setSelectedSegmentIndex:(int)_segmentSource.valueUI];
    }
}

-(void) processViewSource{

    _labelTitle.text = self.viewSourceDictionary[@"labelTitle"];
    NSArray *segmentedControl = self.viewSourceDictionary[@"segmentedControl"];
    
    [self.segmentedControl removeAllSegments];
    for (int index = 0 ; index < segmentedControl.count ; index++) {
        [self.segmentedControl insertSegmentWithTitle:(NSString *)segmentedControl[index] atIndex:index animated:NO];
    }
}

-(id)debugQuickLookObject{
    return self;
}

#pragma mark Segement Method

-(void)segmentValueChanged:(UISegmentedControl *)sender{
    _segmentSource.valueUI = (float) sender.selectedSegmentIndex;
}


@end
