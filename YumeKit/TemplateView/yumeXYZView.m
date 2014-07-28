//
//  yumeXYZView.m
//  APSM
//
//  Created by APP559 on 2014/7/15.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "yumeXYZView.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"
#import "UITextField+Yume.h"

@interface yumeXYZView ()

@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *viewTitle;
@property (weak, nonatomic) IBOutlet UILabel *viewContent;
@property (weak, nonatomic) IBOutlet UILabel *labelX;
@property (weak, nonatomic) IBOutlet UILabel *labelY;
@property (weak, nonatomic) IBOutlet UILabel *labelZ;
@property (weak, nonatomic) IBOutlet UILabel *labelUnit;

@property (weak, nonatomic) IBOutlet UITextField *textFieldX;
@property (weak, nonatomic) IBOutlet UITextField *textFieldY;
@property (weak, nonatomic) IBOutlet UITextField *textFieldZ;

@end

@implementation yumeXYZView

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
    if (_xKeyPath) {
        _textFieldX.parameter = [YumeBTSharedInstance valueForKeyPath:_xKeyPath];
        _textFieldX.text = [[_textFieldX.parameter valueForKey:@"valueUI"] stringValue];
    }
    
    if (_yKeyPath) {
        _textFieldY.parameter = [YumeBTSharedInstance valueForKeyPath:_yKeyPath];
        _textFieldY.text = [[_textFieldY.parameter valueForKey:@"valueUI"] stringValue];
    }
    
    if (_zKeyPath) {
        _textFieldZ.parameter = [YumeBTSharedInstance valueForKeyPath:_zKeyPath];
        _textFieldZ.text = [[_textFieldZ.parameter valueForKey:@"valueUI"] stringValue];
    }
}

-(void)processViewSource{
    if (_viewTitleText) {
        _viewTitle.text = NSLocalizedString(_viewTitleText, nil);
    }
    
    if (_viewContentText) {
        _viewContent.text = NSLocalizedString(_viewContentText, nil);
    }
    
    if (_xText) {
        _labelX.text = NSLocalizedString(_xText, nil);
    }
    
    if (_yText) {
        _labelY.text = NSLocalizedString(_yText, nil);
    }
    
    if (_zText) {
        _labelZ.text = NSLocalizedString(_zText, nil);
    }
    
    if (_unitText) {
        _labelUnit.text = _unitText;
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
