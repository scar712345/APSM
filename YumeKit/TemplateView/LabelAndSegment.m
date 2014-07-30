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
@property (strong,nonatomic) UISegmentedControl *segmentedControl;

@property (weak,nonatomic) yumeRCPRemoteControllerParameter *segmentSource;
@end


@implementation LabelAndSegment

- (void) setup{
    [super setup];
    [self addSubview:self.view];
    NSArray *array = @[@"seg1",@"seg2"];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:array];
    _segmentedControl.frame = CGRectMake(8, self.labelTitle.frame.origin.y+self.labelTitle.frame.size.height+8, 284, 40);
    _segmentedControl.tintColor = [UIColor whiteColor];
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
    NSArray *segmentedControl = self.viewSourceDictionary[@"segmentedControl"];
    
    [_segmentedControl removeAllSegments];
    for (int index = 0 ; index < segmentedControl.count ; index++) {
        [self.segmentedControl insertSegmentWithTitle:(NSString *)segmentedControl[index] atIndex:index animated:NO];
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
