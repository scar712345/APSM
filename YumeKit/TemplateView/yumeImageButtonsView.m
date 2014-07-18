//
//  yumeImageButtonsView.m
//  APSM
//
//  Created by APP559 on 2014/7/15.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "yumeImageButtonsView.h"

typedef NSInteger(^yumeAdapter)(NSInteger value);

@interface yumeImageButtonsView ()
@property (strong, nonatomic) yumeAdapter MCUToUI;
@property (strong, nonatomic) yumeAdapter UIToMCU;
@property (strong, nonatomic) NSMutableArray *buttons;
@property (strong, nonatomic) NSMutableArray *images;

@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *viewTitle;

@end

@implementation yumeImageButtonsView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup{
    NSString *nibName = NSStringFromClass([self class]);
    
    NSBundle *p = [NSBundle bundleWithIdentifier:@"com.Align.YumeKit"];
    
    UINib *nib = [UINib nibWithNibName:nibName bundle:p];
    
    [nib instantiateWithOwner:self options:nil];
    //Add the view loaded from the nib into self.
    [self addSubview:self.view];
    
    _buttons = [NSMutableArray new];
    _images = [NSMutableArray new];
//    images = [@[[UIImage imageNamed:@"wing4_1.jpg"],
//               [UIImage imageNamed:@"wing4_2.jpg"],
//               [UIImage imageNamed:@"wing6_1.jpg"],
//               [UIImage imageNamed:@"wing6_2.jpg"],
//               [UIImage imageNamed:@"wing8_1.jpg"],
//               [UIImage imageNamed:@"wing8_2.jpg"]] mutableCopy];
    _images = [@[@"wing4_1.jpg",
               @"wing4_2.jpg",
               @"wing6_1.jpg",
               @"wing6_2.jpg",
               @"wing8_1.jpg",
               @"wing8_2.jpg"] mutableCopy];
}

-(void)prepareForInterfaceBuilder{
    [self viewLiveRendering];
}

- (void)drawRect:(CGRect)rect{
    self.layer.borderColor = _borderColor.CGColor;
    self.layer.borderWidth = _borderLineWidth;
    
    if( [self.layer respondsToSelector:@selector(setCornerRadius:)] )
        [self.layer setCornerRadius:_borderRadius];
    
#ifndef TARGET_INTERFACE_BUILDER
    [self viewLiveRendering];
#endif
}

-(void)viewLiveRendering{
    
    yumeAdapter toUI = ^NSInteger(NSInteger valueMCU) {
        return valueMCU;
    };
    yumeAdapter toMCU = ^NSInteger(NSInteger valueUI) {
        return valueUI;
    };
    [self setAdapterWithUIToMCU:toMCU WithMCUToUI:toUI];
    
    for (int index = 0;index < _images.count;index++) {
        int row = index % _buttonInRow;
        int column = index /_buttonInRow;
        CGRect frame = CGRectMake(self.buttonBeginPoint.x + row * (self.buttonSize.width + self.buttonMargin),
                                  self.buttonBeginPoint.y + column * (self.buttonSize.height + self.buttonMargin),
                                  self.buttonSize.width,
                                  self.buttonSize.height);
        UIButton *button = [[UIButton alloc]initWithFrame:frame];
//        UIImage *image = [UIImage imageNamed:images[index]];
        UIImage *image = [UIImage imageNamed:_images[index] inBundle:[NSBundle bundleWithIdentifier:@"com.Align.YumeKit"] compatibleWithTraitCollection:nil];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectButtonAndSend:) forControlEvents:UIControlEventTouchUpInside];
        button.alpha = 0.5;
        button.tag = index;
        [_buttons addObject:button];
        [self addSubview:button];
    }
    
    [self selectButtonWithButtonIndex:_MCUToUI(_buttonSelected)];
}

-(id)debugQuickLookObject{
    return self;
}

#pragma mark - methods

- (void)selectButtonWithButtonIndex:(NSInteger)index{
    [self selectButton:self.buttons[index]];
}

- (void)selectButtonAndSend:(UIButton*)sender {
    if (sender.tag == _buttonSelected) {
        return;
    }
    
    if (self.hasChangeAlert) {
        
    }else{
        [self selectButton:sender];
    }
}

- (IBAction)selectButton:(UIButton*)sender {
    
    _buttonSelected = sender.tag;
    
    [_buttons enumerateObjectsUsingBlock:^(UIButton* obj, NSUInteger idx, BOOL *stop) {
        [self lowlightButton:obj];
    }];
    
    [self highlightButton:sender];
}

-(void)lowlightButton:(UIButton*)sender{
    [[sender layer] setBorderColor:[UIColor clearColor].CGColor];
    sender.alpha=0.5;
}

-(void)highlightButton:(UIButton*)sender{
    [[sender layer] setBorderColor:[UIColor blueColor].CGColor];
    sender.alpha=1;
    [[sender layer] setBorderWidth:4.0f];
    
    NSInteger mcu = _UIToMCU(sender.tag);
    
    DLog(@"mcu %ld",(long)mcu);
}

-(void)setAdapterWithUIToMCU:(yumeAdapter)toMCU WithMCUToUI:(yumeAdapter)toUI{
//    static dispatch_once_t onceTokenUIToMCU;
//    static dispatch_once_t onceTokenMCUToUI;
//    
//    if (toMCU) {
//        dispatch_once(&onceTokenUIToMCU, ^{
            _UIToMCU = toMCU;
//        });
//    }
//    
//    if (toUI) {
//        dispatch_once(&onceTokenMCUToUI, ^{
            _MCUToUI = toUI;
//        });
//    }
}

@end
