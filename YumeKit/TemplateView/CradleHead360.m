//
//  CradleHead360.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/21.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "CradleHead360.h"
#import "ParameterExtension.h"
#import "CXAlertView.h"


@interface CradleHead360()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *labelMainTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *labelSubTitle;

@property (weak, nonatomic) IBOutlet UILabel *labelDegree0;
@property (weak, nonatomic) IBOutlet UILabel *labelDegree15;
@property (weak, nonatomic) IBOutlet UILabel *labelDegree30;
@property (weak, nonatomic) IBOutlet UILabel *labelDegree90;

@property (weak, nonatomic) IBOutlet UILabel *labelDegree0Unit;
@property (weak, nonatomic) IBOutlet UILabel *labelDegree15Unit;
@property (weak, nonatomic) IBOutlet UILabel *labelDegree30Unit;
@property (weak, nonatomic) IBOutlet UILabel *labelDegree90Unit;

@property (weak, nonatomic) IBOutlet UIButton *btnDegree0;
@property (weak, nonatomic) IBOutlet UIButton *btnDegree15;
@property (weak, nonatomic) IBOutlet UIButton *btnDegree30;
@property (weak, nonatomic) IBOutlet UIButton *btnDegree90;

@property (strong, nonatomic) NSArray *arrayItem;
@property (strong, nonatomic) NSArray *array;

@end

@implementation CradleHead360

- (void) setup{
    [super setup];
    [self addSubview:self.view];
    
    _arrayItem = @[@"1",@"4",@"8",@"12",@"20",@"24",@"30",@"36"];
    
    NSArray *segmentedControlItem = @[@"seg1",@"seg2"];
    [self.segmentedControl removeAllSegments];
    for (int index = 0 ; index < segmentedControlItem.count ; index++) {
        [self.segmentedControl insertSegmentWithTitle:(NSString *)segmentedControlItem[index] atIndex:index animated:NO];
    }
}

-(void)viewLiveRendering{
    [super viewLiveRendering];
    self.view.backgroundColor = [UIColor clearColor];
}

//-(void) processFuture{
//    
//}

-(void) processStoryBoardSource{

    if (_labelMainTitleKeyPath) {
        self.labelMainTitle.text = NSLocalizedString(self.labelMainTitleKeyPath, nil) ;
    }
    
    if (_labelSubTitleKeyPath) {
        self.labelSubTitle.text = NSLocalizedString(self.labelSubTitleKeyPath, nil) ;
    }
    
    if (_labelDegree0KeyPath) {
        self.labelDegree0.text = NSLocalizedString(self.labelDegree0KeyPath, nil) ;
    }
    
    if (_labelDegree15KeyPath) {
        self.labelDegree15.text = NSLocalizedString(self.labelDegree15KeyPath, nil) ;
    }
    
    if (_labelDegree30KeyPath) {
        self.labelDegree30.text = NSLocalizedString(self.labelDegree30KeyPath, nil) ;
    }
    
    if (_labelDegree90KeyPath) {
        self.labelDegree90.text = NSLocalizedString(self.labelDegree90KeyPath, nil) ;
    }
    
    if (_labelUnitKeyPath) {
        self.labelDegree0Unit.text = NSLocalizedString(self.labelUnitKeyPath, nil) ;
        self.labelDegree15Unit.text = NSLocalizedString(self.labelUnitKeyPath, nil) ;
        self.labelDegree30Unit.text = NSLocalizedString(self.labelUnitKeyPath, nil) ;
        self.labelDegree90Unit.text = NSLocalizedString(self.labelUnitKeyPath, nil) ;
    }
}

#pragma mark - Segment Method

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
//    _segmentSource.valueUI = (float) ((sender.selectedSegmentIndex + 1) % 2);
}

#pragma mark button Method

- (IBAction)btnDegree0Action:(id)sender {
    [self creatCXAlertViewWithArray:_arrayItem WithButton:_btnDegree0];
}

- (IBAction)btnDegree15Action:(id)sender {
    [self creatCXAlertViewWithArray:_arrayItem WithButton:_btnDegree15];
}

- (IBAction)btnDegree30Action:(id)sender {
    [self creatCXAlertViewWithArray:_arrayItem WithButton:_btnDegree30];
}

- (IBAction)btnDegree90Action:(id)sender {
    [self creatCXAlertViewWithArray:_arrayItem WithButton:_btnDegree90];
}

#pragma mark CXAlertView Method

-(void)creatCXAlertViewWithArray:(NSArray *)arrayItem WithButton:(UIButton *)btnSender{
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(-15, 0, 300, 200)];
    picker.dataSource = self;
    picker.delegate = self;
    
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:nil contentView:picker cancelButtonTitle:NSLocalizedString(@"Cancel", nil) ];
    
    _array = arrayItem;
    [alertView addButtonWithTitle:NSLocalizedString(@"OK", nil)
                             type:CXAlertViewButtonTypeCancel
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              NSInteger selectedNumber = [picker selectedRowInComponent:0];
                              [btnSender setTitle:[NSString stringWithFormat:@"%@",arrayItem[selectedNumber]] forState:UIControlStateNormal];
                              //                              _bindingSource.valueUI = selectedNumber;
                              [alertView dismiss];
                          }];
    
    [alertView show];
    //    [picker selectRow:_bindingSource.valueUI inComponent:0 animated:NO];
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
