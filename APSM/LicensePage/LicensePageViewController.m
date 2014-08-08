//
//  LicensePageViewController.m
//  test
//
//  Created by ALIGN-APP on 2014/5/28.
//  Copyright (c) 2014年 ALIGN-APP. All rights reserved.
//

#import "LicensePageViewController.h"
#import "Language.h"

#import "VerticalUILabel.h"
@interface LicensePageViewController ()
{
    BOOL checked;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckBox;
@property (weak, nonatomic) IBOutlet UIButton *btnEnter;
@property (weak, nonatomic) IBOutlet VerticalUILabel *labelLicense;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@end

@implementation LicensePageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.labelTitle setFont:[UIFont boldSystemFontOfSize:15]];
    self.labelTitle.text = NSLocalizedString(@"Gimbal Disclaimer:",nil);
    
    self.labelLicense.verticalAlignment = VerticalAlignmentTop;
    self.labelLicense.text = NSLocalizedString(@"License",nil);
    checked = NO;
    self.btnEnter.enabled = NO;
    self.btnCheckBox.titleLabel.numberOfLines=2;
    [self.btnEnter setTitle:NSLocalizedString(@"Entering Gpro",nil) forState:UIControlStateNormal];
    [self.btnCheckBox setTitle:NSLocalizedString(@"I understand and agree",nil) forState:UIControlStateNormal];
    [self.btnCheckBox setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forState:UIControlStateNormal];
//    [[self.btnCheckBox layer] setBorderWidth:0.5f];
    [[self.btnCheckBox layer] setBorderColor:[UIColor whiteColor].CGColor];
    self.scroll.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCheckBox:(id)sender {
    checked = !checked;
    if (checked) {
        self.btnEnter.enabled = YES;
        [self.btnCheckBox setImage:[UIImage imageNamed:@"223.png"] forState:UIControlStateNormal];
        [self.btnCheckBox setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateNormal];
    }
    else{
        self.btnEnter.enabled = NO;
        [self.btnCheckBox setImage:[UIImage imageNamed:@"112.png"] forState:UIControlStateNormal];
        [self.btnCheckBox setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forState:UIControlStateNormal];
    }
}

- (IBAction)btnSubmit:(id)sender {

    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"licensed"];
    id vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
    [self presentViewController:vc animated:NO completion:^{
        //
    }];
}

-(void)viewDidLayoutSubviews{

    CGSize maximumLabelSize = CGSizeMake(320, FLT_MAX);
    NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17] forKey: NSFontAttributeName];
    CGRect frame = [self.labelLicense.text boundingRectWithSize:maximumLabelSize
                                                        options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:stringAttributes context:nil];
    self.scroll.contentSize = CGSizeMake(320,  frame.size.height-150);

}

@end
