//
//  CradleHeadControllView.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/21.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "CradleHeadControllView.h"
#import "ViewSource.h"

@interface CradleHeadControllView()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@end

@implementation CradleHeadControllView

- (void) setup{
    [super setup];
    [self addSubview:self.view];
    NSArray *array = @[@"seg1",@"seg2"];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:array];
    _segmentedControl.frame = CGRectMake(115, 5, 177, 29);
    _segmentedControl.tintColor = [UIColor whiteColor];
    //    _segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:_segmentedControl];
}

-(void)viewLiveRendering{
    [super viewLiveRendering];
    self.view.backgroundColor = [UIColor clearColor];
}

//-(void) processFuture{
//    
//}

-(void) processViewSource{

    _labelTitle.text = NSLocalizedString(self.viewSourceDictionary[@"labelTitle"], nil) ;
    NSArray *array = self.viewSourceDictionary[@"segmentedControl"];
    
    [self.segmentedControl removeAllSegments];
    for (int index = 0 ; index < array.count ; index++) {
        [self.segmentedControl insertSegmentWithTitle:(NSString *)array[index] atIndex:index animated:NO];
    }
}

-(id)debugQuickLookObject{
    return self;
}

@end
