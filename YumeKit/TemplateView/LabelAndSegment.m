//
//  LabelAndSegment.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/19.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "LabelAndSegment.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"

@interface LabelAndSegment()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak,nonatomic) yumeRCPRemoteControllerParameter *segmentSource;
@end


@implementation LabelAndSegment

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

-(void)processFuture{
    if (_segmentKeyPath) {
        _segmentSource = [YumeBTSharedInstance valueForKeyPath:_segmentKeyPath];
        [_segmentedControl setSelectedSegmentIndex:(int)_segmentSource.valueUI];
    }
}

-(void)processViewSource{

    _labelTitle.text = self.viewSourceDictionary[@"labelTitle"];
    NSArray *itemArray = self.viewSourceDictionary[@"itemArray"];
    
    [_segmentedControl removeAllSegments];
    for (int index = 0 ; index < itemArray.count ; index++) {
        [self.segmentedControl insertSegmentWithTitle:(NSString *)itemArray[index] atIndex:index animated:NO];
    }
    
}

-(id)debugQuickLookObject{
    return self;
}

#pragma mark - Segment Method

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
    _segmentSource.valueUI = (float) sender.selectedSegmentIndex;
}

@end
