//
//  yumeDeviceListAlertTableView.m
//  test
//
//  Created by APP559 on 2014/5/12.
//  Copyright (c) 2014年 APP559. All rights reserved.
//

#import "yumeDeviceListAlertTableView.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "yumeBTLERemoteController.h"
#import "yumeLanguage.h"

//#define NSLocalizedString(key, comment) \
//[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

//#undef NSLocalizedString//()
//#define  NSLocalizedString(key,comment) [Language get:(key) alter:nil]

@interface yumeDeviceListAlertTableView()<UITableViewDelegate,UITableViewDataSource>{
    UILabel *label;
    NSTimer *timer;
    NSArray *array;
    UIView *views;
}

@end

@implementation yumeDeviceListAlertTableView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
//#warning Set delegate to self
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    
    if (self) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width-100, 150)];
        self.tableView.backgroundColor=[UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenSize.width-100, 150)];
        label.text = NSLocalizedString(@"No device found", nil);
        label.textAlignment = NSTextAlignmentCenter;
        
        views = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width-100, 150)];
        [views addSubview:_tableView];
        [views addSubview:label];
    }
    return self;
}

- (void)show{
    timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                             target: self
                                           selector: @selector(handleTimer:)
                                           userInfo: nil
                                            repeats: YES];
    
    [self setValue:views forKey:@"accessoryView"];

    [super show];
}

#pragma mark - Timer

- (void) handleTimer: (NSTimer *) timer
{
    [self.tableView reloadData];
}

#pragma mark - Alert View

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [[yumeBTLERemoteController sharedInstance] stopScan];
        [timer invalidate];
    }
}

#pragma mark - Tabel View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    array=[[yumeBTLERemoteController sharedInstance] loadPeripherals];
    
    CGFloat viewX,viewY,viewWidth,viewHeight;
    viewX = 0;
    viewY = 0;
    viewWidth = [UIScreen mainScreen].bounds.size.width - 100;
    viewHeight = [UIScreen mainScreen].bounds.size.height;
    
    if (array.count == 0 && self.tableView.alpha == 1) {
        [UIView animateKeyframesWithDuration:0.5
                                       delay:0.1
                                     options:UIViewKeyframeAnimationOptionAllowUserInteraction
                                  animations:^{
                                      self.tableView.alpha = 0;
                                      label.alpha = 1;
        }
                                  completion:nil];
        
    }else if(array.count != 0 && label.alpha == 1){
        
        [UIView animateKeyframesWithDuration:0.3
                                       delay:0
                                     options:UIViewKeyframeAnimationOptionAllowUserInteraction
                                  animations:^{
                                      label.alpha = 0;
                                      label.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight);
                                      self.tableView.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight);
                                  }
                                  completion:^(BOOL finished) {
                                      self.tableView.alpha = 1;
                                  }];
        
        [UIView animateKeyframesWithDuration:0.3
                                       delay:0.3
                                     options:UIViewKeyframeAnimationOptionAllowUserInteraction
                                  animations:^{
                                      self.tableView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
                                  }
                                  completion:^(BOOL finished) {
                                      
                                  }];
        
    }
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CBPeripheral *peripheral = array[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",peripheral.name];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[yumeBTLERemoteController sharedInstance] connectToPeripheralWithIndex:indexPath.row];
    [[yumeBTLERemoteController sharedInstance] stopScan];
    [self dismissWithClickedButtonIndex:0 animated:YES];
    [timer invalidate];
}

@end
