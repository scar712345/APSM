//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NIDropDown;
@protocol NIDropDownDelegate
- (void) niDropDownDelegateMethod: (NIDropDown *) sender;
@end 

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) id <NIDropDownDelegate> delegate;

-(void)hideDropDown:(UIButton *)b;
- (id)initShowDropDown:(UIButton *)b WithHeight:(CGFloat *)height WithArray:(NSArray *)arr;
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, readonly)NSInteger index;
@property(nonatomic)BOOL isPage28;
@end
