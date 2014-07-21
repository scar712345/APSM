//
//  yumeSensitivityView.m
//  APSM
//
//  Created by APP559 on 2014/7/15.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "yumeSensitivityView.h"
#import "UITextField+Yume.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"

@interface yumeSensitivityView ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *viewTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelMode;
@property (weak, nonatomic) IBOutlet UILabel *labelAileron;
@property (weak, nonatomic) IBOutlet UILabel *labelElevator;
@property (weak, nonatomic) IBOutlet UILabel *labelRudder;
@property (weak, nonatomic) IBOutlet UILabel *labelAltitude;
@property (weak, nonatomic) IBOutlet UILabel *labelManual;
@property (weak, nonatomic) IBOutlet UILabel *labelAltitude2;

@property (weak, nonatomic) IBOutlet UITextField *textFieldManualAileron;
@property (weak, nonatomic) IBOutlet UITextField *textFieldManualElevator;
@property (weak, nonatomic) IBOutlet UITextField *textFieldManualRudder;

@property (weak, nonatomic) IBOutlet UITextField *textFieldAltitudeAileron;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAltitudeElevator;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAltitudeRudder;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAltitudeAltitude;

@end

@implementation yumeSensitivityView

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
}

-(void)prepareForInterfaceBuilder{
    [self viewLiveRendering];
}


- (void)drawRect:(CGRect)rect{
    self.layer.borderColor = _borderColor.CGColor;
    self.layer.borderWidth = _borderLineWidth;
    
    if( [self.layer respondsToSelector:@selector(setCornerRadius:)] )
        [self.layer setCornerRadius:_borderRadius];
    
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
    if (_manualAileronKeyPath) {
        _textFieldManualAileron.parameter = [YumeBTSharedInstance valueForKeyPath:_manualAileronKeyPath];
        _textFieldManualAileron.text = [[_textFieldManualAileron.parameter valueForKey:@"valueUI"] stringValue];
    }
    
    if (_manualElevatorKeyPath) {
        _textFieldManualElevator.parameter = [YumeBTSharedInstance valueForKeyPath:_manualElevatorKeyPath];
        _textFieldManualElevator.text = [[_textFieldManualElevator.parameter valueForKey:@"valueUI"] stringValue];
    }
    
    if (_manualRudderKeyPath) {
        _textFieldManualRudder.parameter = [YumeBTSharedInstance valueForKeyPath:_manualRudderKeyPath];
        _textFieldManualRudder.text = [[_textFieldManualRudder.parameter valueForKey:@"valueUI"] stringValue];
    }
    
    if (_altitudeAileronKeyPath) {
        _textFieldAltitudeAileron.parameter = [YumeBTSharedInstance valueForKeyPath:_altitudeAileronKeyPath];
        _textFieldAltitudeAileron.text = [[_textFieldAltitudeAileron.parameter valueForKey:@"valueUI"] stringValue];
    }
    
    if (_altitudeElevatorKeyPath) {
        _textFieldAltitudeElevator.parameter = [YumeBTSharedInstance valueForKeyPath:_altitudeElevatorKeyPath];
        _textFieldAltitudeElevator.text = [[_textFieldAltitudeElevator.parameter valueForKey:@"valueUI"] stringValue];
    }
    
    if (_altitudeRudderKeyPath) {
        _textFieldAltitudeRudder.parameter = [YumeBTSharedInstance valueForKeyPath:_altitudeRudderKeyPath];
        _textFieldAltitudeRudder.text = [[_textFieldAltitudeRudder.parameter valueForKey:@"valueUI"] stringValue];
    }
    
    if (_altitudeAltitudeKeyPath) {
        _textFieldAltitudeAltitude.parameter = [YumeBTSharedInstance valueForKeyPath:_altitudeAltitudeKeyPath];
        _textFieldAltitudeAltitude.text = [[_textFieldAltitudeAltitude.parameter valueForKey:@"valueUI"] stringValue];
    }
}

-(void)processViewSource{
    if (self.viewTitleText) {
        self.viewTitle.text = _viewTitleText;
    }
    
    if (self.labelModeText) {
        self.labelMode.text = _labelModeText;
    }
    
    if (self.labelAileronText) {
        self.labelAileron.text = _labelAileronText;
    }
    
    if (self.labelElevatorText) {
        self.labelElevator.text = _labelElevatorText;
    }
    
    if (self.labelRudderText) {
        self.labelRudder.text = _labelRudderText;
    }
    
    if (self.labelAltitudeText) {
        self.labelAltitude.text = _labelAltitudeText;
    }
    
    if (self.labelManualText) {
        self.labelManual.text = _labelManualText;
    }
    
    if (self.labelAltitude2Text) {
        self.labelAltitude2.text = _labelAltitude2Text;
    }
}

-(id)debugQuickLookObject{
    return self;
}

#pragma mark - TextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSString *expression = @"^[0-9]*(\\.)?[0-9]*$";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                        options:0
                                                          range:NSMakeRange(0, [newString length])];
    if (numberOfMatches == 0)
        return NO;
    
//    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
//    [f setNumberStyle:NSNumberFormatterDecimalStyle];
//    NSNumber *num = [f numberFromString:newString];
//    if ([num floatValue] > [[textField.parameter valueForKey:@"parameterMax"] floatValue] ||
//        [num floatValue] < [[textField.parameter valueForKey:@"parameterMin"] floatValue])
//        return NO;
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.parameter.valueUI = textField.text.floatValue;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}

@end
