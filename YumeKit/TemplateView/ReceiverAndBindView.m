//
//  ReceiverAndBindView.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/17.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "ReceiverAndBindView.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"
#import "CXAlertView.h"

@interface ReceiverAndBindView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *labelReceiver;
@property (weak, nonatomic) IBOutlet UILabel *labelBinding;
@property (weak, nonatomic) IBOutlet UIButton *btnReceiver;
@property (weak, nonatomic) IBOutlet UIButton *btnBinding;

@property (strong, nonatomic) NSArray *receiverArray;
@property (strong, nonatomic) NSArray *bindingArray;
@property (strong, nonatomic) NSArray *array;

@property (weak,nonatomic) yumeRCPRemoteControllerParameter *receiverSource;
@property (weak,nonatomic) yumeRCPRemoteControllerParameter *bindingSource;
@end

@implementation ReceiverAndBindView

- (void) setup{
    [super setup];
    
    [self addSubview:self.view];
    
    _receiverArray = @[@"SBus",@"Traditional",@"SPK DMS2",@"SPK DMSX",@"Xbus",@"JR DMSS",@"FlySky"];
    _bindingArray = @[@"No bind",@"Binding",@"Binding with Failed Safe"];
}


-(void)viewLiveRendering{
    [super viewLiveRendering];
    
    self.view.backgroundColor = [UIColor clearColor];
}

-(void)processFuture{
    
    if (_receiverKeyPath) {
        _receiverSource = [YumeBTSharedInstance valueForKeyPath:_receiverKeyPath];
        
        [self.btnReceiver setTitle:[NSString stringWithFormat:@"%@",_receiverArray[(int)_receiverSource.valueUI]] forState:UIControlStateNormal];
    }
    
    if (_bindingKeyPath) {
        _bindingSource = [YumeBTSharedInstance valueForKeyPath:_bindingKeyPath];
        
        [self.btnBinding setTitle:[NSString stringWithFormat:@"%@",_bindingArray[(int)_bindingSource.valueUI]] forState:UIControlStateNormal];
    }
    
}

//-(void)processViewSource{
//    
//}

-(void)processStoryboardSource{
    if (_labelReceiverText) {
        self.labelReceiver.text = NSLocalizedString(self.labelReceiverText, nil) ;
    }
    
    if (_labelBindingText) {
        self.labelBinding.text =NSLocalizedString(self.labelBindingText, nil) ;
    }
}

#pragma mark - Button Method 

- (IBAction)btnReceiverAction:(id)sender {
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(-15, 0, 300, 200)];
    picker.dataSource = self;
    picker.delegate = self;
    
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:nil contentView:picker cancelButtonTitle:NSLocalizedString(@"Cancel", nil) ];
    
    _array = _receiverArray;
    [alertView addButtonWithTitle:NSLocalizedString(@"OK", nil)
                             type:CXAlertViewButtonTypeCancel
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              NSInteger selectedNumber = [picker selectedRowInComponent:0];
                              [self.btnReceiver setTitle:[NSString stringWithFormat:@"%@",_receiverArray[selectedNumber]] forState:UIControlStateNormal];
                              _receiverSource.valueUI = selectedNumber;
                              [alertView dismiss];
                          }];
    [alertView show];
    [picker selectRow:_receiverSource.valueUI inComponent:0 animated:NO];
}

- (IBAction)btnBindingAction:(id)sender {
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(-15, 0, 300, 200)];
    picker.dataSource = self;
    picker.delegate = self;
    
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:nil contentView:picker cancelButtonTitle:NSLocalizedString(@"Cancel", nil) ];
 
    _array = _bindingArray;
    [alertView addButtonWithTitle:NSLocalizedString(@"OK", nil)
                             type:CXAlertViewButtonTypeCancel
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              NSInteger selectedNumber = [picker selectedRowInComponent:0];
                              [self.btnBinding setTitle:[NSString stringWithFormat:@"%@",_bindingArray[selectedNumber]] forState:UIControlStateNormal];
                              _bindingSource.valueUI = selectedNumber;
                              [alertView dismiss];
                          }];

    [alertView show];
    [picker selectRow:_bindingSource.valueUI inComponent:0 animated:NO];
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
@end
