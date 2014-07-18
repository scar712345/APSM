//
//  yumeRCPRemoteControllerParameter.h
//  BT_Central
//
//  Created by APP559 on 2014/4/29.
//  Copyright (c) 2014年 Yume. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface yumeRCPRemoteControllerParameter : NSObject
@property (nonatomic) float valueMCU;
@property (nonatomic) float valueUI;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

//-(void)setValueToDefualt;
@end
