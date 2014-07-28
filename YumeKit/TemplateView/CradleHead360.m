//
//  CradleHead360.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/21.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "CradleHead360.h"
#import "UITextField+Yume.h"
#import "ViewSource.h"

@interface CradleHead360()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *labelMainTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *labelSubTitle;

@property (weak, nonatomic) IBOutlet UILabel *labelDegree0;
@property (weak, nonatomic) IBOutlet UILabel *labelDegree15;
@property (weak, nonatomic) IBOutlet UILabel *labelDegree30;
@property (weak, nonatomic) IBOutlet UILabel *labelDegree90;

@property (weak, nonatomic) IBOutlet UILabel *labelDegree0Unit;
@property (weak, nonatomic) IBOutlet UILabel *labelDegree15Unit;
@property (weak, nonatomic) IBOutlet UILabel *labelDegree30Unit;
@property (weak, nonatomic) IBOutlet UILabel *labelDegree90Unit;

@property (weak, nonatomic) IBOutlet UITextField *textFieldDegree0;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDegree15;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDegree30;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDegree90;

@end

@implementation CradleHead360

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

-(void) processFuture{
    
}

-(void) processViewSource{
    if (_labelMainTitleKeyPath) {
        self.labelMainTitle.text = NSLocalizedString(self.labelMainTitleKeyPath, nil) ;
    }
    
    if (_labelSubTitleKeyPath) {
        self.labelSubTitle.text = NSLocalizedString(self.labelSubTitleKeyPath, nil) ;
    }
    
    if (_labelDegree0KeyPath) {
        self.labelDegree0.text = NSLocalizedString(self.labelDegree0KeyPath, nil) ;
    }
    
    if (_labelDegree15KeyPath) {
        self.labelDegree15.text = NSLocalizedString(self.labelDegree15KeyPath, nil) ;
    }
    
    if (_labelDegree30KeyPath) {
        self.labelDegree30.text = NSLocalizedString(self.labelDegree30KeyPath, nil) ;
    }
    
    if (_labelDegree90KeyPath) {
        self.labelDegree90.text = NSLocalizedString(self.labelDegree90KeyPath, nil) ;
    }
    
    if (_labelUnitKeyPath) {
        self.labelDegree0Unit.text = NSLocalizedString(self.labelUnitKeyPath, nil) ;
        self.labelDegree15Unit.text = NSLocalizedString(self.labelUnitKeyPath, nil) ;
        self.labelDegree30Unit.text = NSLocalizedString(self.labelUnitKeyPath, nil) ;
        self.labelDegree90Unit.text = NSLocalizedString(self.labelUnitKeyPath, nil) ;
    }
}

-(id)debugQuickLookObject{
    return self;
}



#pragma mark - TextField Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (_segmentedControl.selectedSegmentIndex == 0) {
        return YES;
    }else{
        return NO;
    }
}

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
//    _textFieldSource.valueUI = textField.text.floatValue;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}

#pragma mark - Segment Method

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
//    _segmentSource.valueUI = (float) ((sender.selectedSegmentIndex + 1) % 2);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
