//
//  LabelAndTextfiled.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/29.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "LabelAndTextfiled.h"

@interface LabelAndTextfiled()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *viewTitle;
@property (weak, nonatomic) IBOutlet UILabel *viewContent1;
@property (weak, nonatomic) IBOutlet UILabel *labelUnit;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end

@implementation LabelAndTextfiled

- (void) setup{
    [super setup];
    [self addSubview:self.view];
}

-(void)viewLiveRendering{
    [super viewLiveRendering];
    self.view.backgroundColor = [UIColor clearColor];
}

-(void)processFuture{
//    if (_textFieldKeyPath) {
//        _textFieldSource = [YumeBTSharedInstance valueForKeyPath:_textFieldKeyPath];
//        _textField.text = [[_textFieldSource valueForKey:@"valueUI"] stringValue];
//    }
}

-(void)processViewSource{
    _viewTitle.text = self.viewSourceDictionary[@"viewTitle"];
    _viewContent1.text = self.viewSourceDictionary[@"viewContent1"];
    _labelUnit.text = self.viewSourceDictionary[@"labelUnit"];
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
//    _textFieldSource.valueUI = textField.text.floatValue;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}
@end
