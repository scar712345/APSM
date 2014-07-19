//
//  ViewSource.m
//  APSM
//
//  Created by APP559 on 2014/7/19.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "ViewSource.h"

@implementation ViewSource

+(ViewSource*) sharedInstance{
    static ViewSource *sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [ViewSource new];
    });
    
    return sharedInstance;
}
#pragma mark - APSM Page 1

-(NSDictionary*)APSMPage1View21{
    return @{@"labelTitle":@"AIL",
             @"labelLeft":@"Left",
             @"labelRight":@"Right"};
}

-(NSDictionary*)APSMPage1View22{
    return @{@"labelTitle":@"ELE",
             @"labelLeft":@"Up",
             @"labelRight":@"Down"};
}

-(NSDictionary*)APSMPage1View23{
    return @{@"labelTitle":@"RUD",
             @"labelLeft":@"Left",
             @"labelRight":@"Right"};
}

-(NSDictionary*)APSMPage1View24{
    return @{@"labelTitle":@"THR",
             @"labelLeft":@"Idle",
             @"labelRight":@"Full"};
}

-(NSDictionary*)APSMPage1View31{
    return @{@"itemArray":@[@"MANUAL",@"ATTITUDE",@"GPS"]};
}

-(NSDictionary*)APSMPage1View32{
    return @{@"itemArray":@[@"SMART",@"OFF"]};
}

-(NSDictionary*)APSMPage1View33{
    return @{@"itemArray":@[@"HOME",@"OFF"]};
}

-(NSDictionary*)APSMPage1View34{
    return @{@"itemArray":@[@"ON",@"OFF"]};
}

#pragma mark - APSM Page 2
#pragma mark - APSM Page 3

-(NSDictionary*)APSMPage3View2{
    return @{@"viewTitle":@"低電壓返航保護裝置",
             @"viewContent1":@"電壓低於",
             @"viewContent2":@"飛行器執行返回Home點"};
}

-(NSDictionary*)APSMPage3View3{
    return @{@"viewTitle":@"低電壓警示燈閃爍提醒",
             @"viewContent1":@"電壓低於",
             @"viewContent2":@"飛行器警示燈閃爍提醒"};
}

-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
