//
//  yumeSwicthAndVoltageView.m
//  APSM
//
//  Created by APP559 on 2014/7/14.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "yumeSwicthAndVoltageView.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"

@interface yumeSwicthAndVoltageView ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *viewTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *viewContent1;
@property (weak, nonatomic) IBOutlet UILabel *viewContent2;
@property (weak, nonatomic) IBOutlet UILabel *labelUnit;

@property (weak,nonatomic) yumeRCPRemoteControllerParameter *segmentSource;
@property (weak,nonatomic) yumeRCPRemoteControllerParameter *textFieldSource;

@end

@implementation yumeSwicthAndVoltageView

- (void) setup{
    [super setup];
    [self addSubview:self.view];
    [_viewTitle setFont:[UIFont systemFontOfSize:_viewTitleTextFont]];
    [_viewTitle setBackgroundColor:_viewTitleColor];
}

-(void)viewLiveRendering{
    [super viewLiveRendering];
    self.view.backgroundColor = [UIColor clearColor];
}

-(void)processFuture{
    if (_segmentKeyPath) {
        _segmentSource = [YumeBTSharedInstance valueForKeyPath:_segmentKeyPath];
        [_segment setSelectedSegmentIndex:((int)(_segmentSource.valueUI + 1) % 2)];
    }
    
    if (_textFieldKeyPath) {
        _textFieldSource = [YumeBTSharedInstance valueForKeyPath:_textFieldKeyPath];
        _textField.text = [[_textFieldSource valueForKey:@"valueUI"] stringValue];
    }
}

-(void)processViewSource{
    _viewTitle.text = NSLocalizedString(self.viewSourceDictionary[@"viewTitle"], nil) ;
    _viewContent1.text = NSLocalizedString(self.viewSourceDictionary[@"viewContent1"], nil) ;
    _viewContent2.text = NSLocalizedString(self.viewSourceDictionary[@"viewContent2"], nil) ;
    _labelUnit.text = self.viewSourceDictionary[@"labelUnit"];
}

#pragma mark - TextField Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (_segment.selectedSegmentIndex == 0) {
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
    _textFieldSource.valueUI = textField.text.floatValue;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}

#pragma mark - Segment Method

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
    _segmentSource.valueUI = (float) ((sender.selectedSegmentIndex + 1) % 2);
}

@end
