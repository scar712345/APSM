//
//  CamaraFollow.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/28.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "CamaraFollow.h"
#import "ViewSource.h"


@interface CamaraFollow()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *viewTitle;
@property (weak, nonatomic) IBOutlet UILabel *viewContent1;
@property (weak, nonatomic) IBOutlet UILabel *viewContent2;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;@end

@implementation CamaraFollow

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
    NSArray *array = @[@"seg1",@"seg2"];
    
    if (_viewSourceKeyPath) {
        NSDictionary *dict = [ViewSourceInstance valueForKey:_viewSourceKeyPath];
        
        NSString *type = dict[@"type"];
        NSString *className = NSStringFromClass([self class]);
        
        if ([className isEqualToString:type]) {
            _viewTitle.text = NSLocalizedString(dict[@"viewTitle"], nil) ;
            _viewContent1.text = NSLocalizedString(dict[@"viewContent1"], nil);
            _viewContent2.text = NSLocalizedString(dict[@"viewContent2"],nil);
            array = dict[@"segmentedControl"];
            _segmentedControl = [[UISegmentedControl alloc] initWithItems:array];
            }
    }else{
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:array];
    }
    _segmentedControl.frame = CGRectMake(111, 6, 181, 29);
    _segmentedControl.tintColor = [UIColor whiteColor];
    //    _segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:_segmentedControl];
    
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
    //    textField.parameter.valueUI = textField.text.floatValue;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
