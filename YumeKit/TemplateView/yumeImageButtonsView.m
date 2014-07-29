//
//  yumeImageButtonsView.m
//  APSM
//
//  Created by APP559 on 2014/7/15.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "yumeImageButtonsView.h"
#import "yumeBTLERemoteController.h"
#import "yumeRCPRemoteControllerParameter.h"

typedef NSInteger(^yumeAdapter)(NSInteger value);

@interface yumeImageButtonsView ()
@property (strong, nonatomic) yumeAdapter MCUToUI;
@property (strong, nonatomic) yumeAdapter UIToMCU;
@property (strong, nonatomic) NSMutableArray *buttons;
@property (strong, nonatomic) NSMutableArray *images;

@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *viewTitle;

@property (weak, nonatomic) yumeRCPRemoteControllerParameter *buttonsSource;

@end

@implementation yumeImageButtonsView

- (void) setup{
    [super setup];
    [self addSubview:self.view];
    
    _buttons = [NSMutableArray new];
    _images = [NSMutableArray new];
}

-(void)viewLiveRendering{
    [super viewLiveRendering];
    self.view.backgroundColor = [UIColor clearColor];
}

-(void)processFuture{
    if (_buttonsKeyPath) {
        _buttonsSource = [YumeBTSharedInstance valueForKeyPath:_buttonsKeyPath];
        [self selectButtonWithButtonIndex:_MCUToUI(_buttonsSource.valueMCU)];
    }
}

-(void)processViewSource{

    _viewTitle.text = NSLocalizedString(self.viewSourceDictionary[@"viewTitle"], nil);
    _images = self.viewSourceDictionary[@"images"];

    yumeAdapter toUI = self.viewSourceDictionary[@"toUI"];
    yumeAdapter toMCU = self.viewSourceDictionary[@"toMCU"];
    [self setAdapterWithUIToMCU:toMCU WithMCUToUI:toUI];
    
    for (int index = 0;index < _images.count;index++) {
        int row = index % _buttonInRow;
        int column = index /_buttonInRow;
        CGRect frame = CGRectMake(self.buttonBeginPoint.x + row * (self.buttonSize.width + self.buttonMargin),
                                  self.buttonBeginPoint.y + column * (self.buttonSize.height + self.buttonMargin),
                                  self.buttonSize.width,
                                  self.buttonSize.height);
        UIButton *button = [[UIButton alloc]initWithFrame:frame];
        UIImage *image = IMAGE_NAMED(_images[index]);
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectButtonAndSend:) forControlEvents:UIControlEventTouchUpInside];
        button.alpha = 0.5;
        button.tag = index;
        [_buttons addObject:button];
        [self addSubview:button];
    }

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
        _buttonsSource.valueUI = sender.tag;
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
    
//    NSInteger mcu = _UIToMCU(sender.tag);
    
//    DLog(@"mcu %ld",(long)mcu);
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
