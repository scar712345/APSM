//
//  TemplateView2.m
//  APSM
//
//  Created by APP559 on 2014/6/16.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "TemplateView2.h"

@interface TemplateView2()<UIAlertViewDelegate>
{
    yumeAdapter MCUToUI;
    yumeAdapter UIToMCU;
    
    UIAlertController *changeAlert;
}
@end

@implementation TemplateView2

- (void)awakeFromNib {

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
        
        //Init Methods
        self.buttons = [NSMutableArray new];
        self.images = [NSMutableArray new];
        
//        Outside Set
//        self.images = [@[@"pic_Blade-Direction_001(172x172).png",
//                    @"pic_Blade-Direction_002(172x172).png",
//                    @"pic_pitdirection_001(172x172).png",
//                    @"pic_pitdirection_002(172x172).png"] mutableCopy];
        self.buttonSize = CGSizeMake(133, 133);
        self.buttonInitialX = 10;
        self.buttonMargin = 5;
        self.buttonSelect = 0;
        self.hasChangeAlert = NO;
    }
    return self;
}

- (void)selectButtonWithButtonIndex:(NSInteger)index{
    [self selectButton:self.buttons[index]];
}

- (void)selectButtonAndSend:(UIButton*)sender {
    if (sender.tag == self.buttonSelect) {
        return;
    }
    
    if (self.hasChangeAlert) {
//        changeAlert = [[UIAlertView alloc] initWithTitle:@"title" message:@"message" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
//        [changeAlert show];
        
        
        if (self.viewController) {
            changeAlert = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertController* __weak weakAlert = changeAlert;
            UIAlertAction *alertActionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                [weakAlert dismissViewControllerAnimated:YES completion:nil];
                UITextField *t = [[weakAlert textFields] firstObject];
                DLog(@"%@",t.text);
            }];
            UIAlertAction *alertActionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                DLog(@"%@",action);
            }];
            UIAlertAction *alertActionTest = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [weakAlert dismissViewControllerAnimated:YES completion:nil];
                UITextField *t = [[weakAlert textFields] firstObject];
                DLog(@"%@",t.text);
            }];
            [weakAlert addAction:alertActionOk];
            [weakAlert addAction:alertActionCancel];
            [weakAlert addAction:alertActionTest];
            [weakAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = @"pls";
            }];
    
            [self.viewController presentViewController:weakAlert animated:YES completion:nil];
        }
    }else{
        [self selectButton:sender];
#warning TODO Send value to MCU
        //TODO
    }
}

- (IBAction)selectButton:(UIButton*)sender {
    
    self.buttonSelect = sender.tag;
    
    [self.buttons enumerateObjectsUsingBlock:^(UIButton* obj, NSUInteger idx, BOOL *stop) {
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
    
    NSInteger mcu = UIToMCU(sender.tag);
    
    DLog(@"mcu %ld",(long)mcu);
}

-(void)setAdapterWithUIToMCU:(yumeAdapter)toMCU WithMCUToUI:(yumeAdapter)toUI{
    static dispatch_once_t onceTokenUIToMCU;
    static dispatch_once_t onceTokenMCUToUI;
    
    if (toMCU) {
        dispatch_once(&onceTokenUIToMCU, ^{
            UIToMCU = toMCU;
        });
    }
    
    if (toUI) {
        dispatch_once(&onceTokenMCUToUI, ^{
            MCUToUI = toUI;
        });
    }
}

-(void)present{
    
    if (self.images.count == 0) {
        return;
    }
    
    static dispatch_once_t onceTokenPresent;
    dispatch_once(&onceTokenPresent, ^{
        yumeAdapter toUI = ^NSInteger(NSInteger valueMCU) {
            return valueMCU;
        };
        yumeAdapter toMCU = ^NSInteger(NSInteger valueUI) {
            return valueUI;
        };
        [self setAdapterWithUIToMCU:toMCU WithMCUToUI:toUI];
        
        for (int index = 0;index < self.images.count;index++) {
            CGRect frame = CGRectMake(self.buttonInitialX + index * (self.buttonSize.width + self.buttonMargin), 0, self.buttonSize.width, self.buttonSize.height);
            UIButton *button = [[UIButton alloc]initWithFrame:frame];
            [button setBackgroundImage:[UIImage imageNamed:self.images[index]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(selectButtonAndSend:) forControlEvents:UIControlEventTouchUpInside];
            button.alpha = 0.5;
            button.tag = index;
            [self.buttons addObject:button];
            [self.scrollView addSubview:button];
        }
        
        [self selectButtonWithButtonIndex:MCUToUI(_buttonSelect)];
        
        UIButton *lastButton = [self.buttons lastObject];
        self.scrollView.contentSize = CGSizeMake(lastButton.frame.origin.x + lastButton.frame.size.width, lastButton.frame.size.height);
    });
}

@end
