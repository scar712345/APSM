//
//  CradleHeadNeutralPosition.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/28.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "CradleHeadNeutralPosition.h"
#import "ParameterExtension.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"

@interface CradleHeadNeutralPosition()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *viewTitle;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UILabel *labelValue;

@end

@implementation CradleHeadNeutralPosition


- (void) setup{
    [super setup];
    [self addSubview:self.view];
}

-(void)viewLiveRendering{
    [super viewLiveRendering];
    self.view.backgroundColor = [UIColor clearColor];
}

-(void) processFuture{

    if (_stepperKeyPath) {
        _stepper.parameter = [YumeBTSharedInstance valueForKeyPath:_stepperKeyPath];
        _stepper.label = _labelValue;
        _stepper.label.text = [[_stepper.parameter valueForKey:@"valueUI"] stringValue];
        _stepper.minimumValue = [[_stepper.parameter valueForKey:@"parameterMin"] floatValue];
        _stepper.maximumValue = [[_stepper.parameter valueForKey:@"parameterMax"] floatValue];
        _stepper.value =  _stepper.parameter.valueUI;
    }
}

-(void) processViewSource{
    _viewTitle.text = self.viewSourceDictionary[@"viewTitle"];
}

- (IBAction)stepperAction:(UIStepper*)sender {
    sender.parameter.valueUI = sender.value;
    _stepper.label.text = [[sender.parameter valueForKey:@"valueUI"] stringValue];
}

@end
