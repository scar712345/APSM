//
//  ParameterRevise.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/24.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "ParameterRevise.h"
#import "ViewSource.h"

@interface ParameterRevise(){
    NSArray *labelValues;
    NSArray *steppers;
    BOOL checkd;
}
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *labelViewTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckBox;
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
    
    
    labelValues = @[_labelPGainValue,_labelIGainValue,_labelDGainValue,_labelPowerValue];
    steppers = @[_stepperPGain,_stepperIGain,_stepperDGain,_stepperPower];
    checkd = YES;
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
    
}

-(void) processViewSource{
    _labelViewTitle.text = self.viewSourceDictionary[@"labelViewTitle"];
    _labelPGain.text = self.viewSourceDictionary[@"labelPGain"];
    _labelIGain.text = self.viewSourceDictionary[@"labelIGain"];
    _labelDGain.text = self.viewSourceDictionary[@"labelDGain"];
    _labelPower.text = self.viewSourceDictionary[@"labelPower"];
}

#pragma mark - UIButton
- (IBAction)checkBoxAction:(id)sender {
    checkd = !checkd;
    for (int index = 0; index < labelValues.count; index++) {
        UILabel *label = labelValues[index];
        UIStepper *stepper = steppers[index];
        
        if (checkd) {
            label.alpha = 1;
            stepper.enabled = YES;
            stepper.tintColor = [UIColor colorWithRed:0.000 green:0.478 blue:1.000 alpha:1.000];
            [_btnCheckBox setBackgroundImage:[UIImage imageNamed:@"223.png" inBundle:[NSBundle bundleWithIdentifier:@"com.Align.YumeKit"] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        }else{
        label.alpha = 0.5;
        stepper.enabled = NO;
        stepper.tintColor = [UIColor clearColor];
        [_btnCheckBox setBackgroundImage:[UIImage imageNamed:@"112.png" inBundle:[NSBundle bundleWithIdentifier:@"com.Align.YumeKit"] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - UIStepper

- (IBAction)stepperPGain:(id)sender {
    NSLog(@"%f",_stepperPGain.value);
    _labelPGainValue.text =[NSString stringWithFormat:@"%0.f",_stepperPGain.value];
}
- (IBAction)stepperIGain:(id)sender {
    NSLog(@"%f",_stepperIGain.value);
    _labelIGainValue.text =[NSString stringWithFormat:@"%0.f",_stepperIGain.value];
}
- (IBAction)stepperDGain:(id)sender {
    NSLog(@"%f",_stepperDGain.value);
    _labelDGainValue.text =[NSString stringWithFormat:@"%0.f",_stepperDGain.value];
}
- (IBAction)stepperPower:(id)sender {
    NSLog(@"%f",_stepperPower.value);
    _labelPowerValue.text =[NSString stringWithFormat:@"%0.f",_stepperPower.value];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
