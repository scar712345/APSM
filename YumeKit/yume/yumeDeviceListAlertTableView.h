//
//  yumeDeviceListAlertTableView.h
//  test
//
//  Created by APP559 on 2014/5/12.
//  Copyright (c) 2014年 APP559. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface yumeDeviceListAlertTableView : UIAlertView
@property (nonatomic, strong) UITableView *tableView;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;
@end
