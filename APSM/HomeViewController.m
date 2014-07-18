//
//  HomeViewController.m
//  test
//
//  Created by ALIGN-APP on 2014/5/28.
//  Copyright (c) 2014年 ALIGN-APP. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews
{
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(gotoNextPage) userInfo:nil repeats:NO];
}

-(void)gotoNextPage{
    
    BOOL licensed = [[NSUserDefaults standardUserDefaults]boolForKey:@"licensed"];
    if (licensed) {
        id vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
        [self presentViewController:vc animated:NO completion:^{
            //
        }];
    }else{
        id vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LicensePageViewController"];
        [self presentViewController:vc animated:NO completion:^{
            //
        }];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
