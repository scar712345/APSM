//
//  yumeHeightWarningView.m
//  APSM
//
//  Created by APP559 on 2014/7/24.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "yumeHeightWarningView.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"

@interface yumeHeightWarningView ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *viewTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UILabel *viewContent1;
@property (weak, nonatomic) IBOutlet UILabel *viewContent2;
@property (weak, nonatomic) IBOutlet UILabel *labelUnit1;
@property (weak, nonatomic) IBOutlet UILabel *labelUnit2;

@property (weak,nonatomic) yumeRCPRemoteControllerParameter *segmentSource;
@property (weak,nonatomic) yumeRCPRemoteControllerParameter *textField1Source;
@property (weak,nonatomic) yumeRCPRemoteControllerParameter *textField2Source;

@end

@implementation yumeHeightWarningView

- (void) setup{
    [super setup];
    [self addSubview:self.view];
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
    
    if (_textField1KeyPath) {
        _textField1Source = [YumeBTSharedInstance valueForKeyPath:_textField1KeyPath];
        _textField1.text = [[_textField1Source valueForKey:@"valueUI"] stringValue];
    }
    
    if (_textField2KeyPath) {
        _textField2Source = [YumeBTSharedInstance valueForKeyPath:_textField2KeyPath];
        _textField2.text = [[_textField2Source valueForKey:@"valueUI"] stringValue];
    }
}

-(void)processViewSource{
    _viewTitle.text = self.viewSourceDictionary[@"viewTitle"];
    _viewContent1.text = self.viewSourceDictionary[@"viewContent1"];
    _viewContent2.text = self.viewSourceDictionary[@"viewContent2"];
    _labelUnit1.text = self.viewSourceDictionary[@"labelUnit1"];
    _labelUnit2.text = self.viewSourceDictionary[@"labelUnit2"];
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
    
    if (textField == self.textField1) {
        _textField1Source.valueUI = textField.text.floatValue;
    }
    
    if (textField == self.textField2) {
        _textField2Source.valueUI = textField.text.floatValue;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}

#pragma mark - Segment Method

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
    _segmentSource.valueUI = (float) ((sender.selectedSegmentIndex + 1) % 2);
}

@end
