//
//  ParameterRevise.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/24.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "ParameterRevise.h"
#import "ParameterExtension.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"

@interface ParameterRevise()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *labelViewTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelPGain;
@property (weak, nonatomic) IBOutlet UILabel *labelIGain;
@property (weak, nonatomic) IBOutlet UILabel *labelDGain;
@property (weak, nonatomic) IBOutlet UILabel *labelPower;
@property (weak, nonatomic) IBOutlet UILabel *labelPGainValue;
@property (weak, nonatomic) IBOutlet UILabel *labelIGainValue;
@property (weak, nonatomic) IBOutlet UILabel *labelDGainValue;
@property (weak, nonatomic) IBOutlet UILabel *labelPowerValue;
@property (weak, nonatomic) IBOutlet UIStepper *stepperPGain;
@property (weak, nonatomic) IBOutlet UIStepper *stepperIGain;
@property (weak, nonatomic) IBOutlet UIStepper *stepperDGain;
@property (weak, nonatomic) IBOutlet UIStepper *stepperPower;


@end

@implementation ParameterRevise

- (void) setup{
    [super setup];
    [self addSubview:self.view];
    
//    [stepper setMinimumValue:minValue];
//    [stepper setMaximumValue:maxValue];
//    [stepper setValue:defaultValue];
//    [stepper setStepValue:1];
//    [stepper addTarget:self action:@selector(stepperValueIschanged:) forControlEvents:UIControlEventValueChanged];
}

-(void)viewLiveRendering{
    [super viewLiveRendering];
    self.view.backgroundColor = [UIColor clearColor];
}

-(void) processFuture{
    if (_pGainKeyPath) {
        _stepperPGain.parameter = [YumeBTSharedInstance valueForKeyPath:_pGainKeyPath];
        _stepperPGain.label = _labelPGainValue;
        _stepperPGain.label.text = [[_stepperPGain.parameter valueForKey:@"valueUI"] stringValue];
        _stepperPGain.minimumValue = [[_stepperPGain.parameter valueForKey:@"parameterMin"] floatValue];
        _stepperPGain.maximumValue = [[_stepperPGain.parameter valueForKey:@"parameterMax"] floatValue];
        _stepperPGain.value =  _stepperPGain.parameter.valueUI;
    }
    
    if (_iGainKeyPath) {
        _stepperIGain.parameter = [YumeBTSharedInstance valueForKeyPath:_iGainKeyPath];
        _stepperIGain.label = _labelIGainValue;
        _stepperIGain.label.text = [[_stepperIGain.parameter valueForKey:@"valueUI"] stringValue];
        _stepperIGain.minimumValue = [[_stepperIGain.parameter valueForKey:@"parameterMin"] floatValue];
        _stepperIGain.maximumValue = [[_stepperIGain.parameter valueForKey:@"parameterMax"] floatValue];
        _stepperIGain.value =  _stepperIGain.parameter.valueUI;
    }
    
    if (_dGainKeyPath) {
        _stepperDGain.parameter = [YumeBTSharedInstance valueForKeyPath:_dGainKeyPath];
        _stepperDGain.label = _labelDGainValue;
        _stepperDGain.label.text = [[_stepperDGain.parameter valueForKey:@"valueUI"] stringValue];
        _stepperDGain.minimumValue = [[_stepperDGain.parameter valueForKey:@"parameterMin"] floatValue];
        _stepperDGain.maximumValue = [[_stepperDGain.parameter valueForKey:@"parameterMax"] floatValue];
        _stepperDGain.value =  _stepperDGain.parameter.valueUI;
 
    }
    
    if (_powerKeyPath) {
        _stepperPower.parameter = [YumeBTSharedInstance valueForKeyPath:_powerKeyPath];
        _stepperPower.label = _labelPowerValue;
        _stepperPower.label.text = [[_stepperPower.parameter valueForKey:@"valueUI"] stringValue];
        _stepperPower.maximumValue = [[_stepperPower.parameter valueForKey:@"parameterMax"] floatValue];
         _stepperPower.minimumValue = [[_stepperPower.parameter valueForKey:@"parameterMin"] floatValue];
        _stepperPower.value =  _stepperPower.parameter.valueUI;
    }
}

-(void) processViewSource{
    _labelViewTitle.text = self.viewSourceDictionary[@"labelViewTitle"];
    _labelPGain.text = self.viewSourceDictionary[@"labelPGain"];
    _labelIGain.text = self.viewSourceDictionary[@"labelIGain"];
    _labelDGain.text = self.viewSourceDictionary[@"labelDGain"];
    _labelPower.text = self.viewSourceDictionary[@"labelPower"];

}



#pragma mark - UIStepper

- (IBAction)stepperPGain:(UIStepper *)sender {
    sender.parameter.valueUI =sender.value;
    sender.label.text =[[sender.parameter valueForKey:@"valueUI"] stringValue];
}
//- (IBAction)stepperIGain:(id)sender {
//    NSLog(@"%f",_stepperIGain.value);
//    _labelIGainValue.text =[NSString stringWithFormat:@"%0.f",_stepperIGain.value];
//}
//- (IBAction)stepperDGain:(id)sender {
//    NSLog(@"%f",_stepperDGain.value);
//    _labelDGainValue.text =[NSString stringWithFormat:@"%0.f",_stepperDGain.value];
//}
//- (IBAction)stepperPower:(id)sender {
//    NSLog(@"%f",_stepperPower.value);
//    _labelPowerValue.text =[NSString stringWithFormat:@"%0.f",_stepperPower.value];
//}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
