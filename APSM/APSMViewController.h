//
//  APSMViewController.h
//  APSM
//
//  Created by APP559 on 2014/7/16.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Page.h"

@interface APSMViewController : Page
@property (weak, nonatomic) IBOutlet UILabel *labelDevice;

-(void)setLabelDeviceText:(NSString*)text;

-(void)lockButtonWhenConnected;
-(void)lockButtonWhenDisconnect;
@end
