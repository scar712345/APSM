//
//  CustomViewTemplate.m
//  APSM
//
//  Created by APP559 on 2014/7/28.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "CustomViewTemplate.h"
#import "ViewSource.h"

@implementation CustomViewTemplate

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
    
//    NSBundle *p = [NSBundle bundleWithIdentifier:@"com.Align.YumeKit"];
    
    UINib *nib = [UINib nibWithNibName:nibName bundle:YUME_KIT_BUNDLE];
    
    [nib instantiateWithOwner:self options:nil];
}

-(void)prepareForInterfaceBuilder{
    [self viewLiveRendering];
}


- (void)drawRect:(CGRect)rect{
#ifndef TARGET_INTERFACE_BUILDER
    [self viewLiveRendering];
#endif
    
    self.layer.borderColor = _borderColor.CGColor;
    self.layer.borderWidth = _borderLineWidth;
    
    if( [self.layer respondsToSelector:@selector(setCornerRadius:)] )
        [self.layer setCornerRadius:_borderRadius];
}

-(void)viewLiveRendering{
    
    if ([self respondsToSelector:@selector(processViewSource)]) {
        if (_viewSourceKeyPath) {
            _viewSourceDictionary =  [ViewSourceInstance valueForKey:_viewSourceKeyPath];
            
            NSString *type = _viewSourceDictionary[@"type"];
            NSString *className = NSStringFromClass([self class]);
            
            if ([className isEqualToString:type]) {
                [self processViewSource];
            }
        }
    }
    
    if ([self respondsToSelector:@selector(processStoryBoardSource)]) {
        [self processStoryBoardSource];
    }
    
    if ([self respondsToSelector:@selector(processFuture)]) {
        [self processFuture];
    }
    
}

-(id)debugQuickLookObject{
    return self;
}

@end
