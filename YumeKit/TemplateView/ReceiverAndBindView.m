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
@property (weak, nonatomic) NSArray *array;


@property (weak,nonatomic) yumeRCPRemoteControllerParameter *receiverSource;
@property (weak,nonatomic) yumeRCPRemoteControllerParameter *bindingSource;
@end

@implementation ReceiverAndBindView

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
    
    _receiverArray = @[@"SBus",@"Traditional",@"SPK DMS2",@"SPK DMSX",@"Xbus",@"JR DMSS",@"FlySky"];
    _bindingArray = @[@"No bind",@"Binding",@"Binding with FS"];
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
    
    if (_receiverKeyPath) {
        _receiverSource = [YumeBTSharedInstance valueForKeyPath:_receiverKeyPath];
        
        [self.btnReceiver setTitle:[NSString stringWithFormat:@"%@",_receiverArray[(int)_receiverSource.valueUI]] forState:UIControlStateNormal];
    }
    
    if (_bindingKeyPath) {
        _bindingSource = [YumeBTSharedInstance valueForKeyPath:_bindingKeyPath];
        
        [self.btnBinding setTitle:[NSString stringWithFormat:@"%@",_bindingArray[(int)_bindingSource.valueUI]] forState:UIControlStateNormal];
    }
    
}

-(void)processViewSource{
    if (_labelReceiverText) {
        self.labelReceiver.text = self.labelReceiverText;
    }
    
    if (_labelBindingText) {
        self.labelBinding.text = self.labelBindingText;
    }
}

-(id)debugQuickLookObject{
    return self;
}

#pragma mark - Button Method 

- (IBAction)btnReceiverAction:(id)sender {
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:nil message:nil cancelButtonTitle:@"Cancel"];
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    alertView.contentView = picker;
    picker.dataSource = self;
    picker.delegate = self;
    [picker selectRow:_receiverSource.valueUI inComponent:0 animated:NO];
    _array = _receiverArray;
    [alertView addButtonWithTitle:@"OK"
                             type:CXAlertViewButtonTypeDefault
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              NSInteger selectedNumber = [picker selectedRowInComponent:0];
                              [self.btnReceiver setTitle:[NSString stringWithFormat:@"%@",_receiverArray[selectedNumber]] forState:UIControlStateNormal];
                              _receiverSource.valueUI = selectedNumber;
                              [alertView dismiss];
                          }];
    [alertView show];
    NSLog(@"btnReceiver be check");
}

- (IBAction)btnBindingAction:(id)sender {
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:nil message:nil cancelButtonTitle:@"Cancel"];
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    alertView.contentView = picker;
    picker.dataSource = self;
    picker.delegate = self;
    [picker selectRow:_bindingSource.valueUI inComponent:0 animated:NO];
    _array = _bindingArray;
    [alertView addButtonWithTitle:@"OK"
                             type:CXAlertViewButtonTypeDefault
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              NSInteger selectedNumber = [picker selectedRowInComponent:0];
                              [self.btnBinding setTitle:[NSString stringWithFormat:@"%@",_bindingArray[selectedNumber]] forState:UIControlStateNormal];
                              _bindingSource.valueUI = selectedNumber;
                              [alertView dismiss];
                          }];
    [alertView show];
    NSLog(@"btnBinding be check");
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



@end
