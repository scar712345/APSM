//
//  TemplateView1.m
//  APSM
//
//  Created by APP559 on 2014/6/16.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "TemplateView1.h"
//#import <ReactiveCocoa.h>
//#import <ReactiveCocoa/RACEXTScope.h>

#define SLIDER_WAIT_INTERVAL 0.1

@interface TemplateView1()
{
    double viewDefaultValue;
    NSDate *beginTime;
}
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *labelMain;
@property (weak, nonatomic) IBOutlet UILabel *labelLeft;
@property (weak, nonatomic) IBOutlet UILabel *labelRight;
@property (weak, nonatomic) IBOutlet UILabel *labelMin;
@property (weak, nonatomic) IBOutlet UILabel *labelDefault;
@property (weak, nonatomic) IBOutlet UILabel *labelMax;
@property (weak, nonatomic) IBOutlet UILabel *labelViewValue;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;

//@property (strong, nonatomic) RACSignal *sliderSignal;
//@property (strong, nonatomic) RACSignal *stepperSignal;
@end

@implementation TemplateView1

- (void)awakeFromNib {
//    _labelDefault.text = @"111";
//    labelTitle.text = vTitle;
//    labelLeftTitle.text = vLeftTitle;
//    labelRightTitle.text = vRightTitle;
//    labelNumber.text = [NSString stringWithFormat:@" %0.f",[vDefault floatValue]];
//    
    [_stepper setMinimumValue:[@0 doubleValue]];
    [_stepper setMaximumValue:[@100 doubleValue]];
    [_stepper setStepValue:1];

    _slider.minimumValue = [@0 floatValue];
    _slider.maximumValue = [@100 floatValue];
    
//    [self setViewValue:[vDefault floatValue]];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"HA! caught you trying to set undefined key %@ to %@",key,value);
}

- (void) setup{
    NSString *nibName = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    [nib instantiateWithOwner:self options:nil];
    //Add the view loaded from the nib into self.
    [self addSubview:self.view];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
        
        self.layer.borderColor = [UIColor grayColor].CGColor ;
        self.layer.borderWidth = 3.0f;
        
        if( [self.layer respondsToSelector:@selector(setCornerRadius:)] )
            [self.layer setCornerRadius:10];
        
        beginTime = [NSDate date];

//        self.sliderSignal = [self.slider rac_signalForControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventValueChanged];
//        [[self.sliderSignal filter:^BOOL(id value) {
//            NSDate *currentTime = [NSDate date];
//            NSTimeInterval interval = [currentTime timeIntervalSinceDate:beginTime];
//            if (interval > SLIDER_WAIT_INTERVAL) {
//                beginTime = currentTime;
//                return YES;
//            }else{
//                return NO;
//            }
//        }]subscribeNext:^(UISlider* sender) {
//            int progresAsInt = (int)( sender.value +0.5f);
//            [self setViewValue:progresAsInt];
//        }];
//         
//        
//        self.stepperSignal = [self.stepper rac_signalForControlEvents:UIControlEventValueChanged];
//        [self.stepperSignal subscribeNext:^(UIStepper* sender) {
//            int progresAsInt = (int)( sender.value +0.5f);
//            [self setViewValue:progresAsInt];
//        }];
    }
    return self;
}

-(void)dealloc{
//    self.sliderSignal = nil;
}


#pragma mark - View Method

-(void)setViewValue:(float)value{
    _slider.value = value;
    _stepper.value = value;
    _labelViewValue.text = [NSString stringWithFormat:@" %0.f",value];
}

-(void)setViewValueWithDelegate:(float)value{
    [self setViewValue:value];
//    [self.delegate TemplateView:self WithValueChange:value];
}

-(void)resetViewValue{
    [self setViewValue:viewDefaultValue];
}


#pragma mark - Slider Event

- (IBAction)sliderValueChange:(UISlider*)sender {
//    NSDate *currentTime = [NSDate date];
//    NSTimeInterval interval = [currentTime timeIntervalSinceDate:beginTime];
//    if (interval > SLIDER_WAIT_INTERVAL) {
//        beginTime = currentTime;
//    }else{
//        return;
//    }
//    
//    int progresAsInt = (int)( sender.value +0.5f);
//    [self setViewValue:progresAsInt];
}

- (IBAction)sliderTouchUp:(UISlider*)sender {
////    NSLog(@"touch end");
//    
//    int progresAsInt = (int)( sender.value +0.5f);
//    [self setViewValue:progresAsInt];
}


//- (void)sliderTapped:(UIGestureRecognizer *)gestureRecognizer
//{
//    UISlider* s = (UISlider*)gestureRecognizer.view;
//    if (s.highlighted)
//        return;
//    CGPoint pt = [gestureRecognizer locationInView: s];
//    CGFloat percentage = pt.x / s.bounds.size.width;
//    CGFloat delta = percentage * (s.maximumValue - s.minimumValue);
//    CGFloat value = s.minimumValue + delta;
//    [s setValue:value animated:YES];
//    int progresAsInt = (int)(_slider.value +0.5f);
//    [self setViewValue:progresAsInt];
//}

#pragma mark - Stepper Event

- (IBAction)stepperValueChange:(UIStepper*)sender {
//    int progresAsInt = (int)( sender.value +0.5f);
//    [self setViewValue:progresAsInt];
}




@end
