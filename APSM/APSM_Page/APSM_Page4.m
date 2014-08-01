//
//  APSM_Page4.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/29.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "APSM_Page4.h"

@interface APSM_Page4 ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@end

@implementation APSM_Page4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.segment removeAllSegments];
    
    NSArray *array = @[NSLocalizedString(@"ON", nil),NSLocalizedString(@"OFF", nil)];
    for (int index = 0 ; index < array.count ; index++) {
        [self.segment insertSegmentWithTitle:(NSString *)array[index] atIndex:index animated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

- (IBAction)segmentAction:(UISegmentedControl *)sender {

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
