//
//  OSD_Page1.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/19.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "OSD_Page1.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"

@interface OSD_Page1 ()

@end

@implementation OSD_Page1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}
//parameterDatas.OSD_VoltageWarning
- (IBAction)screenUp:(id)sender {
    yumeRCPRemoteControllerParameter *source = [YumeBTSharedInstance valueForKeyPath:@"parameterDatas.OSD_ScreenVOffSet"];
    source.valueUI = source.valueUI - 1;
}
- (IBAction)screenDown:(id)sender {
    yumeRCPRemoteControllerParameter *source = [YumeBTSharedInstance valueForKeyPath:@"parameterDatas.OSD_ScreenVOffSet"];
    source.valueUI = source.valueUI + 1;
}
- (IBAction)screenLeft:(id)sender {
    yumeRCPRemoteControllerParameter *source = [YumeBTSharedInstance valueForKeyPath:@"parameterDatas.OSD_ScreenHOffSet"];
    source.valueUI = source.valueUI - 1;
}
- (IBAction)screenRight:(id)sender {
    yumeRCPRemoteControllerParameter *source = [YumeBTSharedInstance valueForKeyPath:@"parameterDatas.OSD_ScreenHOffSet"];
    source.valueUI = source.valueUI + 1;
}

@end
