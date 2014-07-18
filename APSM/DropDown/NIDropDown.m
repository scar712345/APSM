//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"
#import "Language.h"
@interface NIDropDown ()
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, retain) NSArray *list;
@end

@implementation NIDropDown
@synthesize table;
@synthesize btnSender;
@synthesize list;
@synthesize delegate;

- (id)initShowDropDown:(UIButton *)b WithHeight:(CGFloat *)height WithArray:(NSArray *)arr{
    btnSender = b;
    self = [super init];
    if (self) {
        // Initialization code
        CGRect btn = b.frame;
        
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
        self.list = [NSArray arrayWithArray:arr];
        self.layer.masksToBounds = NO;//顯示邊線
        self.layer.cornerRadius = 8;//圓角
        self.layer.shadowOffset = CGSizeMake(-5, 5);//陰影位置
        self.layer.shadowRadius = 5;//清單陰影
        self.layer.shadowOpacity = 0.5;//邊線陰影
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        table.delegate = self;
        table.dataSource = self;
        table.layer.cornerRadius = 5;
        table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.separatorColor = [UIColor grayColor];//分隔線顏色
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];//展開速度
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, *height);
        table.frame = CGRectMake(0, 0, btn.size.width, *height);
        [UIView commitAnimations];
        
        [b.superview addSubview:self];
        [self addSubview:table];
        
        self.isPage28 = NO;
    }
    return self;
}

-(void)hideDropDown:(UIButton *)b {
    CGRect btn = b.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];//收合速度
    self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
    table.frame = CGRectMake(0, 0, btn.size.width, 0);
    [UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;//table cell高度
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}   


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text =[list objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];//清單文字顏色
    
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor grayColor];//選取後清單變色
    cell.selectedBackgroundView = v;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isPage28 && indexPath.row == 1) {
        UIAlertView *alert= [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning",nil)
                                                       message:NSLocalizedString(@"GovernorModeWarning",nil)
                                                      delegate:self
                                             cancelButtonTitle:NSLocalizedString(@"No",nil)
                                             otherButtonTitles:NSLocalizedString(@"Yes",nil), nil];
        [alert show];
        [self myDelegate];
    }else{
        [self hideDropDown:btnSender];
        UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
        [btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
        _index = indexPath.row;
        
        [self myDelegate];
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self hideDropDown:btnSender];
    if (buttonIndex==1) {
//        UITableViewCell *c = [table cellForRowAtIndexPath:indexPath];
        [btnSender setTitle:NSLocalizedString(@"ON ",nil) forState:UIControlStateNormal];
        _index = 1;
        
        [self myDelegate];
    }
    
    if (buttonIndex==0) {
        //        UITableViewCell *c = [table cellForRowAtIndexPath:indexPath];
        [btnSender setTitle:NSLocalizedString(@"OFF ",nil) forState:UIControlStateNormal];
        _index = 0;
        
        [self myDelegate];
    }

}

- (void) myDelegate {
    [self.delegate niDropDownDelegateMethod:self];   
}

-(void)dealloc {

}

@end
