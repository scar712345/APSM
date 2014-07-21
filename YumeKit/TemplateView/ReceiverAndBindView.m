//
//  ReceiverAndBindView.m
//  APSM
//
//  Created by ALIGN-APP on 2014/7/17.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "ReceiverAndBindView.h"
@interface ReceiverAndBindView()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *labelReceiver;
@property (weak, nonatomic) IBOutlet UILabel *labelBinding;
@property (weak, nonatomic) IBOutlet UIButton *btnReceiver;
@property (weak, nonatomic) IBOutlet UIButton *btnBinding;

@end

@implementation ReceiverAndBindView

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
    self.view.backgroundColor = [UIColor clearColor];
    
    [self processViewSource];
    
    [self processFuture];

    [self.btnReceiver setTitle:[NSString stringWithFormat:@"%@",self.btnReceiverText] forState:UIControlStateNormal];
    [self.btnBinding setTitle:[NSString stringWithFormat:@"%@",self.btnBindingText] forState:UIControlStateNormal];

}

-(void)processFuture{

}

-(void)processViewSource{
    if (_labelReceiverText) {
        self.labelReceiver.text = self.labelReceiverText;
    }
    
    if (_labelBindingText) {
        self.labelBinding.text = self.labelBindingText;
    }
}

-(id)debugQuickLookObject{
    return self;
}

#pragma mark - Button Method 

- (IBAction)btnReceiverAction:(id)sender {
    NSLog(@"btnReceiver be check");
}
- (IBAction)btnBindingAction:(id)sender {
    NSLog(@"btnBinding be check");
}

@end
