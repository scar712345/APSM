//
//  TemplateView2.h
//  APSM
//
//  Created by APP559 on 2014/6/16.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSInteger(^yumeAdapter)(NSInteger value);

@interface TemplateView2 : UIView
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) NSMutableArray *buttons;

@property (nonatomic) CGSize buttonSize;
@property (nonatomic) CGFloat buttonInitialX;
@property (nonatomic) CGFloat buttonMargin;
@property (nonatomic) NSInteger buttonSelect;
@property (nonatomic) BOOL hasChangeAlert;

@property (nonatomic,weak) IBOutlet id viewController;

- (id)initWithCoder:(NSCoder *)aDecoder;

-(void)present;
-(void)setAdapterWithUIToMCU:(yumeAdapter)toMCU WithMCUToUI:(yumeAdapter)toUI;

- (IBAction)selectButton:(UIButton*)sender;
@end
