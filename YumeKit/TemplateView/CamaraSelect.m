//
//  CamaraSelect.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/29.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "CamaraSelect.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"
#import "CXAlertView.h"


@interface CamaraSelect()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *labelViewTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnCamaraSelect;

@property (strong, nonatomic) NSArray *camaraArray;
@end


@implementation CamaraSelect


- (void) setup{
    [super setup];
    [self addSubview:self.view];
    
    _camaraArray = @[@"Sony NEX7",@"Sony NEX7",@"Sony NEX7",@"Sony NEX7"];
}

-(void)viewLiveRendering{
    [super viewLiveRendering];
    self.view.backgroundColor = [UIColor clearColor];
}

-(void)processFuture{
//    if (_buttonKeyPath) {
//        _buttonSource = [YumeBTSharedInstance valueForKeyPath:_buttonKeyPath];
//        
//        NSInteger index = _adapterToUI( _buttonSource.valueUI );
//        [_btnAngleOfVisibility setTitle:[NSString stringWithFormat:@"%@",_angleArray[index]] forState:UIControlStateNormal];
//    }
}

//-(void)processViewSource{
//
//}

-(void)processStoryboardSource{
    if (_labelViewTitleText) {
        self.labelViewTitle.text = NSLocalizedString(self.labelViewTitleText, nil) ;
    }
}

#pragma mark - Button Method

- (IBAction)btnCamaraSelectAction:(id)sender {
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(-15, 0, 300, 200)];
    picker.dataSource = self;
    picker.delegate = self;
    
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:nil contentView:picker cancelButtonTitle:NSLocalizedString(@"Cancel", nil) ];
    
    [alertView addButtonWithTitle:NSLocalizedString(@"OK", nil)
                             type:CXAlertViewButtonTypeCancel
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              NSInteger selectedNumber = [picker selectedRowInComponent:0];
                              [self.btnCamaraSelect setTitle:[NSString stringWithFormat:@"%@",_camaraArray[selectedNumber]] forState:UIControlStateNormal];
                              
                              [alertView dismiss];
                          }];
    [alertView show];
//    [picker selectRow:_receiverSource.valueUI inComponent:0 animated:NO];

}

#pragma mark - Picker Method

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _camaraArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _camaraArray[row];
}

-(CGFloat)pickerView:(UIPickerView*)pickerView rowHeightForComponent:(NSInteger)component{
    return 100;
}

-(CGFloat)pickerView:(UIPickerView*)pickerView widthForComponent:(NSInteger)component{
    return 300;
}
@end
