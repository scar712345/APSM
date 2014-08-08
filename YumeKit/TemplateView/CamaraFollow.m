//
//  CamaraFollow.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/28.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "CamaraFollow.h"
#import "CXAlertView.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"

typedef NSInteger(^yumeAdapter)(NSInteger value);

@interface CamaraFollow()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *viewTitle;
@property (weak, nonatomic) IBOutlet UILabel *viewContent1;
@property (weak, nonatomic) IBOutlet UILabel *viewContent2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;


@property (weak, nonatomic) IBOutlet UIButton *btnFollowSpeed;
@property (weak, nonatomic) IBOutlet UIButton *btnFollowAngle;

@property (strong, nonatomic) NSArray *followSpeedArray;
@property (strong, nonatomic) NSArray *followAngleArray;
@property (strong, nonatomic) NSArray *array;

@property (weak,nonatomic) yumeRCPRemoteControllerParameter *followSpeedSource;
@property (weak,nonatomic) yumeRCPRemoteControllerParameter *followAngleSource;
@property (strong) yumeAdapter adapterToUI;
@end

@implementation CamaraFollow

- (void) setup{
    [super setup];
    [self addSubview:self.view];
    
    _followSpeedArray = @[@"慢",@"中",@"快"];
    _followAngleArray = @[@"15°",@"30°",@"45°"];
    _adapterToUI = ^NSInteger(NSInteger angle) {
        NSInteger index = 0;
        switch (angle) {
            case 45:
                index++;
            case 30:
                index++;
            case 15:
                break;
            default:
                break;
        }
        return index;
    };

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
    [super viewLiveRendering];
    self.view.backgroundColor = [UIColor clearColor];
}

-(void) processFuture{
    if (_followSpeedKeyPath) {
        _followSpeedSource = [YumeBTSharedInstance valueForKeyPath:_followSpeedKeyPath];
        [self.btnFollowSpeed setTitle:[NSString stringWithFormat:@"%@",_followSpeedArray[(int)_followSpeedSource.valueUI]] forState:UIControlStateNormal];
    }
    
    if (_followAngleKeyPath) {
        _followAngleSource = [YumeBTSharedInstance valueForKeyPath:_followAngleKeyPath];
        
        NSInteger index = _adapterToUI( _followAngleSource.valueUI );
        [self.btnFollowAngle setTitle:[NSString stringWithFormat:@"%@",_followAngleArray[index]] forState:UIControlStateNormal];
    }
}

-(void) processViewSource{
    _viewTitle.text = self.viewSourceDictionary[@"viewTitle"];
    _viewContent1.text = self.viewSourceDictionary[@"viewContent1"];
    _viewContent2.text = self.viewSourceDictionary[@"viewContent2"];
    NSArray *segmentedControl  = self.viewSourceDictionary[@"segmentedControl"];
        
    [_segmentedControl removeAllSegments];
    for (int index = 0 ; index < segmentedControl.count ; index++) {
        [self.segmentedControl insertSegmentWithTitle:(NSString *)segmentedControl[index] atIndex:index animated:NO];
    }
}

-(id)debugQuickLookObject{
    return self;
}

#pragma mark - Button Method

- (IBAction)followSpeed:(id)sender {
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(-15, 0, 300, 200)];
    picker.dataSource = self;
    picker.delegate = self;
    
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:nil contentView:picker cancelButtonTitle:NSLocalizedString(@"Cancel", nil) ];
    
    _array = _followSpeedArray;
    [alertView addButtonWithTitle:NSLocalizedString(@"OK", nil)
                             type:CXAlertViewButtonTypeCancel
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              NSInteger selectedNumber = [picker selectedRowInComponent:0];
                              [self.btnFollowSpeed setTitle:[NSString stringWithFormat:@"%@",_followSpeedArray[selectedNumber]] forState:UIControlStateNormal];
                              _followSpeedSource.valueUI = selectedNumber;
                              [alertView dismiss];
                          }];
    [alertView show];
    [picker selectRow:_followSpeedSource.valueUI inComponent:0 animated:NO];
}
- (IBAction)followAngle:(id)sender {
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(-15, 0, 300, 200)];
    picker.dataSource = self;
    picker.delegate = self;
    
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:nil contentView:picker cancelButtonTitle:NSLocalizedString(@"Cancel", nil) ];
    
    _array = _followAngleArray;
    [alertView addButtonWithTitle:NSLocalizedString(@"OK", nil)
                             type:CXAlertViewButtonTypeCancel
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              NSInteger selectedNumber = [picker selectedRowInComponent:0];
                              [self.btnFollowAngle setTitle:[NSString stringWithFormat:@"%@",_followAngleArray[selectedNumber]] forState:UIControlStateNormal];
                              
                               float angle = [_followAngleArray[selectedNumber] floatValue];
                              _followAngleSource.valueUI = angle;
                              [alertView dismiss];
                          }];
    
    [alertView show];
    [picker selectRow:_adapterToUI(_followAngleSource.valueUI) inComponent:0 animated:NO];
}


#pragma mark - Picker Method

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _array.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _array[row];
}

-(CGFloat)pickerView:(UIPickerView*)pickerView rowHeightForComponent:(NSInteger)component{
    return 100;
}

-(CGFloat)pickerView:(UIPickerView*)pickerView widthForComponent:(NSInteger)component{
    return 300;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
