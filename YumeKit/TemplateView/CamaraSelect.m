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
@property (weak,nonatomic) yumeRCPRemoteControllerParameter *camaraSource;
@end


@implementation CamaraSelect


- (void) setup{
    [super setup];
    [self addSubview:self.view];
    
    _camaraArray = @[@"Sony NEX7 1",@"Sony NEX7 2",@"Sony NEX7 3",@"Sony NEX7 4"];
}

-(void)viewLiveRendering{
    [super viewLiveRendering];
    self.view.backgroundColor = [UIColor clearColor];
}

-(void)processFuture{
    if (_btnCamaraSelectKeyPath) {
        _camaraSource = [YumeBTSharedInstance valueForKeyPath:_btnCamaraSelectKeyPath];
        [self.btnCamaraSelect setTitle:[NSString stringWithFormat:@"%@",_camaraArray[(int)_camaraSource.valueUI]] forState:UIControlStateNormal];
    }
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
                               _camaraSource.valueUI = selectedNumber;
                              [alertView dismiss];
                          }];
    [alertView show];
    [picker selectRow:_camaraSource.valueUI inComponent:0 animated:NO];

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
