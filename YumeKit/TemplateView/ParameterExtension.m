//
//  abc.m
//  APSM
//
//  Created by APP559 on 2014/7/18.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "ParameterExtension.h"
#import <objc/runtime.h>

@implementation UITextField(Yume)
@dynamic parameter;

-(void)setParameter:(NSString *)parameter{
    objc_setAssociatedObject(self, @selector(parameter), parameter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)parameter{
    return objc_getAssociatedObject(self, @selector(parameter));
}

@end

@implementation UIStepper(Yume)
@dynamic parameter;
@dynamic label;

-(void)setParameter:(NSString *)parameter{
    objc_setAssociatedObject(self, @selector(parameter), parameter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)parameter{
    return objc_getAssociatedObject(self, @selector(parameter));
}


-(void)setLabel:(NSString *)label{
    objc_setAssociatedObject(self, @selector(label), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)label{
    return objc_getAssociatedObject(self, @selector(label));
}
@end

