//
//  AngleOfVisibilityView.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/19.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "AngleOfVisibilityView.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"
#import "CXAlertView.h"

typedef NSInteger(^yumeAdapter)(NSInteger value);

@interface AngleOfVisibilityView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnAngleOfVisibility;

@property (strong, nonatomic) NSArray * angleArray;

@property (weak,nonatomic) yumeRCPRemoteControllerParameter *buttonSource;

@property (strong) yumeAdapter adapterToUI;
//@property (strong) yumeAdapter adapterToMCU;

@end

@implementation AngleOfVisibilityView


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
    
    _btnAngleOfVisibility.tintColor = [UIColor whiteColor];
    
    _angleArray = @[@"30度",@"60度",@"90度", @"120度"];
    _adapterToUI = ^NSInteger(NSInteger angle) {
        NSInteger index = 0;
        switch (angle) {
            case 120:
                index++;
            case 90:
                index++;
            case 60:
                index++;
            case 30:
                break;
                
            default:
                break;
        }
        return index;
    };
//    _adapterToMCU = ^NSInteger(NSInteger index) {
//        NSInteger angle = 0;
//        switch (index) {
//            case 3:
//                angle += 30;
//            case 2:
//                angle += 30;
//            case 1:
//                angle += 30;
//            case 0:
//                angle += 30;
//                break;
//                
//            default:
//                break;
//        }
//        return angle;
//    };
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
    if (_buttonKeyPath) {
        _buttonSource = [YumeBTSharedInstance valueForKeyPath:_buttonKeyPath];
        
        NSInteger index = _adapterToUI( _buttonSource.valueUI );
        [_btnAngleOfVisibility setTitle:[NSString stringWithFormat:@"%@",_angleArray[index]] forState:UIControlStateNormal];
    }
}

-(void)processViewSource{
    
}

-(id)debugQuickLookObject{
    return self;
}

#pragma mark - Button Method

- (IBAction)btnAngleAction:(id)sender {
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(-15, 0, 300, 200)];
    picker.dataSource = self;
    picker.delegate = self;
    
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:nil contentView:picker cancelButtonTitle:NSLocalizedString(@"Cancel", nil) ];
   
    [alertView addButtonWithTitle:NSLocalizedString(@"OK", nil)
                             type:CXAlertViewButtonTypeCancel
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              NSInteger selectedNumber = [picker selectedRowInComponent:0];
                              [self.btnAngleOfVisibility setTitle:[NSString stringWithFormat:@"%@",_angleArray[selectedNumber]] forState:UIControlStateNormal];
                              
                              float angle = [_angleArray[selectedNumber] floatValue];
                              _buttonSource.valueUI = angle;
                              [alertView dismiss];
                          }];
    [alertView show];
    [picker selectRow:_adapterToUI(_buttonSource.valueUI) inComponent:0 animated:NO];
}

#pragma mark - Picker Method

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _angleArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _angleArray[row];
}

-(CGFloat)pickerView:(UIPickerView*)pickerView rowHeightForComponent:(NSInteger)component{
    return 100;
}

-(CGFloat)pickerView:(UIPickerView*)pickerView widthForComponent:(NSInteger)component{
    return 300;
}
@end
